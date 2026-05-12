# install-checklist.md - Project Installation Checklist

Use this checklist when installing this agentic framework into a new repository.

## Download Without `.git`

Source repository:

```txt
https://github.com/rianyunandar/indie-agent-orchestrator
```

Recommended:

```bash
npx degit rianyunandar/indie-agent-orchestrator temp-agent-kit
```

Alternative:

```bash
curl -L https://github.com/rianyunandar/indie-agent-orchestrator/archive/refs/heads/main.zip -o indie-agent-orchestrator.zip
unzip indie-agent-orchestrator.zip
```

Both methods download the framework without copying the source repository `.git` history.

## Required Files

- [ ] `.clinerules`
- [ ] `.ai/RULES.md`
- [ ] `.ai/ARCHITECTURE.md`
- [ ] `.ai/scratchpad.md`
- [ ] `.ai/MEMORY.md`
- [ ] `.ai/models.md`
- [ ] `.ai/handover.md`
- [ ] `.ai/install-checklist.md`
- [ ] `.ai/packages.md`
- [ ] `.ai/SKILLS.md`
- [ ] `.ai/AGENTS.md`
- [ ] `.ai/skills/`
- [ ] `.ai/hooks/`

## First Run

- [ ] Run session bootstrap: `bash .ai/hooks/session-boot.sh`
- [ ] Fill `.ai/ARCHITECTURE.md` with discovered stack details.
- [ ] Review `.ai/models.md` and confirm model statuses.
- [ ] Confirm model aliases resolve to `ON` models.
- [ ] Create the first `CURRENT PLAN` in `.ai/scratchpad.md`.
- [ ] Set `TASK_TYPE`, `WORK_WINDOW`, and `EXEC_SCOPE`.
- [ ] Confirm every phase/subphase has `main | alternative | review`.

## Ready Criteria

- [ ] Bootstrap completed.
- [ ] Architecture context is filled.
- [ ] Active models are verified.
- [ ] Scratchpad has a valid plan or explicitly says no active plan.
- [ ] Handover protocol is available for chat switching.

If any item is incomplete, keep the repository in setup mode and do not start implementation work yet.
