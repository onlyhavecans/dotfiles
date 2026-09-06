-- new-folder-from-files.yazi — Finder/Nautilus "New Folder with Selection":
-- prompt for a name, create the folder in the cwd, move the selected files
-- into it, then hover the new folder. Requires an explicit selection.

local DEFAULT_NAME = "New Folder With Items"

local selection = ya.sync(function()
	local tab, urls = cx.active, {}
	for _, f in pairs(tab.selected) do
		urls[#urls + 1] = f.url
	end
	return { cwd = tab.current.cwd, urls = urls }
end)

local function notify(level, content)
	ya.notify({ title = "New folder from files", content = content, level = level, timeout = 5 })
end

-- Finder-style default: "New Folder With Items", then "… 2", "… 3", ...
local function default_name(cwd)
	local name, n = DEFAULT_NAME, 1
	while fs.cha(cwd:join(name)) do
		n = n + 1
		name = ("%s %d"):format(DEFAULT_NAME, n)
	end
	return name
end

return {
	entry = function()
		ya.emit("escape", { visual = true })
		local sel = selection()
		if #sel.urls == 0 then
			return notify("warn", "Select some files first")
		end

		local name, event = ya.input({
			title = ("New folder for %d item(s):"):format(#sel.urls),
			value = default_name(sel.cwd),
			pos = { "center", w = 60 },
		})
		if event ~= 1 or name == "" then
			return
		end

		local dir = sel.cwd:join(name)
		local ok, err = fs.create("dir", dir)
		if not ok then
			return notify("error", ("Cannot create %s: %s"):format(name, err))
		end

		for i, url in ipairs(sel.urls) do
			ok, err = fs.rename(url, dir:join(url.name))
			if not ok then
				return notify("error", ("Moved %d of %d; failed on %s: %s"):format(i - 1, #sel.urls, url.name, err))
			end
		end

		ya.emit("escape", { select = true })
		ya.emit("reveal", { dir })
	end,
}
