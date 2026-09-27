# project_maker

An orchestrator for AI coding agents. Give it a project — a hackathon, a startup idea, a
feature for an existing repo — and it runs a team of specialist agents that research,
plan, build, review and improve it in a loop. You don't have to prompt it along the way.
Every cycle (default every 2 hours) it leaves you a report to review, then keeps going.

It isn't an app. It's a set of markdown instructions (an orchestrator prompt, agent
definitions, review rules, templates) plus two small scripts that run it on a schedule.
Claude Code runs it natively; any other coding agent can run it via `AGENTS.md`.

## How it works

```
             ┌──────────── every cycle (default 2h) ─────────────┐
 you ──► INBOX.md ──► boot: read state, lessons, inbox            │
                        │                                         │
                        ▼                                         │
   intake → research → ideation → planning → build → polish → improve → done
             (parallel   (≥20 ideas   (roadmap,   (parallel engineers in git
             scouts,     → 5-reviewer  deliverables, worktrees → 5-reviewer
             judge       Idea Gate)    backlog)      Code Gate → merge)
             profiles)                                            │
                        │                                         │
                        ▼                                         │
               retro (self-improve) → summary → REVIEW_ME.md ─────┘──► you
```

- **Orchestrator** (`ORCHESTRATOR.md`) — the tech lead. Picks work, dispatches agents in
  parallel, enforces gates, merges, replans, writes the report.
- **23 specialist agents** (`.claude/agents/`) — researcher, hackathon-scout,
  judge-profiler, market-analyst, ideator, planner, architect, critic, engineer, designer,
  qa, writer, retro-coach, plus **10 reviewers**.
- **Two review gates** (`REVIEW_GATE.md`), 5 independent reviewers each:
  - *Code Gate*: correctness/tests · security · architecture · product/UX · reliability
  - *Idea Gate*: judge simulator · originality · feasibility · user/market · demo/story
  - Pass = no BLOCK, mean ≥ 7 (code) / 7.5 (idea), nothing below 5. Fail → fix → re-review,
    max 3 rounds, then it's escalated to you and the team moves on.
- **Modes** (`modes/`) — `hackathon` (past winners, per-track winners, judge profiles,
  sponsor tracks, prize-stacking, graveyard of overdone ideas, backward timeline, full
  submission package), `product` (market, competitors, departments/workstreams), `build`
  (existing codebase).
- **Self-improvement** — every cycle a retro turns recurring review findings and wasted
  time into lessons, checklist lines and prompt edits. Engine edits are logged in
  `CHANGELOG.md` and committed separately so you can revert them. `GUARDRAILS.md` is
  off-limits to the agents.
- **Guardrails** — it never spends money, submits, publishes, pushes or contacts anyone
  without your approval. It gets everything ready and asks at the top of `REVIEW_ME.md`.

## Quick start

Open a Claude Code session in this folder:

```
/pm-new <hackathon name>, <devpost url> — deadline <date, time, timezone>. Solo + AI. Aim for overall or the best sponsor track.
```

It sets up `projects/<slug>/` (its own git repo, state in `.pm/`) and runs cycle 1.

### Run it without you

**Windows (Task Scheduler), every 2 hours:**
```powershell
.\scripts\install-schedule.ps1 -Project <slug> -EveryHours 2
.\scripts\install-schedule.ps1 -Project <slug> -Uninstall     # stop
```
**One cycle by hand:** `.\scripts\run-cycle.ps1 -Project <slug>` (optional `-MaxBudgetUsd 20`, `-Model opus`)
**macOS/Linux/WSL:** `scripts/run-cycle.sh <slug>` from cron.
**In an open Claude Code session:** `/loop 2h /pm-cycle <slug>`.

Headless runs use `--permission-mode auto`. Anything the permission rules or the classifier
won't allow gets skipped and reported, so a run never hangs waiting for you. If you run it
in a VM or container you trust, `-PermissionMode bypassPermissions` removes those limits.

## Your part

| You | Where |
|-----|-------|
| Read the report | `REVIEW_ME.md` (all projects), details in `projects/<slug>/.pm/summaries/` |
| Steer, answer, approve | `projects/<slug>/.pm/INBOX.md` (write `APPROVED: <action>` to approve) |
| See status | `/pm-status` |
| Pause / reprioritize | `PORTFOLIO.md` (`status: paused`, `priority`) |
| Allow pushing | `push_allowed: true` in `projects/<slug>/.pm/STATE.md` |
| Review any branch or doc | `/pm-review <branch or file>` |

## Layout

```
ORCHESTRATOR.md  GUARDRAILS.md  REVIEW_GATE.md   the brain, the rules, the gates
CLAUDE.md  AGENTS.md                             boot files (Claude Code / other agents)
modes/           hackathon.md product.md build.md
.claude/agents/  23 specialist + reviewer prompts
.claude/commands/ /pm-new /pm-cycle /pm-status /pm-review
templates/       BRIEF STATE ROADMAP DELIVERABLES BACKLOG DECISIONS INBOX LESSONS SUMMARY REVIEW HANDOFF
playbook/        LESSONS.md, cross-project learnings
PORTFOLIO.md  REVIEW_ME.md  CHANGELOG.md
scripts/         run-cycle.ps1 install-schedule.ps1 run-cycle.sh
projects/<slug>/ each project's repo + .pm/ state   (gitignored here)
```
