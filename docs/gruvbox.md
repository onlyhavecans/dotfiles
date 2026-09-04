# Gruvbox theme

Everything themes to **Gruvbox Dark, medium contrast** — one palette for the
desktop/Wayland layer *and* terminals/TUIs. Nix-side copy of this palette:
`nixos-skwrls/vars/palette.nix`.
Upstream: <https://github.com/morhetz/gruvbox>

## Palette (role names → gruvbox canonical)

| role | gruvbox | hex | use |
| --- | --- | --- | --- |
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

The accent is **yellow**, so warning states use **orange** to stay
distinguishable (accent and warning swapped roles vs the previous scheme).

Terminal ANSI (foot `regular0..7`) uses the neutral gruvbox set
(`cc241d 98971a d79921 458588 b16286 689d6a a89984`); brights are the table's
accent column: upstream's convention.

## Alpha convention

- Surfaces (mako/fuzzel/wlr-which-key backgrounds, waybar capsules): `ee` — waybar CSS: `alpha(@bg1, 0.93)`
- Text and borders: opaque `ff`
- niri shadows: active `66`, inactive `40`
- swaylock is deliberately stock (image + font only)

## Waybar

- Every top-level item is a neutral pill (`bg1` fill, `bg3` border). Groups' children are unstyled.
- The Pomodoro pill is the only *filled* one: yellow (work), aqua (break), red (paused/disconnected);
  it alone glows. Idle keeps a yellow border.
- Transient alerts are individual chips with a red border; idle-inhibit is yellow, DND is `bg4`/grey1.
- Levels show a glyph plus a one-char meter (`▁▂▃▄▅▆▇█`), never a number; state colours only
  (muted grey0, battery orange/red).
- Links: WireGuard aqua, NetBird blue (orange when degraded), bluetooth blue.
