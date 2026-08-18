-- ftp.yazi — FTP as a native Yazi VFS provider, backed by curl.
--
-- vfs.toml:
--   [ftp."*"]
--   kind = "mount"
--   run  = "ftp"    # options: "ftp --user=U --pass=P --port=2121"
--
-- Usage: cd ftp://<host>/  — the domain is the host. A non-standard port can
-- be set via --port above, or by encoding it into the domain as host%3Aport
-- (`:` is reserved in Yazi URLs). `plugin ftp` prompts for host[:port] & jumps.

local M = {}

-- ===== options =====

local function options(args, domain)
	local host, port = domain, nil
	local i = domain:find(":", 1, true)
	if i then
		host, port = domain:sub(1, i - 1), tonumber(domain:sub(i + 1))
	end
	return {
		host = args.host or host,
		port = tonumber(args.port) or port or 21,
		user = args.user,
		pass = args.pass,
	}
end

-- ===== paths & urls =====

local function upath(url)
	local p = tostring(url.path)
	if p == "" then
		p = "/"
	elseif p:sub(1, 1) ~= "/" then
		p = "/" .. p
	end
	return p
end

local function encode(path)
	return (path:gsub("[^%w%-_%.~/]", function(c) return ("%%%02X"):format(c:byte()) end))
end

local function split(path)
	local parent, name = path:match("^(.-)/*([^/]+)/*$")
	if not name then
		return nil
	end
	return parent == "" and "/" or parent, name
end

-- ===== curl =====

local function curl(o, path, extra)
	local cmd = Command("curl"):arg({ "-sS", "-g", "--connect-timeout", "10" })
	if o.user then
		cmd = cmd:arg({ "-u", o.user .. ":" .. (o.pass or "") })
	end
	if extra then
		cmd = cmd:arg(extra)
	end
	return cmd:arg(("ftp://%s:%d%s"):format(o.host, o.port, encode(path)))
end

local KINDS = {
	[5] = "HostUnreachable",
	[6] = "HostUnreachable",
	[7] = "ConnectionRefused",
	[9] = "NotFound",
	[19] = "NotFound",
	[28] = "TimedOut",
	[67] = "PermissionDenied",
	[78] = "NotFound",
}

local function curl_err(output, action)
	local code = output.status.code or -1
	local msg = (output.stderr or ""):gsub("%s+$", "")
	if msg == "" then
		msg = ("curl exited with code %d"):format(code)
	end
	if KINDS[code] then
		return Error.fs { kind = KINDS[code], message = ("%s: %s"):format(action, msg) }
	end
	return Err("%s: %s", action, msg)
end

local function run(cmd, action)
	local output, err = cmd:stdout(Command.PIPED):stderr(Command.PIPED):output()
	if not output then
		return nil, Err("Failed to spawn `curl`: %s", err)
	elseif not output.status.success then
		return nil, curl_err(output, action)
	end
	return output
end

-- ===== LIST parsing =====

-- stylua: ignore
local MONTHS = {
	jan = 1, feb = 2, mar = 3, apr = 4, may = 5, jun = 6,
	jul = 7, aug = 8, sep = 9, oct = 10, nov = 11, dec = 12,
}

local function parse_time(mon, day, rest)
	local t = { month = MONTHS[mon:lower()], day = tonumber(day), hour = 0, min = 0 }
	local hh, mm = rest:match("^(%d+):(%d+)$")
	if hh then
		t.year, t.hour, t.min = os.date("*t").year, tonumber(hh), tonumber(mm)
		local ts = os.time(t)
		if ts and ts > os.time() + 86400 then
			t.year = t.year - 1
			ts = os.time(t)
		end
		return ts
	end
	t.year = tonumber(rest)
	return t.year and os.time(t) or nil
end

