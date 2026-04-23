# SKILLS.md — Skill Registry (Index Only)
# This file is an INDEX. Each skill is a separate .md file in .ai/skills/
# Load a skill: cat .ai/skills/<name>.md
# List all:     ls .ai/skills/
# ─────────────────────────────────────────────────────────────────────────────

---

## Available Skills

| Skill File | What It Covers | When to Load |
|------------|----------------|--------------|
| [tdd-workflow.md](.ai/skills/tdd-workflow.md) | Red-Green-Refactor cycle, coverage gates, test case templates | Any new feature or bug fix |
| [api-design.md](.ai/skills/api-design.md) | REST URL structure, HTTP methods, status codes, pagination, versioning | Designing or reviewing API endpoints |
| [security-review.md](.ai/skills/security-review.md) | OWASP checklist, secrets management, input validation, XSS/SQLi/CSRF | Auth, uploads, secrets, new API routes |
| [coding-standards.md](.ai/skills/coding-standards.md) | Naming, file structure, KISS/DRY/YAGNI, formatting rules | Code structure, naming, refactoring |
| [backend-patterns.md](.ai/skills/backend-patterns.md) | Repository pattern, service layer, error handling, API response envelope | Building service/repo/controller layers |
| [frontend-patterns.md](.ai/skills/frontend-patterns.md) | Component architecture, state management, hooks patterns, performance | React/Vue/Svelte frontend work |
| [database-migrations.md](.ai/skills/database-migrations.md) | Zero-downtime migrations, expand-contract, index safety, rollback | Any schema/migration changes |
| [e2e-testing.md](.ai/skills/e2e-testing.md) | Playwright, Page Object Model, selectors, CI integration | E2E test authoring or debugging |
| [git-workflow.md](.ai/skills/git-workflow.md) | Branching strategy, commit format, PR workflow, conflict resolution | Any git branch/commit/merge/PR operation |
| [architecture-decision-records.md](.ai/skills/architecture-decision-records.md) | ADR format, how to document architecture decisions | Any architectural choice crossing module boundaries |
| [deployment-patterns.md](.ai/skills/deployment-patterns.md) | CI/CD pipelines, blue-green, canary, rollback strategies | Deploy pipeline or release planning |
| [docker-patterns.md](.ai/skills/docker-patterns.md) | Dockerfile best practices, multi-stage builds, compose patterns | Container or local dev setup |
| [verification-loop.md](.ai/skills/verification-loop.md) | Quality verification checklist, pre-commit gate, Definition of Done | Before opening any PR or marking task done |
| [codebase-onboarding.md](.ai/skills/codebase-onboarding.md) | How to explore an unknown codebase systematically | First session in any new repo |
| [production-debugging.md](.ai/skills/production-debugging.md) | Production debugging discipline, error taxonomy, env vars, cross-platform hazards, process manager, async errors, deploy hygiene | Production down, deploy failure, env/config issues, Windows→Linux hazards |

---

## How to Add a New Skill

1. Create `.ai/skills/<skill-name>.md`
2. Use the frontmatter format:
   ```yaml
   ---
   name: skill-name
   description: One-line summary of what this skill covers.
   origin: local | ECC | custom
   ---
   ```
3. Add a row to the table above.

The original `skills/` directory at the repo root contains 100+ additional reference
skills. Copy any you need: `Copy-Item skills/<name>/SKILL.md .ai/skills/<name>.md`

---

## Loading Pattern (for agents)

```bash
# Discover
ls .ai/skills/

# Load single skill
cat .ai/skills/tdd-workflow.md

# Load multiple skills for a complex task
cat .ai/skills/api-design.md .ai/skills/security-review.md

# Search for a skill by keyword
grep -l "migration\|schema" .ai/skills/*.md
```

---

*SKILLS.md is an index only. Full content is in the individual .md files above.*
