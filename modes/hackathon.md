# Mode: HACKATHON

Goal: **win** — first overall and/or the most valuable tracks the project can credibly
enter — while shipping something real. Everything is planned backward from the
submission deadline and judged through the eyes of *these specific* judges.

## Intake additions (BRIEF.md)
- Event name, URL, Devpost/registration URL, dates, **submission deadline with timezone**.
- In-person/virtual, event length, team size and members' skills (ask owner only if
  unknown and it changes the plan; otherwise assume "owner + AI, full-stack").
- Pre-existing code rules; required tech; submission requirements (video length, repo,
  deployed link, slides, Devpost fields).
- `cycle_minutes` / `cycle_hours`: for a live 24–36 h event, set `cycle_hours: 1` and
  `cycle_minutes: 50` so the owner gets hourly check-ins. Before the event: 2–3 h.

## Research (Phase 1) — dispatch in parallel

Each area writes its own file in `.pm/research/`. Cite a URL for every claim. Mark
anything inferred as **(inferred)**.

1. **`event.md`** — `hackathon-scout`
   Rules, eligibility, schedule, submission checklist, judging process (expo vs stage,
   minutes per team, rounds, who judges which round), **judging criteria with weights**,
   prizes (overall, tracks, sponsor, "best X"), which prizes can stack.
   Sources: event site, Devpost overview/rules/prizes pages, organizer socials, Discord
   announcements if public, the hacker guide/Notion.

2. **`tracks.md`** — `hackathon-scout`
   One section per track/sponsor prize: sponsor, what they literally ask for, what they
   *actually* want (dev-rel goals: adoption of their API/product), required tech, prize,
   how many projects entered last year, judging for that prize (sponsor rep?), and our
   fit score. Include the sponsor's API docs/quickstarts and how hard integration is.

3. **`past_winners.md`** — `hackathon-scout`
   - Every previous edition of **this** event: all winners and **per-track winners**.
     Devpost: `https://<event>.devpost.com/project-gallery` (filter "Winners"), plus each
     year's subdomain (e.g. `<event>-2024.devpost.com`). Also MLH, organizer blog/recaps.
   - Winners of **the same sponsor's track at other hackathons** (sponsors re-run tracks).
   - Winners of 3–5 comparable events (same size/region/theme).
   - Table: year · event · project · prize/track · one-liner · tech · demo format · link ·
     *why it probably won*. Watch their demo videos where available.

4. **`judges/<name>.md`** — `judge-profiler`, one agent per judge (parallel)
   Public professional info only: current role & company, background, what they've
   built/shipped/invested in/written/talked about, recent posts, technical depth,
   causes they care about, companies in their portfolio, previous hackathons they judged
   and what won there. End with: **likely priorities, likely pet peeves, the question
   they'll probably ask, how to pitch to them in one sentence.**
   If judges aren't announced yet: profile last edition's judges + the sponsor reps, and
   add a backlog task to re-run when announced.

5. **`patterns.md`** — `researcher` (after 3 finishes)
   What winners have in common (polish vs novelty, technical depth, social impact, live
   demo, hardware, AI usage…). **The graveyard:** ideas that are overdone at this event /
   in general right now (e.g. yet another "AI study buddy", "carbon tracker", "mental
   health chatbot") — these need a very strong twist or should be avoided. Gaps nobody has
   won with yet.

6. **`team_and_constraints.md`** — orchestrator
   Owner's skills, available hardware, accounts/API keys already owned, hours actually
   available, what can be pre-built legally.

Then `SYNTHESIS.md` (see ORCHESTRATOR Phase 1), plus a **prize strategy**: which
combination of tracks one project can credibly win, and the expected-value reasoning.

## Ideation (Phase 2)

`ideator` generates **≥ 20 raw ideas** using at least five generators:
1. **Judge-first** — what would make judge X lean forward?
2. **Sponsor-first** — the most impressive possible use of sponsor tech (sponsor prizes
   are usually less competitive than overall).
3. **Pattern remix** — a past winning pattern moved into a domain it hasn't been in.
4. **Problem-first** — a specific person with a painful, concrete problem.
5. **Capability-first** — something that only became possible recently (new model, API,
   hardware), so it can't have won before.
6. **Stack-the-prizes** — one idea that legitimately fits overall + 2–3 tracks.

Filter out the graveyard, then score the rest in a matrix whose columns are the **official
judging criteria with their weights**, plus: track fit, feasibility in time, demo wow,
originality vs past winners. Shortlist top 3–5 → **Idea Gate**. Pick winner + backup.

## Deliverables (default DELIVERABLES.md for this mode)
1. Working product — the **demo path is bulletproof** (seeded data, no login walls,
   works offline or with a fallback, fast).
2. Deployed/shareable link if allowed and cheap.
3. Repo: clean README (what, why, how to run, architecture diagram, team, what was built
   during the event), `.env.example`, license if required.
4. Devpost write-up: Inspiration · What it does · How we built it · Challenges ·
   Accomplishments · What we learned · What's next — plus per-track paragraphs explaining
   how the project meets each track's ask.
5. Demo video script + shot list under the time limit; screen-recording checklist.
6. Pitch: 3-minute live-demo script and a slide outline (problem → wow demo → how →
   impact → ask). Tailored openers per judge.
7. **Judge Q&A prep**: the 15 most likely questions (per judge profile) with crisp answers.
8. Backup demo recording in case live demo fails.

Writing deliverables go through the Idea Gate reviewers `idea-judge` + `idea-demo`
(+ `idea-market` for the pitch).

## Timeline rules
- Plan backward from the deadline. Default split for a 36 h event: 10% research/idea,
  60% build, 15% polish, 15% deliverables & rehearsal. Scale for other lengths.
- **Feature freeze** at 75% of build time. After that only bug fixes and demo polish.
- The demo path is built **first** end to end (ugly), then deepened. Never be in a state
  where there is nothing to demo.
- Submission package drafted by 85% of total time; nothing is submitted without the
  owner's approval (GUARDRAILS) — have it ready and flagged at the top of REVIEW_ME.md
  at least 2 hours before the deadline.
