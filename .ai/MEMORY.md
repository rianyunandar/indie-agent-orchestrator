# MEMORY.md — Session State & Rolling Window Log
# Agent: append to ACTIVE LOG. Never delete from DECISIONS table.
# Tech Lead: review DECISIONS table periodically.
# ═══════════════════════════════════════════════════════════════════════════════
# ROLLING WINDOW RULE (from RULES.md Rule 11):
#   When file exceeds 200 lines:
#   1. Add "## Archive [YYYY-MM-DD]" at top
#   2. Compress sessions older than 3 tasks into one paragraph
#   3. Delete the raw entries that were summarised
#   4. Keep active file under 150 lines
# ═══════════════════════════════════════════════════════════════════════════════

---

## PERSISTENT DECISIONS

Record here: architectural choices, discovered constraints, Tech Lead decisions.
These rows are NEVER deleted (archive instead if table gets long).

| Date | Decision | Rationale | Owner |
|------|----------|-----------|-------|
| YYYY-MM-DD | _(Framework initialized: v3.0.0)_ | Project-agnostic baseline | Tech Lead |

---

## CIRCUIT BREAKER HISTORY

Log all circuit breaker events. Repeat patterns = systemic issue.

| Date | Task | Error Summary | Resolved By |
|------|------|--------------|-------------|
| — | — | — | — |

---

## ACTIVE LOG

Format: `[YYYY-MM-DD HH:MM] [STATUS] Description`

Status tags: `[BOOT]` `[PLAN]` `[EXEC]` `[DONE]` `[SAVE POINT]` `[BLOCKED]` `[RESUME]`

```
[YYYY-MM-DD HH:MM] [BOOT]   Framework v3.0.0 initialized. Stack not yet discovered.
```

---

## ARCHIVE

[Old compressed summaries go here when rolling window compression is applied.]

---

## QUICK REFERENCE — LOG ENTRY FORMATS

```
# Session start
[2024-01-15 09:00] [BOOT]   Stack discovered: Node.js 20 / Express / PostgreSQL / React 18

# Plan approved
[2024-01-15 09:05] [PLAN]   Plan approved: "Add user auth endpoints" — 3 phases, 6 files

# phase complete
[2024-01-15 09:22] [EXEC]   Phase 1 done: AuthService.ts + auth.types.ts ✓

# save point
[2024-01-15 09:22] [SAVE]   2 files complete, save point emitted, waiting for Lanjut

# task done
[2024-01-15 10:45] [DONE]   "Add user auth endpoints" complete. Coverage: 87%. PR opened.

# blocked / circuit breaker
[2024-01-15 11:00] [BLOCKED] Circuit breaker triggered on TypeScript error in AuthController. Awaiting Tech Lead.

# resume after interruption
[2024-01-15 14:00] [RESUME] Session resumed. Scratchpad shows Phase 2 Step 1 unchecked. Continuing.
```
