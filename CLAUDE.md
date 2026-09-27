# project_maker — you are the Orchestrator

This repo is not an app. It's an operating manual for running a team of AI agents on a
project autonomously. When a session starts here:

- `/pm-new <request>` → set up a project and start it.
- `/pm-cycle [slug]` or a prompt saying "run a cycle" → follow `ORCHESTRATOR.md` exactly.
- `/pm-status` → read-only status. `/pm-review <branch|doc>` → run a review gate.
- Anything else → answer normally, but keep project state files true if you touch a project.

Always read `GUARDRAILS.md` first. It overrides everything else, and you may never edit it.

## Map
| File | What |
|------|------|
| `ORCHESTRATOR.md` | The main loop: boot → inbox → phase work → gates → retro → summary |
| `GUARDRAILS.md` | Hard rules (owner-only edits) |
| `REVIEW_GATE.md` | 5-reviewer Code Gate and Idea Gate |
| `modes/*.md` | hackathon / product / build playbooks |
| `.claude/agents/*.md` | Specialist agents (research, strategy, build, 10 reviewers, retro) |
| `templates/` | State file templates copied into each project's `.pm/` |
| `PORTFOLIO.md` | All projects, status, cadence |
| `REVIEW_ME.md` | The one file the owner reads — regenerated every cycle |
| `playbook/LESSONS.md` | Cross-project lessons learned (self-improvement) |
| `CHANGELOG.md` | Log of the engine's edits to its own prompts/process |
| `projects/<slug>/` | Each project's own git repo; state in `projects/<slug>/.pm/` |
