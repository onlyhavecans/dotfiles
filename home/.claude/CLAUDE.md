# Global Claude Instructions

## Communication Style

- Be concise in responses
- Write comments and documentation in Simplified Technical English
- Lead with working code; keep prose minimal
- Keep code comments trim and to the point; avoid narrative comments or explaining historical state
- Follow commit conventions of the repo; If recent commits are inconsistant ask before committing

## Preferred Tools

- Terminal: tmux with workmux. Use the `workmux` skill to spawn agents I can watch and track.
- Use `fj` [forgejo-cli](https://codeberg.org/forgejo-contrib/forgejo-cli) for managing prs on the onlyhavecans.works forgejo instance
- Use `gh` for all github based repos

## Code Changes

- Prefer the stdlib over a third-party package when both are equally simple
- Before a sweep across many files (modernize, upgrade, refactor), confirm the scope: one file, one module, or the whole project

## Memories

- If you find a memory that seems to be inaccurate our out of date, like mentioning a tool you can't find, raise this up so we can correct it.

## Safety Rules

- Never force push to main/master
- Never skip hooks (e.g. `--no-verify`)
- Never `git reset --hard` without explicit approval
- Never commit secrets
