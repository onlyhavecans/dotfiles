--!nonstrict
-- WireGuard bar widget: mirrors `vpn status <endpoint>` (systemctl is-active
-- under the hood), left click toggles, right click forces down. The vpn script
-- sends its own notify-send on up/down.

local ENDPOINT = noctalia.getConfig("endpoint") or "ams"
local UP = {
  glyph = noctalia.getConfig("up_glyph") or "shield-check",
  color = noctalia.getConfig("up_color") or "primary",
}
local DOWN = {
  glyph = noctalia.getConfig("down_glyph") or "shield-off",
  color = noctalia.getConfig("down_color") or "on_surface",
}

local VPN = '"$HOME"/bin/vpn'

local function render(active)
  local look = if active then UP else DOWN
  barWidget.setGlyph(look.glyph)
  barWidget.setGlyphColor(look.color)
  barWidget.setTooltip(noctalia.tr("widget.tooltip", {
    endpoint = ENDPOINT,
    state = noctalia.tr(if active then "widget.up" else "widget.down"),
  }))
end

local function onStatusLine(line)
  render(line == "active")
end

-- Refresh right after a click instead of waiting for the next poll tick.
local function checkNow()
  noctalia.runAsync(VPN .. " status " .. ENDPOINT, function(r)
    render(string.match(r.stdout or "", "^%s*(%S+)") == "active")
  end)
end

function onClick()
  noctalia.runAsync(VPN .. " toggle " .. ENDPOINT, function() checkNow() end)
end

function onRightClick()
  noctalia.runAsync(VPN .. " down " .. ENDPOINT, function() checkNow() end)
end

render(false)

-- Same managed retry loop as the voxtype widget: one poller, dies with its host.
local poll = 'P=$PPID; while kill -0 "$P" 2>/dev/null; do '
  .. VPN .. " status " .. ENDPOINT .. " 2>/dev/null || true; sleep 3; done"
if not noctalia.runStream(poll, onStatusLine) then
  barWidget.setGlyph("shield-x")
  barWidget.setGlyphColor("error")
  barWidget.setTooltip(noctalia.tr("widget.stream_error"))
end
