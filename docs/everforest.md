# Everforest theming — single source of truth

Everything themes to **Everforest**: Light **Hard** for the desktop/Wayland layer,
Dark **Hard** for terminals and TUIs. Nix-side copy of these palettes:
`nixos-skwrls/vars/palette.nix`. Upstream: <https://github.com/sainnhe/everforest/blob/master/palette.md>

## Light Hard (desktop: waybar, mako, swaylock, fuzzel, niri, wlr-which-key, satty)

| name | hex | role |
|---|---|---|
| bg_dim | `#f2efdf` | overview backdrop |
| bg0 | `#fffbef` | window/panel background |
| bg1 | `#f8f5e4` | raised surface |
| bg2 | `#f2efdf` | overlay |
| bg3 | `#edeada` | hairlines |
| bg4 | `#e8e5d5` | separators, low-urgency border |
| bg5 | `#bec5b2` | inactive borders |
| bg_visual | `#f0f2d4` | selection background |
| fg | `#5c6a72` | text |
| red | `#f85552` | urgent / error |
| orange | `#f57d26` | alt accent |
| yellow | `#dfa000` | warning / counter |
| green | `#8da101` | **primary accent** (focus, borders, match) |
| aqua | `#35a77c` | progress / key highlight |
| blue | `#3a94c5` | info / tab indicator |
| purple | `#df69ba` | special (power/destructive menus) |
| grey0 | `#a6b0a0` | disabled / placeholder |
| grey1 | `#939f91` | mid grey |
| grey2 | `#829181` | secondary text |

## Dark Hard (terminals: foot, ghostty; TUIs inherit via ANSI)

| name | hex | | name | hex |
|---|---|---|---|---|
| bg_dim | `#1e2326` | | red | `#e67e80` |
| bg0 | `#272e33` (canonical terminal bg) | | orange | `#e69875` |
| bg1 | `#2e383c` | | yellow | `#dbbc7f` |
| bg2 | `#374145` | | green | `#a7c080` |
| bg3 | `#414b50` | | aqua | `#83c092` |
| bg4 | `#495156` | | blue | `#7fbbb3` |
| bg5 | `#4f5b58` | | purple | `#d699b6` |
| bg_visual | `#4c3743` (selection) | | grey0 | `#7a8478` |
| fg | `#d3c6aa` | | grey1 | `#859289` |
| | | | grey2 | `#9da9a0` |

Bright ANSI slots (foot/ghostty) map to the *light-hard* accents — that's
upstream's convention and gives the extra pop.

## Alpha convention

- Surfaces (mako/fuzzel/wlr-which-key backgrounds, waybar capsules): `ee` — waybar CSS: `alpha(@bg0, 0.93)`
- Text and borders: opaque `ff`
- niri shadows: active `66`, inactive `40`
- swaylock keeps its deliberate `11`/`55`/`aa` ramp

## Palette-independent settings (cannot drift)

`BAT_THEME=ansi`, delta `syntax-theme = ansi`, ratune `preset = "terminal"`,
fzf/btop/fish-prompt inherit terminal ANSI.
