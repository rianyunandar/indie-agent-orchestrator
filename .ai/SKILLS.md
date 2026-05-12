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
| [coding-standards.md](.ai/skills/coding-standards.md) | Naming, KISS/DRY/YAGNI; TypeScript/JS, PHP (PSR-12/Laravel), Blade templates, HTML5 | Code structure, naming, refactoring — any stack |
| [backend-patterns.md](.ai/skills/backend-patterns.md) | Repository pattern, service layer, error handling; Node.js/Next.js + PHP/Laravel patterns, MySQL/PostgreSQL config | Building service/repo/controller layers (any stack) |
| [frontend-patterns.md](.ai/skills/frontend-patterns.md) | Component architecture, state management, hooks patterns, performance; HTML5 semantic markup, vanilla JS, accessible forms | React/Next.js frontend work; plain HTML5/vanilla JS projects |
| [database-migrations.md](.ai/skills/database-migrations.md) | Zero-downtime migrations, expand-contract, index safety, rollback; PostgreSQL + MySQL-specific patterns + Laravel migrations | Any schema/migration changes |
| [e2e-testing.md](.ai/skills/e2e-testing.md) | Playwright, Page Object Model, selectors, CI integration | E2E test authoring or debugging |
| [git-workflow.md](.ai/skills/git-workflow.md) | Branching strategy, commit format, PR workflow, conflict resolution | Any git branch/commit/merge/PR operation |
| [architecture-decision-records.md](.ai/skills/architecture-decision-records.md) | ADR format, how to document architecture decisions | Any architectural choice crossing module boundaries |
| [deployment-patterns.md](.ai/skills/deployment-patterns.md) | CI/CD pipelines, blue-green, canary, rollback strategies | Deploy pipeline or release planning |
| [docker-patterns.md](.ai/skills/docker-patterns.md) | Dockerfile best practices, multi-stage builds, compose patterns | Container or local dev setup |
| [verification-loop.md](.ai/skills/verification-loop.md) | Quality verification checklist, pre-commit gate, Definition of Done | Before opening any PR or marking task done |
| [seo-aeo.md](.ai/skills/seo-aeo.md) | SEO audits, answer engine optimization, schema, snippets, search intent, content pruning | SEO/AEO work, content audits, page rewrites, search visibility improvements |
| [product-discovery.md](.ai/skills/product-discovery.md) | Product discovery, MVP scope, user stories, acceptance criteria, requirement shaping | Turning vague ideas or client briefs into buildable scope |
| [landing-page-conversion.md](.ai/skills/landing-page-conversion.md) | Landing page conversion, offer clarity, CTA, trust proof, objections | Creating or improving pages meant to convert traffic |
| [analytics-tracking.md](.ai/skills/analytics-tracking.md) | Event tracking, funnel design, GA4/Plausible/PostHog planning, privacy-safe analytics | Measuring product usage, conversion, activation, and retention |
| [observability.md](.ai/skills/observability.md) | Logs, metrics, tracing, health checks, alerts, production diagnostics | Production readiness, monitoring, incident response, reliability work |
| [launch-checklist.md](.ai/skills/launch-checklist.md) | Launch readiness gates for product, tech, SEO, analytics, security, operations | Before go-live, production deploys, client handoff, or marketing launches |
| [client-delivery.md](.ai/skills/client-delivery.md) | Client intake, scope, revisions, handover, maintenance, acceptance | Freelance/agency delivery for landing pages, SaaS, AI web projects |
| [saas-patterns.md](.ai/skills/saas-patterns.md) | SaaS account models, tenant boundaries, roles, onboarding, plan gates, dashboards | Building SaaS products, dashboards, subscriptions, multi-user apps |
| [ai-feature-design.md](.ai/skills/ai-feature-design.md) | AI feature fit, interaction patterns, guardrails, cost, latency, evals | Designing AI web features, assistants, generators, RAG, AI SaaS |
| [prompt-engineering.md](.ai/skills/prompt-engineering.md) | Prompts, system instructions, output schemas, examples, eval cases | Building, debugging, or upgrading prompts for AI features |
| [payment-billing.md](.ai/skills/payment-billing.md) | Checkout, subscriptions, invoices, webhooks, idempotency, refunds, entitlements | Payment gateway or billing work for SaaS, ecommerce, paid features |
| [codebase-onboarding.md](.ai/skills/codebase-onboarding.md) | How to explore an unknown codebase systematically | First session in any new repo |
| [production-debugging.md](.ai/skills/production-debugging.md) | Production debugging discipline, error taxonomy, env vars, cross-platform hazards (Windows→Linux), process manager (PM2/systemd/PHP-FPM), async errors, deploy hygiene | Production down, deploy failure, env/config issues |

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
