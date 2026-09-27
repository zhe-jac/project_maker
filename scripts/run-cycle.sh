#!/usr/bin/env bash
# Runs one unattended orchestration cycle (macOS / Linux / WSL / Git Bash).
# Usage: scripts/run-cycle.sh [project-slug]
# Env:   PM_TIMEOUT_MIN=150  PM_PERMISSION_MODE=auto  PM_MODEL=  PM_MAX_BUDGET_USD=
# Cron (every 2h):  0 */2 * * * cd /path/to/project_maker && scripts/run-cycle.sh my-hack
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

PROJECT="${1:-}"
TIMEOUT_MIN="${PM_TIMEOUT_MIN:-150}"
MODE="${PM_PERMISSION_MODE:-auto}"

command -v claude >/dev/null || { echo "claude CLI not on PATH" >&2; exit 1; }

mkdir -p logs
LOG="logs/cycle-$(date +%Y-%m-%d-%H%M).log"

if [ -n "$PROJECT" ]; then TARGET="Project: $PROJECT."; else TARGET="No project named: pick the due one per PORTFOLIO.md."; fi
PROMPT="Run exactly one orchestration cycle. Read CLAUDE.md, GUARDRAILS.md, then ORCHESTRATOR.md and follow it from section 1 to section 8. $TARGET This is an unattended scheduled run: never wait for input or ask questions; record decisions in DECISIONS.md and questions in the summary with the default you took. Current local time: $(date '+%Y-%m-%d %H:%M %Z')."

ARGS=(-p "$PROMPT" --permission-mode "$MODE" --output-format text)
[ -n "${PM_MODEL:-}" ] && ARGS+=(--model "$PM_MODEL")
[ -n "${PM_MAX_BUDGET_USD:-}" ] && ARGS+=(--max-budget-usd "$PM_MAX_BUDGET_USD")

echo "[$(date -Iseconds)] starting cycle ($TARGET)" | tee -a "$LOG"
set +e
timeout "${TIMEOUT_MIN}m" claude "${ARGS[@]}" >>"$LOG" 2>&1
CODE=$?
set -e
[ $CODE -eq 124 ] && echo "[$(date -Iseconds)] TIMEOUT after ${TIMEOUT_MIN} min" | tee -a "$LOG"
echo "[$(date -Iseconds)] finished with exit code $CODE. Read REVIEW_ME.md." | tee -a "$LOG"
exit $CODE
