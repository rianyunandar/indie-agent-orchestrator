# Product Discovery Skill

Use this skill to turn vague ideas into clear product scope, MVP boundaries, user stories, acceptance criteria, and execution-ready plans.

## Core Principle

Do not build from vibes. Convert the request into users, problems, constraints, decisions, and measurable outcomes before implementation.

## Load Triggers

Load this skill when the task mentions:

- product idea, MVP, scope, requirement, PRD, user story
- feature planning, roadmap, prioritization, discovery
- unclear request, stakeholder requirement, client brief
- "what should we build", "make it useful", "define the feature"

## Discovery Workflow

### 1. Problem Frame

```md
Problem:
Target users:
Current pain:
Desired outcome:
Business goal:
Success metric:
Non-goals:
```

If the problem cannot be stated in one sentence, stop and clarify.

### 2. User & Job Mapping

```md
Primary user:
Secondary users:
Job to be done:
Trigger moment:
Current workaround:
Decision criteria:
Failure mode:
```

### 3. MVP Boundary

Classify requirements:

- `Must`: required for the feature to be useful.
- `Should`: important, but can ship after MVP.
- `Could`: nice-to-have.
- `Won't`: explicitly out of scope.

Output:

```md
MVP:
Must:
Should:
Could:
Won't:
```

### 4. User Stories

Use this format:

```md
As a [user],
I want [capability],
so that [outcome].

Acceptance criteria:
- Given ...
- When ...
- Then ...
```

### 5. Risk & Decision Log

```md
Open questions:
Assumptions:
Risks:
Trade-offs:
Decisions made:
Needs approval:
```

## Brutal Scope Rules

- If the user is unclear, define the smallest useful version.
- If a feature has no user or outcome, cut it.
- If a requirement has no acceptance criteria, it is not ready.
- If the MVP needs more than one major workflow, split it.
- If the feature depends on external policy, pricing, legal, or payment behavior, call it out before coding.

## Output Format

```md
Product Brief:
MVP Scope:
User Stories:
Acceptance Criteria:
Out of Scope:
Risks:
Recommended First Phase:
```
