# Global Claude Instructions

## Communication Style

- Be concise in responses
- Lead with working code; keep prose minimal
- Keep code comments trim and to the point; avoid narrative comments or explaining historical state.
- Write comments and documentation in Simplified Technical English

## Preferred Tools

- Use conventional commits
- Consult the repo's build tooling (Justfile, Makefile, package.json, Cargo.toml, pyproject.toml, Rakefile, etc.) for its test/lint commands before assuming defaults
- Use `fj` [forgejo-cli](https://codeberg.org/forgejo-contrib/forgejo-cli) for managing prs on the onlyhavecans.works forgejo instance

## Safety Rules

- Never force push to main/master
- Never skip hooks (e.g. `--no-verify`)
- Never `git reset --hard` without explicit approval
- Never commit secrets
