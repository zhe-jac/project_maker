---
description: Run the 5-reviewer Code Gate (or Idea Gate) on a branch, diff, or document on demand
argument-hint: <branch | path-to-doc> [--repo <path>] [--idea]
---

Run a review gate on: $ARGUMENTS

1. Read `REVIEW_GATE.md` and `templates/REVIEW.md`.
2. If `--idea` or the target is a document → **Idea Gate** (`idea-judge`,
   `idea-originality`, `idea-feasibility`, `idea-market`, `idea-demo`).
   Otherwise → **Code Gate** (`review-correctness`, `review-security`,
   `review-architecture`, `review-product`, `review-reliability`) on
   `git diff main...<branch>` in the given repo (default: current project).
3. Dispatch all five reviewers in parallel (one message), each writing to
   `.pm/reviews/adhoc-<timestamp>/<reviewer>.md` (or `reviews/adhoc-<timestamp>/` in the
   engine repo if there's no project).
4. Consolidate per REVIEW_GATE §0 and reply with: verdict, scores table, deduplicated
   blocking points, and the top non-blocking suggestions. Don't fix anything unless asked.
