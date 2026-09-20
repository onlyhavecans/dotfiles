# Everforest Hard — palette and usage guide

Everything themes to **Everforest, hard contrast**. Each app
is pinned to Light Hard with static files in this castle. This file is the
palette and the rules for all hand-written hex.

Upstream: <https://github.com/sainnhe/everforest/blob/master/palette.md>
(tables below are copied verbatim, so no lookup is needed).

## Palette

`bg*` is palette1 (backgrounds, differs per contrast level). Everything from
`fg` down is palette2 (foregrounds, shared by hard/medium/soft).

| name | Light Hard | Dark Hard | everforest meaning |
| --- | --- | --- | --- |
| bg_dim | `#F2EFDF` | `#1E2326` | dimmed backdrop (overview, behind popups) |
| bg0 | `#FFFBEF` | `#272E33` | default background |
| bg1 | `#F8F5E4` | `#2E383C` | cursor line, active statusline, raised surface |
| bg2 | `#F2EFDF` | `#374145` | popup menu, floating window, toolbar |
| bg3 | `#EDEADA` | `#414B50` | list chars, inactive tab label |
| bg4 | `#E8E5D5` | `#495156` | window splits, whitespace |
| bg5 | `#BEC5B2` | `#4F5B58` | unused upstream; inactive outline here |
| bg_visual | `#F0F2D4` | `#4C3743` | visual selection |
| bg_red | `#FFE7DE` | `#493B40` | diff deleted line, error highlight |
| bg_yellow | `#FEF2D5` | `#45443C` | warning highlight |
| bg_green | `#F3F5D9` | `#3C4841` | diff added line, hint highlight |
| bg_blue | `#ECF5ED` | `#384B55` | diff changed line, info highlight |
| bg_purple | `#FCECED` | `#463F48` | (no upstream use) |
| fg | `#5C6A72` | `#D3C6AA` | default text |
| red | `#F85552` | `#E67E80` | error, keywords, diff deleted sign |
| orange | `#F57D26` | `#E69875` | operators, titles, tags |
| yellow | `#DFA000` | `#DBBC7F` | warning, types |
| green | `#8DA101` | `#A7C080` | **accent**: search, strings, functions |
| aqua | `#35A77C` | `#83C092` | constants, macros |
| blue | `#3A94C5` | `#7FBBB3` | info, identifiers, diff changed text |
| purple | `#DF69BA` | `#D699B6` | numbers, booleans, attributes |
| grey0 | `#A6B0A0` | `#7A8478` | line numbers, concealed, UI foreground |
| grey1 | `#939F91` | `#859289` | comments, punctuation, **UI borders** |
| grey2 | `#829181` | `#9DA9A0` | cursor line number, inactive tab text |
| statusline1 | `#93B259` | `#A7C080` | menu selection bg, active tab bg |
| statusline2 | `#708089` | `#D3C6AA` | mode indicator |
| statusline3 | `#E66868` | `#E67E80` | mode indicator |

Note: in Light Hard `bg_dim` and `bg2` are the same hex.

## Desktop roles

Use the semantic, not the hue. Pick from this table when writing hex by hand.

| role | color | Light Hard | Dark Hard |
| --- | --- | --- | --- |
| window / panel / terminal background | bg0 | `#FFFBEF` | `#272E33` |
| raised surface (popover, card, sidebar) | bg1 | `#F8F5E4` | `#2E383C` |
| overlay / floating | bg2 | `#F2EFDF` | `#374145` |
| overview backdrop | bg_dim | `#F2EFDF` | `#1E2326` |
| hairline | bg3 | `#EDEADA` | `#414B50` |
| separator, low-urgency border | bg4 | `#E8E5D5` | `#495156` |
| inactive border / outline | bg5 | `#BEC5B2` | `#4F5B58` |
| selection background | bg_visual | `#F0F2D4` | `#4C3743` |
| text | fg | `#5C6A72` | `#D3C6AA` |
| text on accent | bg0 | `#FFFBEF` | `#272E33` |
| secondary text | grey1 | `#939F91` | `#859289` |
| disabled / placeholder | grey0 | `#A6B0A0` | `#7A8478` |
| **primary accent** (focus, border, match) | green | `#8DA101` | `#A7C080` |
| warning / counter | yellow | `#DFA000` | `#DBBC7F` |
| urgent / error / destructive | red | `#F85552` | `#E67E80` |
| info / tertiary | blue | `#3A94C5` | `#7FBBB3` |
| progress / key highlight | aqua | `#35A77C` | `#83C092` |
| alt accent | orange | `#F57D26` | `#E69875` |
| special | purple | `#DF69BA` | `#D699B6` |

