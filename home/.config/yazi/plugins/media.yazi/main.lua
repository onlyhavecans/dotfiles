--- @since 26.9.1
-- Media previewer: thumbnail (image / video frame / audio cover) on top,
-- `mediainfo` output below. Thumbnails come from yazi's built-in plugins.

local M = {}

local SKIP_LABELS = {
	["Complete name"] = true,
	["CompleteName_Last"] = true,
	["Unique ID"] = true,
	["File size"] = true,
	["Format/Info"] = true,
	["Codec ID/Info"] = true,
	["MD5 of the unencoded content"] = true,
}

local MAGICK_IMAGES = { avif = true, heic = true, heif = true, jxl = true, tiff = true, ["canon-cr2"] = true }

-- Built-in plugin able to render a thumbnail for this mime, or "audio" for cover art.
local function thumb_plugin(mime)
	local top, sub = mime:match("^([%w-]+)/(.+)$")
	if top == "video" then
		return "video"
	elseif top == "audio" then
		return "audio"
	elseif top == "image" then
		return sub == "svg+xml" and "svg" or (MAGICK_IMAGES[sub] and "magick" or "image")
	end
end

local function info_cache(job)
	local base = ya.file_cache({ file = job.file, skip = 0 })
	return base and Url(tostring(base) .. ".mediainfo")
end

-- Extract embedded cover art; an empty cache file marks "no cover" so we don't retry.
local function preload_cover(job)
	local cache = ya.file_cache({ file = job.file, skip = 0 })
	if not cache or fs.cha(cache) then
		return true
	end
	local output, err = Command("ffmpeg")
		:arg({ "-v", "error", "-threads", 1, "-i", tostring(job.file.path) })
		:arg({ "-map", "0:v:0?", "-an", "-sn", "-dn", "-vframes", 1 })
		:arg({ "-q:v", 31 - math.floor(rt.preview.image_quality * 0.3) })
		:arg({ "-vf", string.format("scale=-1:'min(%d,ih)'", rt.preview.max_height) })
		:arg({ "-f", "image2", "-y", tostring(cache) })
		:output()
	if not output then
		return true, Err("Failed to start `ffmpeg`, error: %s", err)
	elseif not output.status.success then
		fs.write(cache, "")
	end
	return true
end

local function preload_thumb(job)
	local plugin = thumb_plugin(job.mime)
	if plugin == "audio" then
		return preload_cover(job)
	elseif plugin then
		return require(plugin):preload(job)
	end
	return true
end

local function preload_info(job)
	local cache = info_cache(job)
	if not cache or fs.cha(cache) then
		return true
	end
	local output, err = Command("mediainfo"):arg(tostring(job.file.path)):output()
	if not output then
		return true, Err("Failed to start `mediainfo`, error: %s", err)
	end
	return fs.write(cache, output.stdout)
end

-- Parse `mediainfo` text into styled lines, dropping noisy labels.
local function info_lines(job)
	local cache = info_cache(job)
	local f = cache and io.open(tostring(cache), "r")
	if not f then
		return {}
	end
	local text = f:read("*a")
	f:close()

	local label_style = ui.Style():bold()
	local value_style = th.spot.tbl_col or ui.Style():fg("blue")
	local section_style = th.spot.title or ui.Style():fg("green")

	local lines = {}
	for raw in text:gmatch("([^\n]*)\n?") do
		local label, value = raw:match("^(.-)%s%s+: (.*)$")
		if label then
			if not SKIP_LABELS[label] then
				lines[#lines + 1] =
					ui.Line({ ui.Span(label .. ": "):style(label_style), ui.Span(value):style(value_style) })
			end
		elseif raw ~= "" then
			lines[#lines + 1] = ui.Line(raw):style(section_style)
		end
	end
	return lines
end

function M:peek(job)
	local start = os.clock()
	local ok, err = self:preload(job)
	if not ok then
		return
	end
	ya.sleep(math.max(0, rt.preview.image_delay / 1000 + start - os.clock()))

	local plugin = thumb_plugin(job.mime)
	local lines = info_lines(job)
	local is_video = plugin == "video"

	-- Scroll text with `skip`; video also uses `skip` as the frame position.
	local visible = {}
	for i = job.skip + 1, #lines do
		visible[#visible + 1] = lines[i]
	end
	if #visible == 0 and job.skip > 0 and not is_video then
		return ya.emit("peek", { math.max(0, #lines - 1), only_if = job.file.url, upper_bound = true })
	end

	local area = job.area
	local text_h = math.min(#visible, area.h)
	local img_h = 0
	local cache = ya.file_cache(is_video and job or { file = job.file, skip = 0 })
	local cha = cache and fs.cha(cache)
	if cha and cha.len > 0 then
		local h = text_h > 0 and math.max(area.h - text_h, math.floor(area.h / 2)) or area.h
		local rect = ya.image_show(cache, ui.Rect({ x = area.x, y = area.y, w = area.w, h = h }))
		img_h = rect and rect.h or 0
	end

	if err then
		visible[#visible + 1] = ui.Line(tostring(err)):style(ui.Style():fg("red"))
	end
	local wrap = (rt.preview.wrap == "yes" or rt.preview.wrap == ui.Wrap.YES) and ui.Wrap.YES or ui.Wrap.NO
	ya.preview_widget(job, {
		ui.Text(visible):area(ui.Rect({ x = area.x, y = area.y + img_h, w = area.w, h = area.h - img_h })):wrap(wrap),
	})
end

function M:seek(job)
	local h = cx.active.current.hovered
	if h and h.url == job.file.url then
		ya.emit("peek", { math.max(0, cx.active.preview.skip + job.units), only_if = job.file.url })
	end
end

function M:preload(job)
	if not job.mime then
		return false
	end
	local ok, err = preload_thumb(job)
	if not ok then
		return false, err
	end
	local ok2, err2 = preload_info(job)
	return ok2, err or err2
end

return M
