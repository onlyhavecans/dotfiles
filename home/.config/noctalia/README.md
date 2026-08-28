# noctalia base layer

Every `*.toml` in this directory is noctalia's committed base config, merged
alphabetically. The per-machine layer is `~/.local/state/noctalia/settings.toml`,
written by the settings GUI — it overrides this dir and prunes keys that match
it. Never commit the state file.

Workflow: tweak in the GUI, then move keys that should be universal out of the
state file into a `*.toml` here (split by concern: `bar.toml`, `theme.toml`, …).

`noctalia-diff` (in `~/bin`) lists every state override and which file here owns
it; `noctalia-diff extract <dotted.path>` prints a paste-ready TOML snippet.