local function parse_line(line)
	line = line:gsub("\r$", "")

	-- MS-DOS style: `01-23-24  05:44PM  <DIR>|1234  name`
	local rest = line:match("^%d%d%-%d%d%-%d%d+%s+%d%d:%d%d[AP]M%s+(.+)$")
	if rest then
		local name = rest:match("^<DIR>%s+(.+)$")
		if name then
			return { name = name, type = "d", size = 0 }
		end
		local size, fname = rest:match("^(%d+)%s+(.+)$")
		if size then
			return { name = fname, type = "-", size = tonumber(size) }
		end
		return
	end

	-- Unix `ls -l` style
	local ty = line:sub(1, 1)
	if not ty:match("[%-dlbcps]") or line:match("^total%s") then
		return
	end

	local toks = {}
	for s, tok in line:gmatch("()(%S+)") do
		toks[#toks + 1] = { s = s, v = tok }
	end

	local idx
	for i = 3, #toks - 3 do
		if
			MONTHS[toks[i].v:lower()]
			and toks[i + 1].v:match("^%d%d?$")
			and (toks[i + 2].v:match("^%d+:%d+$") or toks[i + 2].v:match("^%d%d%d%d$"))
			and toks[i - 1].v:match("^%d+$")
		then
			idx = i
			break
		end
	end
	if not idx or not toks[idx + 3] then
		return
	end

	local ent = {
		name = line:sub(toks[idx + 3].s),
		type = ty,
		size = tonumber(toks[idx - 1].v) or 0,
		mtime = parse_time(toks[idx].v, toks[idx + 1].v, toks[idx + 2].v),
	}
	if ty == "l" then
		local name, target = ent.name:match("^(.-) %-> (.+)$")
		if name then
			ent.name, ent.target = name, target
		end
	end
	if ent.name ~= "." and ent.name ~= ".." then
		return ent
	end
end

-- ===== FTP operations =====

local function cha_of(ent)
	local mode
	if ent.type == "d" then
		mode = tonumber("40755", 8)
	elseif ent.type == "l" then
		mode = tonumber("120777", 8)
	else
		mode = tonumber("100644", 8)
	end
	return Cha {
		mode = mode,
		len = ent.size,
		mtime = ent.mtime,
		kind = ent.name:sub(1, 1) == "." and 2 or 0, -- ChaKind::HIDDEN
	}
end

local function list_dir(o, path)
	if path:sub(-1) ~= "/" then
		path = path .. "/"
	end
	local output, err = run(curl(o, path), "list " .. path)
	if not output then
		return nil, err
	end

	local ents = {}
	for line in output.stdout:gmatch("[^\n]+") do
		local ent = parse_line(line)
		if ent then
			ents[#ents + 1] = ent
		end
	end
	return ents
end

local function stat(o, path)
	if path == "/" then
		return { name = "/", type = "d", size = 0 }
	end
	local parent, name = split(path)
	if not parent then
		return nil, Err("Invalid path: %s", path)
	end

	local ents, err = list_dir(o, parent)
	if not ents then
		return nil, err
	end
	for _, ent in ipairs(ents) do
		if ent.name == name then
			return ent
		end
	end
	return nil, Error.fs { kind = "NotFound", message = ("No such file: %s"):format(path) }
end

local function upload(o, path, bytes, append)
	local extra = append and { "-T", "-", "--append" } or { "-T", "-" }
	local child, err =
		curl(o, path, extra):stdin(Command.PIPED):stdout(Command.PIPED):stderr(Command.PIPED):spawn()
	if not child then
		return false, Err("Failed to spawn `curl`: %s", err)
	end

	if #bytes > 0 then
		local ok, werr = child:write_all(bytes)
		if ok then
			ok, werr = child:flush()
		end
		if not ok then
			child:start_kill()
			return false, Err("Failed to feed curl: %s", werr)
		end
	end

	local output, werr = child:wait_with_output()
	if not output then
		return false, Err("Failed to wait for curl: %s", werr)
	elseif not output.status.success then
		return false, curl_err(output, "upload " .. path)
	end
	return true
end

-- `-Q` runs the command after login but before the transfer; the parent NLST
-- is just a cheap vehicle. curl exit 21 means the quote command itself failed;
-- transfer-phase exits (9/19/78) mean only the vehicle listing failed after
-- the quote already succeeded, so they are ignored.
local function quote(o, vehicle, action, cmds)
	if vehicle:sub(-1) ~= "/" then
		vehicle = vehicle .. "/"
	end
	local extra = { "--list-only" }
	for _, c in ipairs(cmds) do
		extra[#extra + 1] = "-Q"
		extra[#extra + 1] = c
	end

	local output, err = curl(o, vehicle, extra):stdout(Command.PIPED):stderr(Command.PIPED):output()
	if not output then
		return false, Err("Failed to spawn `curl`: %s", err)
	end

	local code = output.status.code or -1
	if output.status.success or code == 9 or code == 19 or code == 78 then
		return true
	end
	return false, curl_err(output, action)
end

local function remove_dir_all(o, path)
	local ents, err = list_dir(o, path)
	if not ents then
		return false, err
	end
	for _, ent in ipairs(ents) do
		local child = (path:sub(-1) == "/" and path or path .. "/") .. ent.name
		local ok
		if ent.type == "d" then
			ok, err = remove_dir_all(o, child)
		else
			ok, err = quote(o, path, "remove " .. child, { "DELE " .. child })
		end
		if not ok then
			return false, err
		end
	end
	local parent = split(path) or "/"
	return quote(o, parent, "rmdir " .. path, { "RMD " .. path })
end

-- ===== provider =====

local function absolute(url)
	if url.is_absolute then
		return fs.clean_url(url)
	end
	local cwd, err = fs.cwd()
	if not cwd then
		return nil, err
	end
	local root = cwd.path
	while root.parent do
		root = root.parent
	end
	return fs.clean_url(url:join(root:join(url.path)))
end

function M:provide(job)
	local op = job.op
	if op == "Capabilities" then
		return { symlink = false, hard_link = false, trash = false, copy_progressive = false }
	elseif op == "Absolute" or op == "Canonicalize" then
		return absolute(job.url)
	elseif op == "Casefold" then
		return job.url
	end

	local anchor = job.url or job.from or (job.file and job.file.url)
	local o = options(job.args, tostring(anchor.spec.domain))

	if op == "Metadata" or op == "SymlinkMetadata" then
		local ent, err = stat(o, upath(job.url))
		if not ent then
			return nil, err
		end
		return cha_of(ent)
	elseif op == "ReadDir" then
		local ents, err = list_dir(o, upath(job.url))
		if not ents then
			return nil, err
		end
		for i, ent in ipairs(ents) do
			local cha = cha_of(ent)
			ents[i] = { cha = cha, file = File { url = job.url:join(ent.name), cha = cha } }
		end
		return ents
	elseif op == "File" then
		local ent, err = stat(o, upath(job.url))
		if not ent then
			return nil, err
		end
		return File { url = job.url, cha = cha_of(ent) }
	elseif op == "Revalidate" then
		local ent, err = stat(o, upath(job.file.url))
		if not ent then
			return nil, err
		end
		return File { url = job.file.url, cha = cha_of(ent) }
	elseif op == "Open" then
		local path, d = upath(job.url), job.demand
		local ent, err = stat(o, path)
		if not ent and err and err.kind ~= "NotFound" then
			return nil, err
		elseif ent and d.create_new then
			return nil, Error.fs { kind = "AlreadyExists", message = path .. " already exists" }
		elseif not ent and not (d.create or d.create_new) then
			return nil, err
		end

		if (d.write and d.truncate) or (not ent and (d.create or d.create_new)) then
			local ok, uerr = upload(o, path, "", false)
			if not ok then
				return nil, uerr
			end
			ent = { size = 0 }
		end
		return d.append and (ent and ent.size or 0) or 0
	elseif op == "Read" then
		if job.len == 0 then
			return ""
		end
		local range = ("%d-%d"):format(job.offset, job.offset + job.len - 1)
		local output, err = run(curl(o, upath(job.url), { "-r", range }), "read " .. upath(job.url))
		if output then
			return output.stdout
		elseif err.kind == "NotFound" and job.offset > 0 then
			return "" -- REST beyond EOF; at offset 0 a NotFound is a real error
		end
		return nil, err
	elseif op == "Write" then
		-- FTP has no random access: offset 0 replaces, anything else appends.
		-- Verify the remote size first so a retry after a partial append fails
		-- loudly instead of silently duplicating bytes.
		local path = upath(job.url)
		if job.offset == 0 then
			return upload(o, path, job.bytes, false)
		end
		local ent, err = stat(o, path)
		if not ent then
			return false, err
		elseif ent.size ~= job.offset then
			return false,
				Error.fs {
					kind = "InvalidData",
					message = ("remote size %d != write offset %d; refusing to append"):format(ent.size, job.offset),
				}
		end
		return upload(o, path, job.bytes, true)
	elseif op == "CreateDir" then
		local path = upath(job.url)
		local parent = split(path) or "/"
		return quote(o, parent, "mkdir " .. path, { "MKD " .. path })
	elseif op == "RemoveFile" then
		local path = upath(job.url)
		local parent = split(path) or "/"
		return quote(o, parent, "remove " .. path, { "DELE " .. path })
	elseif op == "RemoveDir" then
		local path = upath(job.url)
		local parent = split(path) or "/"
		return quote(o, parent, "rmdir " .. path, { "RMD " .. path })
	elseif op == "RemoveDirAll" then
		return remove_dir_all(o, upath(job.url))
	elseif op == "Rename" then
		local from, to = upath(job.from), tostring(job.to)
		local parent = split(from) or "/"
		return quote(o, parent, "rename " .. from, { "RNFR " .. from, "RNTO " .. to })
	elseif op == "Copy" then
		local from, to = upath(job.from), tostring(job.to)
		local output, err = run(curl(o, from), "read " .. from)
		if not output then
			return nil, err
		end
		local ok, uerr = upload(o, to, output.stdout, false)
		if not ok then
			return nil, uerr
		end
		return #output.stdout
	elseif op == "ReadLink" then
		local ent, err = stat(o, upath(job.url))
		if not ent then
			return nil, err
		elseif not ent.target then
			return nil, Error.fs { kind = "InvalidInput", message = "Not a symlink" }
		end
		return Path.os(ent.target)
	elseif op == "SetAttrs" then
		return true -- not supported over FTP; report success so transfers complete
	elseif op == "SetLen" then
		if job.size == 0 then
			return upload(o, upath(job.url), "", false)
		end
		return true -- preallocation hint; sequential writes set the real length
	end

	return false, Err("Unsupported FTP operation: %s", op)
end

-- ===== entry: `plugin ftp [-- host[:port]]` prompts & jumps =====

function M:entry(job)
	local host = job.args[1]
	if not host then
		local value, event = ya.input {
			title = "FTP host[:port]:",
			pos = { "center", w = 40 },
		}
		if event ~= 1 or not value or value == "" then
			return
		end
		host = value
	end
	-- `:` is reserved in Yazi URLs; keep it out of the raw domain
	ya.emit("cd", { Url("ftp://" .. host:gsub(":", "%%3A") .. "/") })
end

return M
