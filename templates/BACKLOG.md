# BACKLOG

Statuses: `todo` → `ready` (spec'd, deps known) → `in_progress` → `in_review` →
`changes_requested` → `done` | `blocked`.
Tasks are ≤ ~90 min of agent work. Split anything bigger.

## Template
```
### T-001 · <title>
- status: ready
- milestone: M1
- owner: engineer
- depends_on: []
- files: [src/api/**, tests/api/**]      # scope — parallel tasks must not overlap
- branch: task/T-001-<name>
- acceptance:
  - [ ] …
  - [ ] tests cover …
- notes / links:
- review: .pm/reviews/T-001/
```

## Tasks
