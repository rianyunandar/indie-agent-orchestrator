# Observability Skill

Use this skill to design logging, metrics, tracing, health checks, alerting, and production diagnostics.

## Core Principle

A system is not production-ready until failures are visible, explainable, and actionable.

## Load Triggers

Load this skill when the task mentions:

- logging, metrics, tracing, observability, monitoring
- uptime, health check, alerting, incident, production issue
- Sentry, OpenTelemetry, Prometheus, Grafana, Datadog, New Relic
- slow request, error rate, queue failure, cron failure

## Observability Layers

### 1. Logs

Required fields:

```md
timestamp:
level:
service:
environment:
request_id:
user_id_hash:
event:
message:
error_code:
duration_ms:
```

Rules:

- Log state transitions and failures.
- Do not log secrets, tokens, passwords, payment data, or raw sensitive payloads.
- Prefer structured logs over free text.

### 2. Metrics

Track:

- request rate
- error rate
- latency p50/p95/p99
- queue depth
- job failures
- DB query time
- external API failures
- cache hit ratio
- business conversion counters

### 3. Tracing

Use tracing for:

- slow multi-service requests
- background jobs
- payment or webhook flows
- external API calls
- database-heavy flows

### 4. Health Checks

```md
Liveness:
Readiness:
Database:
Cache:
Queue:
Storage:
External dependencies:
```

Rule: readiness must fail when the app cannot serve real traffic.

### 5. Alerting

Alert only when action is needed:

```md
Alert:
Condition:
Threshold:
Duration:
Severity:
Owner:
Runbook:
```

## Incident Output

```md
Symptom:
Blast radius:
First bad time:
Likely layer:
Evidence:
Immediate mitigation:
Root cause hypothesis:
Next diagnostic command:
Permanent fix:
```

## Brutal Rules

- If nobody owns the alert, do not create it.
- If an alert has no runbook, it is noise.
- If a log cannot help debug, remove or downgrade it.
- If a production flow has no correlation ID, add one.
- If a background job can fail silently, instrument it before calling it done.
