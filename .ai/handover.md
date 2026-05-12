# handover.md - Chat Handover Protocol

Use this file when switching between chat agents or resuming work after interruption.

## Purpose

- Preserve task state across chats.
- Prevent duplicated work.
- Make the next agent resume from the correct unchecked item.
- Keep model selection visible during handoff.

## Required Before Switching Chat

Before leaving a chat, the current agent must:

1. Update `.ai/scratchpad.md`.
2. Append a short entry to `.ai/MEMORY.md`.
3. Confirm the next unchecked `[ ]` item.
4. Send a `[HANDOVER]` block using the template below.

## Handover Template

```markdown
[HANDOVER]
Task: [task title]
Date: YYYY-MM-DD HH:MM
Current Phase: [x/y]
Work Window: [1 | 2]
Execution Scope: [subphase | phase]
Last Completed: [Phase/Step + time]
Next Step: [next Phase/Step]
Model Plan: main: [model-or-alias] | alternative: [model-or-alias] | review: [model-or-alias]
Changed Model?: [No / Yes -> short reason]
Files Touched: [path1, path2]
Scratchpad: [updated / not-updated]
Memory Log: [updated / not-updated]
Blocker: [none / explain]
```

## Resume Protocol For New Chat

The new chat agent must:

1. Read `.ai/models.md`.
2. Read `.ai/scratchpad.md`.
3. Read this file.
4. Resume from the first unchecked `[ ]` item in `CURRENT PLAN`.
5. Confirm the active model alias before execution.

## Handover Quality Gate

Do not continue execution if:

- `Scratchpad` is `not-updated`.
- `Memory Log` is `not-updated`.
- `Next Step` is missing.
- `Model Plan` is missing `main | alternative | review`.

If any item fails, emit `[BLOCKED]` and request a corrected handover.
