# ARCHITECTURE.md — Project Technical Discovery
# ═══════════════════════════════════════════════════════════════════════════════
# AGENT INSTRUCTIONS:
# This file is populated by the agent during Session Bootstrap (Pillar 1 in .clinerules).
# Run the discovery commands in .clinerules before filling any section here.
# Tech Lead manually fills Section 5 (ADRs). Agents do NOT modify that section.
# ═══════════════════════════════════════════════════════════════════════════════

---

## HOW TO POPULATE THIS FILE

Run the following during session bootstrap, then fill sections 1–4 below:

```bash
# Identify stack
cat package.json 2>/dev/null || cat composer.json 2>/dev/null \
  || cat go.mod 2>/dev/null || cat Cargo.toml 2>/dev/null \
  || cat pyproject.toml 2>/dev/null || cat pom.xml 2>/dev/null

# Map directory structure (2 levels, excluding clutter)
find . -maxdepth 2 -type d \
  ! -path './.git*' ! -path './node_modules*' \
  ! -path './vendor*' ! -path './.cache*' | sort

# Detect test configuration
find . -maxdepth 3 \( -name "jest.config*" -o -name "vitest.config*" \
  -o -name "phpunit.xml" -o -name "pest.php" \
  -o -name "playwright.config*" -o -name "pytest.ini" \) 2>/dev/null

# Detect container / CI
ls docker-compose* Dockerfile* 2>/dev/null
ls .github/workflows/ 2>/dev/null

# Check environment template
cat .env.example 2>/dev/null | head -30
```

---

## SECTION 1 — DISCOVERED STACK

> **Agent: fill this table during bootstrap. Delete rows that do not apply.**
> Last updated by: [agent | Tech Lead] on [YYYY-MM-DD]

| Layer           | Technology | Version | Notes |
|-----------------|-----------|---------|-------|
| Primary language |           |         |       |
| Framework        |           |         |       |
| Database         |           |         |       |
| Cache            |           |         |       |
| Queue            |           |         |       |
| Auth             |           |         |       |
| Frontend         |           |         |       |
| Build / bundler  |           |         |       |
| Test runner      |           |         |       |
| Container        |           |         |       |
| CI/CD            |           |         |       |

**Package manager:** [ ] npm  [ ] pnpm  [ ] yarn  [ ] bun  [ ] composer  [ ] pip  [ ] cargo  [ ] other: ___

**Monorepo:** [ ] Yes — tool: ___   [ ] No

---

## SECTION 2 — DIRECTORY MAP

> **Agent: paste output of `find . -maxdepth 3 -type d | sort | head -60` here.**

```
[Paste directory tree here during bootstrap]
```

**Key directories (summarise after discovery):**

| Directory | Purpose |
|-----------|---------|
| (fill in) | (fill in) |

---

## SECTION 3 — ENTRY POINTS & RUN COMMANDS

> **Agent: discover from manifest scripts, README, or Makefile.**

| Mode | Command | Notes |
|------|---------|-------|
| Dev  |         |       |
| Test |         |       |
| Build|         |       |
| Lint |         |       |
| Migration |    |       |

---

## SECTION 4 — DATA FLOW

> **Agent: describe data flow based on discovered module structure.**
> Update when new services or integrations are added.

```
[Client / Frontend]
      ↓  HTTP / WebSocket
[API / Route Layer]   (discovered path: ___)
      ↓
[Business Logic]      (discovered path: ___)
      ↓
[Data Access Layer]   (discovered path: ___)
      ↓
[Database / External Services]
```

**External integrations discovered:**

| Service | Purpose | Credentials location |
|---------|---------|---------------------|
| (none discovered yet) | | |

---

## SECTION 5 — ARCHITECTURE DECISION RECORDS

> **Tech Lead fills this. Agents do NOT modify this section.**
> Format template: load `.ai/skills/architecture-decision-records.md`

| ADR # | Title | Date | Status |
|-------|-------|------|--------|
| ADR-001 | _(initial stack decision — fill in)_ | YYYY-MM-DD | ACCEPTED |

---

## SECTION 6 — KNOWN CONSTRAINTS

> Populated by agent + Tech Lead during development. Never remove rows.

| Constraint | Value | Source |
|------------|-------|--------|
| LLM context window | 128,000 tokens | DeepSeek (executor) |
| Max file size | 500 lines | .clinerules |
| Test coverage minimum | 80% | .clinerules |
| Circuit breaker limit | 3 attempts | .clinerules |
| Max files per response | 2 | .clinerules Pillar 4 |

---

*Populated by agent during bootstrap. Architecture decisions require Tech Lead sign-off.*
*Last populated: [YYYY-MM-DD] by [agent session / Tech Lead]*
