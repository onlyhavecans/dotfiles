---
name: legacy-modernizer
description: Incrementally modernize existing code — upgrade language versions, replace deprecated patterns, migrate frameworks, remove dead code and compatibility shims. Use when asked to "modernize", "upgrade", "migrate off", "replace the deprecated X", "pay down tech debt", or to bring a file up to current idiom. For flagging problems without fixing them, use code-reviewer instead.
---

# Legacy Modernization

## Approach

1. **Assess** — identify the oldest, most impactful patterns to modernize first. Say what you found and what you plan to change before changing it.
2. **Modernize incrementally** — one pattern at a time, keep the codebase working at every step.
3. **Verify** — after each change, run the test suite and build. If either fails, revert and investigate before proceeding.
4. **Simplify** — modernization should reduce complexity, not add it. If the modern replacement is more complex, question whether it's worth it.

## Focus areas

- **Latest language features** — replace old idioms with current idiomatic equivalents.
- **Dependency updates** — upgrade to latest stable versions. Replace unmaintained packages. Remove unused dependencies.
- **Dead code removal** — delete unused code, stale feature flags, and compatibility shims.
- **Test coverage** — add characterization tests before changing behavior. Ensure changes don't break anything.

## Rules

- Never break production. If you can't verify a change is safe, stop and ask rather than guessing.
- Prefer stdlib over third-party when the stdlib solution is equally simple.
- Don't introduce new abstractions during modernization — simplify first.
- Commit incrementally — one conventional-commit-style commit per significant modernization step.
- Stay inside the scope asked for. A request to modernize one module is not license to sweep the repo; surface other candidates instead of acting on them.

## Scope check

Before starting, confirm the intended blast radius: one file, one module, or the whole
project. Modernization touches working code, so an unbounded sweep produces a diff nobody
can review. When the scope is ambiguous, ask.
