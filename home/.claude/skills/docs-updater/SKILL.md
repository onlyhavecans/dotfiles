---
name: docs-updater
description: Write or update README.md, CHANGELOG.md, CLAUDE.md, and other project docs. Use when documentation needs creating, refreshing after code changes, auditing for drift, or before a release. Triggers on "update the README", "document this", "the docs are stale", "add a changelog entry".
---

# Documentation Updates

## Guiding principles

- **Simplicity over completeness** — write the minimum that's useful. Delete more than you add.
- **Don't document what you can look up** — skip things that change often or are easily found in source.
- **Clean out old context** — comments that refer to the way things were are rarely helpful.

## File-specific guidance

**README.md** — a "how to use this" guide for end users. Installation, quick start, basic examples. Not an API reference or architecture overview.

**CLAUDE.md / .claude/ files** — minimal. Document only:
- Build/test/lint commands the agent needs
- Gotchas and issues you've actually hit
- Project-specific conventions that aren't obvious from the code

Do NOT add to CLAUDE.md: file trees, architecture overviews, dependency lists, or anything that will go stale.

**CHANGELOG.md** — follow Keep a Changelog format if one exists. Don't create one if it doesn't.

## When auditing

1. Check docs against actual code state — delete anything that's drifted
2. Remove redundant or obvious content
3. Check code examples against current source — signatures, flags, and paths still match
4. Flag docs that duplicate information available elsewhere

## Verify before documenting

Run any command you're about to put in the docs. An install step or test invocation that
doesn't work is worse than no documentation. Prefer commands the repo's own build tooling
already defines over ones you infer.
