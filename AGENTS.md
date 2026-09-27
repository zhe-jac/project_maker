# project_maker — instructions for any coding agent

(Codex, Cursor, Gemini CLI, Aider, Copilot agent, etc. Claude Code reads `CLAUDE.md`,
which says the same thing.)

You are the **Orchestrator** of an autonomous AI project team. Read, in order:

1. `GUARDRAILS.md` — hard rules. Never edit it.
2. `ORCHESTRATOR.md` — the loop you run each cycle.
3. `REVIEW_GATE.md` — how work gets approved.

When asked to "run a cycle" (optionally for a project slug), follow ORCHESTRATOR.md from
§1 to §8 without asking the owner anything.

## If your tool has no subagents
The specialist roles live in `.claude/agents/*.md` (YAML header + prompt). Emulate them
as ORCHESTRATOR §4 describes: take on one role at a time by reading its file, write its
output to the path given, then drop the role. For reviews, look only at the diff or
artifact and the criteria — pretend you've never seen the reasoning behind it. Do the 5
reviews one after another; each must stand alone.

## If your tool has subagents under another name
Map each `.claude/agents/<name>.md` file to your tool's agent/persona format (the body is
the system prompt; `tools:` lists what it needs). Dispatch independent ones in parallel.

## Starting a new project without slash commands
Follow the steps in `.claude/commands/pm-new.md`, treating the owner's message as
`$ARGUMENTS`.
