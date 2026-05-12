# scratchpad.md - Agent Planning Workspace & Micro-Save Tracker
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

### Execution Window
WORK_WINDOW: 1 | 2   # default: 2
EXEC_SCOPE: subphase | phase

### Task Type
TASK_TYPE: coding | architecture | docs | quick_fix | cheap_task | review | security | handover

### Model Selection Rules
- Use `.ai/models.md` section `Phase & Subphase Model Guide` as the reference.
- Use `.ai/models.md` section `Task Type Defaults` when the phase is not specific enough.
- Every phase or subphase MUST have 3 selections:
  `main: ... | alternative: ... | review: ...`
- Use model aliases when possible (example: `codex_main`, `reasoning_main`).
- `main` is used for primary execution.
- `alternative` is used if `main` is OFF / error / rate-limited.
- `review` is used to validate output before completion.

### Affected Files
- [ ] path/to/file.ext  ->  new | modify | delete

### Phases & Micro-Save Checkpoints
- [ ] Phase 1 / Step 1: [file or task]        [ETA: small]
      model: main: [model-or-alias] | alternative: [model-or-alias] | review: [model-or-alias]
- [ ] Phase 1 / Step 2: [file or task]        [ETA: small]
      model: main: [model-or-alias] | alternative: [model-or-alias] | review: [model-or-alias]
- [ ] Phase 2 / Step 1: [file or task]        [ETA: small]
      model: main: [model-or-alias] | alternative: [model-or-alias] | review: [model-or-alias]
- [ ] Phase 2 / Step 2: [test file]           [ETA: small]
      model: main: [model-or-alias] | alternative: [model-or-alias] | review: [model-or-alias]

### Risks & Mitigations
- [Risk description] -> [Mitigation approach]

### Pre-Done Check (Mandatory)
- [ ] scratchpad=updated
- [ ] memory=logged
- [ ] remaining_checkboxes=0
- [ ] all_steps_have_model_line=true

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

1. Change `[ ]` to `[x]` immediately in this file.
2. Append a log entry to `.ai/MEMORY.md`.
3. Emit `[SAVE POINT]` whenever `WORK_WINDOW` limit is reached.
4. Continue to the next `[ ]` item.
5. If model choice changes during execution, update the `model:` line in the related step.

Mandatory per-step output:

```markdown
[STEP DONE] <phase/step> | scratchpad=updated | memory=logged | model=<model-name-or-alias>
```

If session drops, the next agent must resume from the first unchecked `[ ]` item.

---

## HANDOVER

Use `.ai/handover.md` whenever switching chats or resuming with another agent.

Rules:
- Before switching chat: must send `[HANDOVER]`.
- New chat must read `.ai/models.md`, `.ai/scratchpad.md`, and `.ai/handover.md`.
- New chat must continue from the first `[ ]` checkbox in `CURRENT PLAN`.

---

## FLEX MODE (PER 1 / PER 2 SUBPHASE)

Use this in every `CURRENT PLAN`:

```markdown
### Execution Window
WORK_WINDOW: 1 | 2   # default: 2
EXEC_SCOPE: subphase | phase
```

Interpretation:
- `WORK_WINDOW: 1` -> update scratchpad + memory + save point for every completed subphase.
- `WORK_WINDOW: 2` -> update scratchpad + memory + save point for every 2 completed subphases.
- `EXEC_SCOPE: phase` -> agent may complete one full phase before stopping, while still checking off every step individually.

Example checkpoint:

```markdown
- [x] Phase 1 / Step 1: ...
      model: main: codex_main | alternative: fallback_fast | review: reasoning_main

[SAVE POINT]
Window: 1
Last Completed: Phase 1 / Step 1
Next: Phase 1 / Step 2
Scratchpad: updated
Memory: logged
```

---

## ARCHIVED PLANS

[Completed plans move here when replaced by a new Current Plan.]
[Format: ## ARCHIVED: [Task Title] [YYYY-MM-DD] DONE]
