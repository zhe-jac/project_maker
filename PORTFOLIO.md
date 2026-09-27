# PORTFOLIO

Every project the orchestrator manages. The orchestrator updates `phase`, `status`,
`last_run` and `next_run`; the owner sets `priority` and can set `status` to `paused`.

| slug | mode | status | priority | phase | cycle_hours | path | last_run | next_run | notes |
|------|------|--------|----------|-------|-------------|------|----------|----------|-------|

Status values: `active` · `paused` · `waiting-on-owner` · `done`.
`path` blank = `projects/<slug>/`.
