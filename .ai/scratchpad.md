# scratchpad.md — Agent Planning Workspace & Micro-Save Tracker
# Agent: overwrite CURRENT PLAN section for each new task.
# Keep ARCHIVED PLANS for session continuity reference.
# -------------------------------------------------------------------------------
# RESUME PROTOCOL (after timeout/interruption):
#   1. Read this file to find last [x] checkbox
#   2. Resume from first [ ] item
#   3. Log resume event to .ai/MEMORY.md
# -------------------------------------------------------------------------------

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

### Model Selection Rules
- Use `.ai/models.md` section `Phase & Subphase Model Guide` as the reference.
- Every phase or subphase MUST have 3 selections:
  `main: ... | alternative: ... | review: ...`
- `main` is used for primary execution.
- `alternative` is used if `main` is OFF / error / rate-limited.
- `review` is used to validate output before completion.

### Affected Files
- [ ] path/to/file.ext  ->  new | modify | delete

### Phases & Micro-Save Checkpoints
- [ ] Phase 1 / Step 1: [file or task]        [ETA: small]
      model: main: [model] | alternative: [model] | review: [model]
- [ ] Phase 1 / Step 2: [file or task]        [ETA: small]
      model: main: [model] | alternative: [model] | review: [model]
- [ ] Phase 2 / Step 1: [file or task]        [ETA: small]
      model: main: [model] | alternative: [model] | review: [model]
- [ ] Phase 2 / Step 2: [test file]           [ETA: small]
      model: main: [model] | alternative: [model] | review: [model]

### Risks & Mitigations
- [Risk description] -> [Mitigation approach]

### Definition of Done
- [ ] All phase checkboxes marked [x]
- [ ] Every phase/subphase has `main | alternative | review`
- [ ] Tests pass (coverage >= 80%)
- [ ] No lint / type / build errors
- [ ] Security checklist passed (load security-review.md if applicable)
- [ ] Tech Lead approved -> merge
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
3. If 2 files just completed -> emit `[SAVE POINT]` block (see .clinerules Pillar 4)
4. Continue to next `[ ]` item
5. If the model changes during execution, update the `model:` line in the related step.

**Example of in-progress plan:**
```
- [x] Phase 1 / File: src/services/AuthService.ts   — DONE 2024-01-15 09:14
- [x] Phase 1 / File: src/types/auth.types.ts       — DONE 2024-01-15 09:22
                                                       ? [SAVE POINT] emitted here
- [ ] Phase 2 / File: src/controllers/AuthController.ts
      model: main: GPT-5.3-Codex | alternative: GPT-5.2-Codex | review: GPT-5.4
- [ ] Phase 2 / File: tests/auth.controller.test.ts
      model: main: GPT-5.3-Codex | alternative: GPT-5.2 | review: GPT-5.4
- [ ] Phase 3 / File: docs/auth-api.md
      model: main: Claude Sonnet 4.6 | alternative: GPT-5.4 mini | review: GPT-5.4
```

**If session drops** — next agent sees checkboxes, knows exactly where to resume.

---

## ARCHIVED PLANS

[Completed plans move here when replaced by a new Current Plan.]
[Format: ## ARCHIVED: [Task Title] [YYYY-MM-DD] DONE]

## HANDOVER TEMPLATE (PINDAH CHAT AGENT)

Copy-paste this block whenever switching chats:

```markdown
[HANDOVER]
Task: [task title]
Date: YYYY-MM-DD HH:MM
Current Phase: [x/y]
Last Completed: [Phase/Step + waktu]
Next Step: [next Phase/Step]
Model Plan: main: [model] | alternative: [model] | review: [model]
Changed Model?: [No / Yes -> short reason]
Files Touched: [path1, path2]
Scratchpad: [updated / not-updated]
Memory Log: [updated / not-updated]
Blocker: [none / explain]
```

Rule cepat:
- Before switching chat: must send `[HANDOVER]`.
- New chat must read `.ai/scratchpad.md` then continue from the first `[ ]` checkbox.

## FLEX MODE (PER 1 / PER 2 SUBPHASE)

Tambahkan field ini di setiap `CURRENT PLAN`:

```markdown
### Execution Window
WORK_WINDOW: 1 | 2   # default: 2
```

Interpretasi:
- `WORK_WINDOW: 1` -> update scratchpad + memory + save point for every completed subphase
- `WORK_WINDOW: 2` -> update scratchpad + memory + save point for every 2 completed subphases

Contoh checkpoint:
```markdown
- [x] Phase 1 / Step 1: ...
      model: main: ... | alternative: ... | review: ...

[SAVE POINT]
Window: 1
Last Completed: Phase 1 / Step 1
Next: Phase 1 / Step 2
Scratchpad: updated
Memory: logged
```


