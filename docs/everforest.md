# Everforest Hard — palette and usage guide

Everything themes to **Everforest, hard contrast**. Noctalia owns the palette
(`~/.config/noctalia/palettes/everforest-hard.json`, `theme.custom_palette =
"everforest-hard"`, `theme.mode = "auto"`) and renders every app it has a
template for. This file is for the rest: anything with hand-written hex.

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
| bg5 | `#BEC5B2` | `#4F5B58` | unused upstream; noctalia `mOutline` |
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
| green | `#8DA101` | `#A7C080` | **accent**: search, strings, functions, selection |
| aqua | `#35A77C` | `#83C092` | constants, macros |
| blue | `#3A94C5` | `#7FBBB3` | info, identifiers, diff changed text |
| purple | `#DF69BA` | `#D699B6` | numbers, booleans, attributes |
| grey0 | `#A6B0A0` | `#7A8478` | line numbers, concealed, UI foreground |
| grey1 | `#939F91` | `#859289` | comments, punctuation, **UI borders** |
| grey2 | `#829181` | `#9DA9A0` | cursor line number, inactive tab text |
| statusline1 | `#93B259` | `#A7C080` | menu selection bg, active tab bg |
| statusline2 | `#708089` | `#D3C6AA` | mode indicator |
| statusline3 | `#E66868` | `#E67E80` | mode indicator |

Note: in Light Hard `bg_dim` and `bg2` are the same hex. Medium and soft
variants live in the sibling noctalia palette JSONs; do not hand-copy them.

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
| **primary accent** (focus, active border, match) | green | `#8DA101` | `#A7C080` |
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
- Everforest is low contrast by design. Borders that carried on gruvbox yellow
  need more weight: 3px for normal menus, 4px for destructive.

## Noctalia token map

`everforest-hard.json` keys → everforest names. `mOn*` keys are all `bg0`.

| noctalia key | light | dark |
| --- | --- | --- |
| mSurface | bg0 | bg0 |
| mSurfaceVariant | bg1 | bg1 |
| mShadow | bg_dim | bg_dim |
| mOutline | bg5 | bg5 |
| mOnSurface | fg | fg |
| mOnSurfaceVariant | grey1 | grey2 |
| mPrimary, mHover | green | green |
| mSecondary | yellow | yellow |
| mTertiary | blue | blue |
| mError | red | red |
| terminal.normal.black | fg | bg3 |
| terminal.normal.white | bg3 | fg |
| terminal.bright.black | grey2 | grey0 |
| terminal.bright.white | bg0 | fg |
| terminal.selectionBg | bg_visual | bg_visual |

Template tokens (`{{ colors.<name>.<light|dark|default>.hex }}`) that map
1:1: `surface`, `on_surface`, `on_surface_variant`, `primary`, `on_primary`,
`secondary`, `tertiary`, `error`, `on_error`, `terminal_normal_*`.

Noctalia derives the rest; they are not everforest colors. Observed Light Hard
values (read `~/.config/tmux/themes/noctalia.conf` for the current mode):

| token | hex |
| --- | --- |
| surface_container_low | `#fbf8e9` |
| surface_container | `#f8f5e4` (= bg1) |
| surface_container_high | `#f4efd4` |
| surface_container_highest | `#f0e9c4` |
| outline | `#8e9482` |
| outline_variant | `#b3b7ab` |
| primary_container / on_primary_container | `#dced67` / `#434c00` |
| secondary_container / on_secondary_container | `#f4dc9d` / `#4d3700` |
| tertiary_container / on_tertiary_container | `#ccdde6` / `#112c3b` |
| error_container / on_error_container | `#f4bebd` / `#4a0403` |

Template filters used for diff backgrounds (delta, tuicr): green
`set_saturation 60 | set_lightness 91`, red `set_saturation 100 |
set_lightness 94`.

## Who owns what

Rendered by noctalia (`theme.mode = "auto"`, flips light/dark by schedule):
btop, foot, gtk3/4, kcolorscheme, niri (`noctalia.kdl`: focus-ring, border,
tab-indicator, insert-hint, recent-windows), qt, claude-code, feishin, neovim,
obsidian, pywalfox, tmux, yazi, delta, tuicr.

Palette-independent, inherit terminal ANSI: `BAT_THEME=ansi`, delta
`syntax-theme = ansi`, ratune `preset = "terminal"`, fzf, fish prompt.

Hand-written hex, **pinned to Light Hard** (does not follow mode):

- `home/.config/wlr-which-key/*.yaml`: bg0 `ee`, fg, green border; power menu
  red border.

Known drift (still gruvbox, overridden or unused):

- `home/.config/niri/config.kdl`: `shadow` colors, layout `background-color`,
  overview `backdrop-color`. Focus-ring/border/tab-indicator values there are
  dead; `noctalia.kdl` wins.
- `home/.config/ghostty/config`: `theme = Gruvbox Dark`.

## Alpha convention

- Surfaces (wlr-which-key backgrounds, popups): `ee`
- Text and borders: opaque `ff`
- niri shadows: active `66`, inactive `40`
- niri insert-hint (noctalia): `80`
