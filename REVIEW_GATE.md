# REVIEW GATE — how ideas and code get approved

Two gates, same mechanics. Five independent reviewers, each with a different lens. They
run **in parallel**, in **fresh context**, and **don't see each other's reviews** (no
groupthink). The author never reviews its own work.

## 0. Mechanics (both gates)

1. **Package the thing under review.** Code: branch name, `git diff main...<branch>`,
   the task's acceptance criteria, test command + its latest output. Idea: the idea
   write-up + the research SYNTHESIS + judging criteria. Don't include the author's
   argument for why it's good beyond a 3-line description — reviewers judge the artifact.
2. **Dispatch all 5 reviewers at once.** Each writes to
   `.pm/reviews/<ID>/round-<r>-<reviewer>.md` using `templates/REVIEW.md`.
3. **Consolidate.** Write `.pm/reviews/<ID>/round-<r>-SUMMARY.md`: scores, verdicts, and a
   deduplicated list of blocking points.
4. **Pass rule:**
   - **zero** `BLOCK` verdicts, **and**
   - mean score ≥ **7.0/10** (code) or ≥ **7.5/10** (idea), **and**
   - no single score < 5.
5. **On fail:** the author gets the consolidated blocking points. For each: `FIXED`
   (with where) or `DISPUTED` (with evidence). Round r+1 goes to **all reviewers who
   blocked or scored < 7**, plus any reviewer whose area the fix touched. A disputed point
   is settled by the reviewer who raised it; if they still disagree, the orchestrator
   decides and logs it in DECISIONS.md.
6. **Max 3 rounds.** Still failing → task `blocked`, reviews linked in the summary for
   the owner. Don't loop forever.
7. Non-blocking points (`NIT`, `SUGGESTION`) become backlog items tagged `from-review` if
   they're worth doing; otherwise they're dropped. Don't block merges on nits.

### Severity scale (reviewers must use it)
- `BLOCK` — wrong, unsafe, broken, violates acceptance criteria/rules, or would embarrass
  us in front of a user/judge. Must cite evidence (file:line, command output, URL).
- `MAJOR` — should fix before milestone review, doesn't block this merge.
- `NIT` / `SUGGESTION` — optional.

Reviewers who can't find anything blocking must still name the **single weakest point**.
"LGTM" with no content is an invalid review; the orchestrator re-runs it.

## 1. Code Gate — 5 lenses

| Reviewer | Asks |
|----------|------|
| `review-correctness` | Does it do what the acceptance criteria say? Do tests exist, run, and actually test the behavior? Edge cases, off-by-ones, error paths. Runs the tests itself. |
| `review-security` | Secrets, injection, authz/authn, input validation, dependency risk, data exposure, prompt injection in LLM features, unsafe defaults. |
| `review-architecture` | Fits ARCHITECTURE.md? Right abstraction level, naming, duplication, coupling, will the next 3 backlog tasks be easy or painful on top of this? |
| `review-product` | Does it serve the user story / judging criteria? UX, copy, empty/error/loading states, accessibility basics. In hackathon mode: "would this impress *these* judges in the demo?" |
| `review-reliability` | Failure modes, performance, timeouts, retries, resource leaks, concurrency, flaky tests, what happens on the demo Wi-Fi. |

The gate is scaled, not skipped:
- **Task gate** (every merge): all 5.
- **Milestone gate**: all 5 on the cumulative diff + `qa` runs the app end to end.
- Trivial changes (docs typos, pure `.pm/` state) skip the gate — code never does.

## 2. Idea Gate — 5 lenses

Used for: choosing the project idea, major pivots, the plan, and writing deliverables
(pitch, Devpost write-up, demo script) — for deliverables use the 2–3 most relevant.

| Reviewer | Asks |
|----------|------|
| `idea-judge` | Scores against the **actual judging rubric**, role-playing each researched judge. Would it place? In which tracks? |
| `idea-originality` | Has this won/been done before (past winners, competitors)? What's genuinely new? Is it on the "overdone" list? |
| `idea-feasibility` | Can this team build the demo-able core in the time available with this stack? What's the riskiest unknown, and can it be prototyped in the first cycle? |
| `idea-market` | Is the problem real and specific? Who exactly has it? Would they use/pay? (In hackathon mode: does the story of the user land in 30 seconds?) |
| `idea-demo` | Is there a clear "wow" moment in a 2–3 minute demo? Can it be shown, not told? Is the narrative memorable? |

## 3. Reviewer independence rules

- Fresh subagent per review round — never reuse an author's context.
- Different reviewers may use different models (set `model:` in the agent file) for
  diversity of blind spots.
- Reviewers may run read-only commands (tests, linters, the app) but never edit files in
  the branch under review.
