---
description: Start a new project — set up its workspace and state, then run the first cycle
argument-hint: <what to build, links, deadline...> [--mode hackathon|product|build] [--path <existing repo>]
---

The owner is handing you a new project. Their request:

$ARGUMENTS

Set it up, then start working. Do **not** ask clarifying questions — infer, assume,
record assumptions (they'll be surfaced in the first summary).

1. Read `GUARDRAILS.md` and `ORCHESTRATOR.md`.
2. Pick a short kebab-case slug. Pick the mode (flag wins; otherwise infer: a named
   event / "hackathon" → hackathon; a business/startup/app for users → product; work on
   an existing repo or a tool/library → build).
3. Workspace:
   - Default: `projects/<slug>/` → `git init -b main`, add a `.gitignore` (include `.env`),
     initial commit.
   - With `--path`: use that existing repo as the workspace (don't reinit) and record the
     path in the PORTFOLIO row. Run cycles with `--add-dir <path>` if it's outside this repo.
4. Create `.pm/` in the workspace and copy every file from `templates/` into it
   (BRIEF, STATE, ROADMAP, DELIVERABLES, BACKLOG, DECISIONS, INBOX, LESSONS). Create empty
   dirs `.pm/research/judges`, `.pm/ideas`, `.pm/reviews`, `.pm/summaries` (with `.gitkeep`).
   Leave SUMMARY/REVIEW/HANDOFF in `templates/` (they're per-use).
5. Fill `.pm/BRIEF.md` from the request (paste it verbatim in the "Owner's original
   request" field). Set `STATE.md` cycle cadence from the mode file's defaults.
6. Add a row to `PORTFOLIO.md` (status `active`, `next_run` = now).
7. Commit the project (`pm: init`) and the engine repo (`portfolio: add <slug>`).
8. Tell the owner in 3 lines: slug, mode, and how to run it unattended
   (`scripts/run-cycle.ps1 -Project <slug>` / `scripts/install-schedule.ps1 -Project <slug>`,
   or `/loop 2h /pm-cycle <slug>`).
9. Then immediately run cycle 1 by following `ORCHESTRATOR.md` for this project.
