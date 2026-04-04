# scratchpad.md — Agent Planning Workspace & Micro-Save Tracker
# Agent: overwrite CURRENT PLAN section for each new task.
# Keep ARCHIVED PLANS for session continuity reference.
# ═══════════════════════════════════════════════════════════════════════════════
# RESUME PROTOCOL (after timeout/interruption):
#   1. Read this file to find last [x] checkbox
#   2. Resume from first [ ] item
#   3. Log resume event to .ai/MEMORY.md
# ═══════════════════════════════════════════════════════════════════════════════

---

## PLAN TEMPLATE

Copy this block for every new task. Delete and replace the CURRENT PLAN section.

```markdown
## Plan: [Task Title]
Date: YYYY-MM-DD HH:MM
Status: AWAITING APPROVAL | IN PROGRESS | DONE | BLOCKED
Skills Loaded:
  - .ai/skills/[name].md
  - .ai/skills/[name].md

### Objective
[One sentence: what will be done and why.]

### Stack Context
[Paste relevant rows from .ai/ARCHITECTURE.md Section 1 here]

### Affected Files
- [ ] path/to/file.ext  →  new | modify | delete

### Phases & Micro-Save Checkpoints
- [ ] Phase 1 / Step 1: [file or task]        [ETA: small]
- [ ] Phase 1 / Step 2: [file or task]        [ETA: small]
- [ ] Phase 2 / Step 1: [file or task]        [ETA: small]
- [ ] Phase 2 / Step 2: [test file]           [ETA: small]

### Risks & Mitigations
- [Risk description] → [Mitigation approach]

### Definition of Done
- [ ] All phase checkboxes marked [x]
- [ ] Tests pass (coverage ≥ 80%)
- [ ] No lint / type / build errors
- [ ] Security checklist passed (load security-review.md if applicable)
- [ ] Tech Lead approved → merge
```

---

## CURRENT PLAN

[No active plan. Write one before beginning any non-trivial task.]

Fill using the template above, then report:
`[PLAN] Plan written to scratchpad. Waiting for "Lanjut".`

---

## HOW TO USE MICRO-SAVE CHECKBOXES

After completing EACH file or step:

1. Change `[ ]` to `[x]` **immediately** in this file
2. Append a log entry to `.ai/MEMORY.md`
3. If 2 files just completed → emit `[SAVE POINT]` block (see .clinerules Pillar 4)
4. Continue to next `[ ]` item

**Example of in-progress plan:**
```
- [x] Phase 1 / File: src/services/AuthService.ts   — DONE 2024-01-15 09:14
- [x] Phase 1 / File: src/types/auth.types.ts       — DONE 2024-01-15 09:22
                                                       ↑ [SAVE POINT] emitted here
- [ ] Phase 2 / File: src/controllers/AuthController.ts
- [ ] Phase 2 / File: tests/auth.controller.test.ts
- [ ] Phase 3 / File: docs/auth-api.md
```

**If session drops** — next agent sees checkboxes, knows exactly where to resume.

---

## ARCHIVED PLANS

[Completed plans move here when replaced by a new Current Plan.]
[Format: ## ARCHIVED: [Task Title] [YYYY-MM-DD] DONE]
