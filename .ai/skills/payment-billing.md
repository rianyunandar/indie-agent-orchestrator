# Payment & Billing Skill

Use this skill for checkout, invoices, subscriptions, webhooks, payment state machines, refunds, plan changes, and billing reliability.

## Core Principle

Billing must be idempotent, auditable, and recoverable. Never trust the frontend as the source of payment truth.

## Load Triggers

Load this skill when the task mentions:

- payment, billing, checkout, invoice, subscription
- Stripe, Midtrans, Xendit, PayPal, payment gateway
- webhook, refund, trial, plan change, renewal
- pricing, entitlement, paid feature, invoice status

## Payment Flow

```md
Gateway:
Payment type: one-time | subscription | invoice | usage-based
Customer:
Order/Subscription:
Amount:
Currency:
Success URL:
Failure URL:
Webhook events:
Entitlement granted when:
```

Rule: grant access from verified backend/webhook state, not just success redirect.

## Subscription State Machine

Track states:

- `trialing`
- `active`
- `past_due`
- `paused`
- `canceled`
- `expired`
- `refunded`

Define:

```md
State:
Allowed actions:
Access level:
Email/notification:
Recovery path:
Audit event:
```

## Webhook Safety

Requirements:

- verify signature
- store event ID
- enforce idempotency
- process retries safely
- log raw event metadata safely
- never store secrets in logs

```md
Webhook event:
Idempotency key:
State transition:
Side effect:
Retry behavior:
Failure handling:
```

## Pricing & Entitlements

```md
Plan:
Features:
Limits:
Billing interval:
Upgrade behavior:
Downgrade behavior:
Cancellation behavior:
Refund behavior:
```

## Brutal Rules

- No webhook verification, no production launch.
- No idempotency, expect duplicate access or duplicate invoices.
- No state machine, billing bugs will become support nightmares.
- No audit log, disputes become guesswork.
- Frontend success page is not payment proof.

## Output Format

```md
Billing Design:
Gateway:
State Machine:
Webhook Events:
Entitlements:
Failure Cases:
Security Notes:
Test Matrix:
```
