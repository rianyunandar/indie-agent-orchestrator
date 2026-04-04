# RULES.md — Operational Rules & Absolute Prohibitions
# READ-ONLY. Do not modify. These rules apply to ALL projects.
# Stack-specific patterns → .ai/skills/<name>.md
# ═══════════════════════════════════════════════════════════════════════════════

---

## ABSOLUTE PROHIBITIONS (INSTANT STOP)

Violating any of these triggers an immediate halt and `[BLOCKED]` report.

| # | Prohibition |
|---|------------|
| P1 | Writing or modifying any source file before receiving "Lanjut" from the Tech Lead |
| P2 | Hardcoding credentials, API keys, tokens, or passwords anywhere in source |
| P3 | Building SQL queries via string concatenation |
| P4 | Rendering user input in HTML without sanitization |
| P5 | Committing `.env` files, private keys, or certificates |
| P6 | Using `--no-verify` on git commits (bypasses quality hooks) |
| P7 | Using `--force` on git push without explicit Tech Lead approval |
| P8 | Modifying READ-ONLY files: `.clinerules`, `.ai/RULES.md`, `.ai/AGENTS.md`, `.ai/SKILLS.md`, `.ai/skills/*.md` |
| P9 | Proceeding after 3 circuit breaker attempts without human intervention |
| P10 | Silently swallowing exceptions (`catch (e) {}` with no handling) |

---

## RULE 1 — DYNAMIC RETRIEVAL BEFORE EVERY TASK

```bash
ls .ai/skills/              # see what is available
cat .ai/skills/<name>.md    # load relevant skill(s)
```

Never work from memory alone on a technical task.
Never assume a pattern is "standard" without reading the skill file.

---

## RULE 2 — PLAN FIRST, CODE NEVER (until approved)

Every non-trivial task requires a plan in `.ai/scratchpad.md` BEFORE touching code.
"Non-trivial" = anything touching more than 2 lines across more than 1 file.

Plan format is defined in `.clinerules` Pillar 3.
After writing: `[PLAN]` prefix → stop → wait for "Lanjut".

---

## RULE 3 — MICRO-SAVE EVERY STEP

After completing each file or phase:
1. Mark the corresponding scratchpad checkbox `[x]`
2. Append a `[DONE]` entry to `.ai/MEMORY.md`
3. Emit a `[SAVE POINT]` report if 2+ files were just completed
4. **Only then** proceed to the next item

The next agent (after a timeout) reads scratchpad to find resume point.

---

## RULE 4 — IMMUTABILITY

Never mutate parameters, arguments, or shared state in-place.
Always return a new copy with the change applied.

```
# WRONG
function process(data) { data.status = 'done'; return data; }

# RIGHT
function process(data) { return { ...data, status: 'done' }; }
```

---

## RULE 5 — SINGLE RESPONSIBILITY

- One function = one purpose
- One file = one domain concept (max 500 lines)
- One service = one bounded context

When a unit starts doing two things, split it before the PR.

---

## RULE 6 — ERRORS MUST SURFACE

Every caught exception must be either: (a) handled with domain logic, or
(b) re-thrown / forwarded to a centralized error handler with context attached.

Logging the error AND re-throwing is preferred over silent swallowing.

---

## RULE 7 — VALIDATE AT BOUNDARIES

Validate ALL external input (user, API, file, env) at system entry points.
Use schema-based validation (Zod, Joi, Pydantic, FormRequest, etc.).
Internal function calls between trusted layers do NOT need re-validation.

---

## RULE 8 — ARCHITECTURE CHANGES NEED APPROVAL

If the task requires:
- A new service / module / database table
- A new external API integration
- A change that crosses bounded-context boundaries
- A large refactor affecting >5 files

→ Load `.ai/skills/architecture-decision-records.md`
→ Draft an ADR in scratchpad
→ Present to Tech Lead before writing a single line

---

## RULE 9 — TEST COVERAGE GATE

**Minimum 80% coverage on all changed files.**
Tests are written BEFORE implementation (TDD cycle).
Coverage below 80% = task is NOT done. Write more tests.

---

## RULE 10 — GIT HYGIENE

Every commit:
- Follows Conventional Commits: `<type>(<scope>): <description>`
- Is atomic and focused (one logical change per commit)
- Passes the pre-commit hook: `bash .ai/hooks/pre-commit.sh`

---

## RULE 11 — MEMORY ROLLING WINDOW

`.ai/MEMORY.md` must stay under **200 lines**.

When approaching 200 lines:
1. Create `## Archive [YYYY-MM-DD]` section at top
2. Summarize sessions older than 3 completed tasks into a paragraph
3. Delete the raw entries that were summarized
4. Target: keep active file under 150 lines

---

## RULE 12 — COMMUNICATION DISCIPLINE

Use only the status prefixes defined in `.clinerules`.
No lengthy preambles. No restating what you're about to do.
One focused question when blocked — not a list of questions.

---

*READ-ONLY. Version 3.0.0. These rules are universal — project-agnostic.*
