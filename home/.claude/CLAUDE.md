# Global Claude Instructions

## Communication Style

- Be concise in responses
- Lead with working code; keep prose minimal

## Preferred Tools

- Use conventional commits
- Consult the repo's build tooling (Justfile, Makefile, package.json, Cargo.toml, pyproject.toml, tox.ini, Rakefile, etc.) for its test/lint commands before assuming defaults
- Use `tea` for managing prs on the onlyhavecans.works forgejo instance

## Safety Rules

- Never force push
- Never skip hooks (e.g. `--no-verify`)
- Never `git reset --hard` without explicit approval
- Never delete branches without confirmation
- Never commit secrets