Rules:

- Green is the accent everywhere. Do not reach for yellow as a highlight; it is
  the warning color.
- Red is the only alert color. Destructive menus (wlr-which-key power) use red,
  not purple.
- Geometry: 15px corner radius and 3px borders on all surfaces. Destructive
  surfaces (wlr-which-key power menu, mako critical) use a 4px red border.
  The waybar is the exception: a 32px opaque tab with 16px curves, and fully
  round (`999px`) pills with 1px borders. Only its tooltips and menus use 15px
  and 3px.

## Who owns what

Everything is pinned to **Light Hard**. The Dark Hard column above is for
reference only; no app reads it. There is no mode switch.

| app | where the colors live |
| --- | --- |
| niri | hex in `niri/config.kdl` (rings, shadow, tab indicator, insert hint). Background and overview backdrop stay neutral grey, not theme colors |
| waybar | `waybar/everforest-light.css`, imported by `style.css` |
| mako | `mako/config` |
| fuzzel | `fuzzel/fuzzel.ini` |
| wlr-which-key | header of each `wlr-which-key/*.yaml`; power menu has the red border |
| foot | `[colors-light]` in `foot/foot.ini`, `initial-color-theme=light` |
| tmux | `tmux/themes/everforest-light.conf`; `bar.conf` reads its `@theme_*` |
| btop | `btop/themes/everforest-light.theme` |
| yazi | `yazi/flavors/everforest-hard-light.yazi` |
| tuicr | `tuicr/themes/everforest-hard-light.toml` |
| delta | `[delta]` in `git/config` |
| claude-code | `.claude/themes/everforest-light.json` |
| neovim | `sainnhe/everforest`, hard, light (neovim castle) |
| Firefox, Thunderbird | `pywalfox/everforest-light.json`, linked to `~/.cache/wal/colors.json` by `link-host-files` |
| GTK, Qt, icons, cursor | NixOS repo, `nixos/desktop/theme/` |
| satty | light accents in `satty/config.toml` |

Palette-independent, inherit terminal ANSI: `BAT_THEME=ansi`, delta
`syntax-theme = ansi`, ratune `preset = "terminal"`, fzf, fish prompt.

swaylock is stock (image and font only). The waybar calendar "today" color is
hex in `modules/clock.jsonc` because Pango markup cannot read CSS colors.

Ghostty (macOS) uses the bundled themes and follows system appearance:
`theme = light:Everforest Light - Hard,dark:Everforest Dark - Hard`.

## tmux variables

`tmux/bar.conf` reads `@theme_*` at render time.

| variable | use | color |
| --- | --- | --- |
| surface_container_low | bar background | bg1 |
| surface_container | inactive window, clock | bg2 |
| surface_container_highest | session, host | bg4 |
| on_surface | text | fg |
| on_surface_variant | secondary text | grey1 |
| primary / on_primary | active window | green / bg0 |
| tertiary_container / on_ | prefix held | blue / bg0 |
| secondary_container / on_ | copy mode | yellow / bg0 |
| error_container / on_ | synchronized panes | red / bg0 |

## Waybar

- The bar is one opaque `bg0` tab against the top edge of the screen. The
  window is transparent. Two corner gradients flare the body into the screen
  edge, and the bottom corners are round. Flare size and body margin must be
  equal, and flare size + bottom radius must equal the bar height (16 + 16 =
  32).
- Modules are plain text on the bar. Text is Inter (Adwaita Sans as fallback);
  the Nerd Font supplies the glyphs.
- Spacing: 6px between glyphs in a cluster, 10px between clusters. An empty
  cluster takes no room.
- Pills are for workspaces and the Pomodoro timer only. A workspace pill has a
  `bg1` fill and a `bg5` border; the active one has a green border.
- The Pomodoro pill is the only filled pill: green (work), aqua (break), red
  (paused or disconnected). Only this pill glows. Idle keeps a green border.
- Hardware readouts (cpu, memory, temperature, disk) flank the timer. They are
  small and `grey1`, then yellow (warning) and red (critical).
- Alerts are red glyphs that hide when idle. Idle-inhibit is green. DND is
  `grey1`.
- Levels show a glyph, never a number. State colors only: muted `grey0`,
  battery yellow then red.
- Links: WireGuard aqua, NetBird yellow when degraded, bluetooth blue when
  connected.

## Alpha convention

- Surfaces (mako, fuzzel, wlr-which-key backgrounds): `ee`. The waybar is
  opaque.
- Text and borders: opaque `ff`
- niri shadows: active `66`, inactive `40`
- niri insert-hint: `80`
