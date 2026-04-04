# AGENTS.md — Agent Registry (Project-Agnostic)
# READ-ONLY. Invoke agents by passing the TRIGGER + task to the relevant agent context.
# ─────────────────────────────────────────────────────────────────────────────

---

## AGENT ROSTER

| Agent | File | Trigger | Expertise |
|-------|------|---------|-----------|
| planner | `agents/planner.md` | Complex feature planning | Technical decomposition, phased implementation plans |
| tdd-guide | `agents/tdd-guide.md` | New features, bug fixes | Red-Green-Refactor, coverage gates |
| code-reviewer | `agents/code-reviewer.md` | After ANY code change | Quality, maintainability, patterns |
| security-reviewer | `agents/security-reviewer.md` | Auth, secrets, uploads, APIs | OWASP Top 10, threat modeling |
| architect | `agents/architect.md` | Architecture decisions | System design, ADRs, trade-offs |
| database-reviewer | `agents/database-reviewer.md` | Schema changes, slow queries | Query optimization, migration safety |
| build-error-resolver | `agents/build-error-resolver.md` | Build / type / compile errors | Diagnostics, minimal-diff fixes |
| refactor-cleaner | `agents/refactor-cleaner.md` | Dead code, cleanup sprints | Safe removal, dependency audit |
| e2e-runner | `agents/e2e-runner.md` | Critical user flows | Playwright, Page Object Model |
| performance-optimizer | `agents/performance-optimizer.md` | Slow pages, high latency | Bundle, DB, Core Web Vitals |
| doc-updater | `agents/doc-updater.md` | After feature completion | README, API docs, codemaps |

Full agent definitions live in the `agents/` directory at repo root.

---

## DELEGATION TRIGGER MAP

| Situation | Invoke |
|-----------|--------|
| New feature request | `planner` → `tdd-guide` |
| Code just written | `code-reviewer` |
| Security-sensitive change | `security-reviewer` |
| Build or type errors after 3 failed attempts | `build-error-resolver` |
| Slow queries / performance issues | `database-reviewer` + `performance-optimizer` |
| Architecture decision needed | `architect` |
| Dead code / maintenance sprint | `refactor-cleaner` |
| Critical user flow testing | `e2e-runner` |
| After major feature ship | `doc-updater` |

---

## HOW TO INVOKE

In Roo Code or Copilot Chat:

```
1. Read the agent file:
   cat agents/<agent-name>.md

2. Start the agent with context:
   "You are acting as the [AgentName] agent.
    Stack: [paste stack from .ai/ARCHITECTURE.md Section 1]
    Task: [describe task]"

3. Pass relevant files as context:
   [attach or paste the diff / file being reviewed]
```

---

## CIRCUIT BREAKER HANDOFF FORMAT

When routing to an agent after circuit breaker:

```
Agent: build-error-resolver
Context: .ai/ARCHITECTURE.md (Section 1)
Error:
  [paste last error verbatim]
Attempts: 3
Tried:
  1. [approach]
  2. [approach]
  3. [approach]
```

---

## EXTENDING THE ROSTER

To add a new agent:
1. Create `agents/<name>.md` following the frontmatter format in existing agents
2. Add a row to the AGENT ROSTER table above
3. Add trigger condition to the DELEGATION TRIGGER MAP

---

*Agent implementations are in `agents/` at repo root.*
*This file is the delegation routing index only.*
