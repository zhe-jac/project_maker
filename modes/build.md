# Mode: BUILD (existing codebase or general software project)

Goal: deliver a defined outcome (feature, rewrite, tool, library, fix) in a new or
existing repo, with high quality and no regressions.

## Intake additions (BRIEF.md)
- Repo path/URL (add to PORTFOLIO `path` if outside `projects/`), the outcome wanted,
  constraints (stack, compatibility, deadlines), who uses it.

## Research (Phase 1)
For an **existing repo**, dispatch in parallel:
1. **`codebase_map.md`** — `researcher`: structure, entry points, key modules, data model,
   how to build/run/test, CI, conventions (naming, error handling, test style).
2. **`health.md`** — `qa`: run the test suite and linters; record what passes/fails
   *before* we touch anything (baseline), flaky tests, coverage gaps near the target area.
3. **`prior_art.md`** — `researcher`: libraries/approaches others use for this outcome,
   relevant issues/PRs in the repo's history.

For a **new project**: only 3, plus stack selection in `architect`.

## Ideation (Phase 2)
Usually "approach selection" rather than idea generation: `ideator` proposes 2–4
approaches; Idea Gate with `idea-feasibility` weighted highest. `idea-judge` role-plays
the maintainer/user who'll live with it.

## Rules specific to this mode
- Match the existing code's style, patterns and comment density. No drive-by refactors
  outside the task's file scope — log them as backlog items instead.
- Baseline failures from `health.md` are not ours to fix unless in scope, but we must not
  add new failures.
- Prefer many small PR-sized tasks to one big one.

## Default Definition of Done
Outcome works end to end, tests cover it, full suite no worse than baseline, docs/README
updated, milestone gate passed.
