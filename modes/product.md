# Mode: PRODUCT (startup / company)

Goal: a product real people would use and pay for, run like a small company. The
orchestrator acts as CEO/CTO's chief of staff; agents are the departments.

## Intake additions (BRIEF.md)
- The problem/vision in the owner's words, target users, constraints (budget, time,
  platforms), what "success" means in 1 month / 3 months.
- Existing assets: domains, repos, audiences, data, partners.

## Research (Phase 1) — parallel
1. **`market.md`** — `market-analyst`: who has the problem, how many, how they solve it
   today, willingness to pay, trends. Cite sources.
2. **`competitors.md`** — `market-analyst`: 5–15 competitors/alternatives (incl. "do
   nothing" and spreadsheets). Pricing, positioning, reviews (what users complain about),
   gaps.
3. **`users.md`** — `researcher`: user personas from public evidence (forums, Reddit,
   reviews, support threads). Real quotes with links — never invented.
4. **`tech.md`** — `researcher`: build-vs-buy for key components, APIs, costs at scale.
5. `SYNTHESIS.md` + the **wedge**: the narrowest version that's clearly better for one
   specific user.

## Ideation (Phase 2)
`ideator` produces 10+ product concepts / positioning angles; Idea Gate (in this mode
`idea-judge` role-plays an early-stage investor and a target customer instead of
hackathon judges).

## Workstreams ("departments")
Plan the backlog in parallel workstreams so agents can run concurrently:

| Workstream | Typical deliverables | Agents |
|------------|----------------------|--------|
| Product | PRD, user stories, success metrics, roadmap | `planner`, `critic` |
| Engineering | MVP, tests, CI, deploy, monitoring | `architect`, `engineer`, `qa` |
| Design | flows, UI kit, landing page | `designer` |
| Growth/GTM | positioning, landing copy, launch plan, pricing page, content | `writer`, `market-analyst` |
| Ops/Legal | ToS/privacy drafts (flagged for human review), analytics, cost model | `writer`, `researcher` |
| Fundraising (optional) | pitch deck outline, one-pager, financial model assumptions | `writer`, `market-analyst` |

## Default Definition of Done (MVP)
- A new user can sign up/start, get the core value, and come back — end to end.
- Deployed, monitored, with error tracking. Costs per active user estimated.
- Landing page + launch plan ready (launch itself requires owner approval).

## Cadence
`cycle_hours: 3`, `cycle_minutes: 100` by default. Every 5th cycle, run a **strategy
review**: Idea Gate on "are we still building the right thing?" using everything learned.
