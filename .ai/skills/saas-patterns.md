# SaaS Patterns Skill

Use this skill for SaaS product architecture, onboarding, dashboard UX, tenant boundaries, roles, billing states, usage limits, and operational patterns.

## Core Principle

A SaaS product is not just CRUD. It needs onboarding, access control, billing boundaries, usage visibility, operational recovery, and retention loops.

## Load Triggers

Load this skill when the task mentions:

- SaaS, subscription, dashboard, tenant, workspace, organization
- role, permission, plan limit, feature gate, usage quota
- onboarding, activation, trial, billing, admin panel
- multi-user product, account settings, team management

## SaaS Architecture Checklist

### 1. Account Model

```md
User:
Account/Workspace:
Organization:
Tenant boundary:
Owner role:
Member roles:
Invitations:
```

Rule: define whether data belongs to a user, workspace, or organization before building tables.

### 2. Roles & Permissions

```md
Roles:
Permissions:
Admin-only actions:
Owner-only actions:
Audit events:
Dangerous actions:
```

Rules:

- Check permissions server-side.
- Do not rely on hidden UI for security.
- Log destructive admin actions.

### 3. Onboarding & Activation

```md
First-run goal:
Activation event:
Required setup:
Empty state:
Guided steps:
Time to value:
```

### 4. Plans & Feature Gates

```md
Plan:
Included features:
Limits:
Overage behavior:
Upgrade trigger:
Downgrade behavior:
Grace period:
```

### 5. Dashboard Patterns

Include:

- key metrics
- recent activity
- next action
- empty state
- error state
- upgrade prompt only when relevant

## Brutal Rules

- If the app has teams, define tenant boundaries early.
- If there is billing, design state transitions before UI.
- If there are limits, define enforcement server-side.
- If onboarding has no activation event, analytics will be weak.
- If destructive actions have no audit trail, admin support will hurt.

## Output Format

```md
SaaS Scope:
Account Model:
Tenant Boundary:
Roles & Permissions:
Onboarding Flow:
Plan Gates:
Dashboard UX:
Analytics Events:
Operational Risks:
```
