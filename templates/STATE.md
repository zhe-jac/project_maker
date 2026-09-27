# STATE

```yaml
phase: intake            # intake | research | ideation | planning | build | polish | improve | done
cycle: 0
status: active           # active | paused | waiting-on-owner | done
last_run: null
cycle_hours: 2           # how often a cycle starts (the scheduler should match this)
cycle_minutes: 100       # work budget per cycle before wrap-up
cycle_timeout_minutes: 150
max_parallel: 3
max_cycles: 60
push_allowed: false      # owner sets true to allow pushing non-main branches / main to the configured remote
current_milestone: null
```

## Current focus
One or two sentences: what the next cycle should start on.

## improve_log
| cycle | improvements shipped | value (high/med/marginal) |
|-------|----------------------|---------------------------|
