# Analytics Tracking Skill

Use this skill to design event tracking, conversion measurement, funnel diagnostics, and analytics implementation plans.

## Core Principle

If it matters, instrument it. If it is not measured, the team will argue from opinions.

## Load Triggers

Load this skill when the task mentions:

- analytics, GA4, Plausible, PostHog, event tracking
- conversion, funnel, attribution, UTM, dashboard
- page view, click tracking, form tracking, checkout tracking
- measure feature usage or product behavior

## Tracking Plan Workflow

### 1. Business Questions

Start with questions, not events:

```md
Business question:
Decision this data supports:
Primary conversion:
Secondary conversions:
Activation signal:
Retention signal:
```

### 2. Event Taxonomy

Use consistent names:

```md
event_name: object_action
examples:
- signup_started
- signup_completed
- pricing_viewed
- checkout_started
- checkout_completed
- search_performed
```

Rules:

- Use past tense for completed actions.
- Do not encode dynamic values in event names.
- Put dynamic values in properties.

### 3. Event Spec

```md
Event:
Trigger:
User intent:
Properties:
Required properties:
Optional properties:
PII risk:
Destination:
Validation method:
```

### 4. Funnel Design

```md
Funnel:
1. Landing page viewed
2. CTA clicked
3. Form started
4. Form submitted
5. Conversion completed

Drop-off questions:
Expected conversion:
Alert threshold:
```

### 5. Privacy & Data Quality

Check:

- no passwords, tokens, secrets, or raw personal messages
- no unnecessary PII
- consent requirements
- bot/internal traffic filtering
- consistent user/session identifiers
- event deduplication

## Output Format

```md
Tracking Strategy:
North Star Metric:
Conversion Events:
Activation Events:
Retention Events:
Event Table:
Funnel:
Properties:
Privacy Notes:
Implementation Checklist:
```
