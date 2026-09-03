# Gruvbox theming — single source of truth

Everything themes to **Gruvbox Dark, medium contrast** — one palette for the
desktop/Wayland layer *and* terminals/TUIs (the old light-desktop/dark-terminal
split is gone). Nix-side copy of this palette: `nixos-skwrls/vars/palette.nix`.
Upstream: <https://github.com/morhetz/gruvbox>

## Palette (role names → gruvbox canonical)

| role | gruvbox | hex | use |
|---|---|---|---|
| bg_dim | bg0_h | `#1d2021` | overview backdrop |
| bg0 | bg0 | `#282828` | window/panel/terminal background |
| bg1 | bg0_s | `#32302f` | raised surface |
| bg2 | bg1 | `#3c3836` | overlay |
| bg3 | bg2 | `#504945` | hairlines |
| bg4 | bg3 | `#665c54` | separators, low-urgency border |
| bg5 | bg4 | `#7c6f64` | inactive borders |
| bg_visual | bg3 | `#665c54` | selection background (matches ghostty) |
| fg | fg1 | `#ebdbb2` | text |
| grey0 | gray | `#928374` | disabled / placeholder |
| grey1 | fg4 | `#a89984` | mid grey |
| grey2 | fg3 | `#bdae93` | secondary text |
| red | bright red | `#fb4934` | urgent / error |
| orange | bright orange | `#fe8019` | **warning / counter** |
| yellow | bright yellow | `#fabd2f` | **primary accent** (focus, borders, match) |
| green | bright green | `#b8bb26` | success / activated |
| aqua | bright aqua | `#8ec07c` | progress / key highlight |
| blue | bright blue | `#83a598` | info / tab indicator |
| purple | bright purple | `#d3869b` | special (power/destructive menus) |

The accent is **yellow** (the whole point of Gruvbox), so warning states use
**orange** to stay distinguishable (accent and warning swapped roles vs the
previous scheme).

Terminal ANSI (foot `regular0..7`) uses the neutral gruvbox set
(`cc241d 98971a d79921 458588 b16286 689d6a a89984`); brights are the table's
accent column — upstream's convention.

## Alpha convention

- Surfaces (mako/fuzzel/wlr-which-key backgrounds, waybar capsules): `ee` — waybar CSS: `alpha(@bg0, 0.93)`
- Text and borders: opaque `ff`
- niri shadows: active `66`, inactive `40`
- swaylock is deliberately stock (image + font only)

## Currently ANSI-inheriting (retheme for free via the terminal palette)

`BAT_THEME=ansi`, delta `syntax-theme = ansi`, ratune `preset = "terminal"`,
fzf/fish-prompt inherit terminal ANSI. This is an inventory, not a rule —
any of these can switch to an explicit gruvbox theme if it looks better
(btop already uses explicit `gruvbox_dark_v2`).
