# Launch Checklist Skill

Use this skill before launching a website, app, landing page, feature, integration, or production release.

## Core Principle

Launch is not "it works locally". Launch means users can find it, use it, trust it, and the team can recover when it breaks.

## Load Triggers

Load this skill when the task mentions:

- launch, go live, release, production, deploy
- pre-launch checklist, production readiness, final QA
- domain, SSL, analytics, sitemap, robots, backups
- marketing launch, landing page launch, client handoff

## Launch Gates

### 1. Product Gate

- [ ] User flow tested end to end
- [ ] Empty, loading, error, and success states exist
- [ ] Copy is final enough for launch
- [ ] CTA and conversion path are clear
- [ ] Support/contact path exists

### 2. Technical Gate

- [ ] Environment variables configured
- [ ] Build passes
- [ ] Tests pass
- [ ] Database migrations applied safely
- [ ] Background jobs/queues configured
- [ ] File storage configured
- [ ] Email/SMS/webhooks tested

### 3. SEO/AEO Gate

- [ ] Indexing intent confirmed
- [ ] robots.txt reviewed
- [ ] sitemap generated and submitted if needed
- [ ] canonical tags valid
- [ ] title/meta/H1 present
- [ ] Open Graph/Twitter preview present
- [ ] structured data valid if used

### 4. Analytics Gate

- [ ] Analytics installed
- [ ] Conversion events tested
- [ ] Internal traffic filter planned
- [ ] UTM handling checked
- [ ] Dashboard or report owner defined

### 5. Security Gate

- [ ] Secrets not committed
- [ ] Auth/permission checks verified
- [ ] Forms validate input
- [ ] Rate limits considered
- [ ] Security headers reviewed
- [ ] Dependency vulnerabilities checked

### 6. Operations Gate

- [ ] Error monitoring configured
- [ ] Health check available
- [ ] Logs available
- [ ] Backup configured
- [ ] Rollback path known
- [ ] Owner/on-call defined

## Launch Verdict

```md
Verdict: GO | GO WITH RISKS | NO-GO
Blocking issues:
Known risks:
Rollback plan:
Monitoring plan:
Owner:
Launch window:
Post-launch checks:
```

## Brutal Rules

- No rollback plan, no confident launch.
- No analytics, no learning.
- No error monitoring, no production confidence.
- No owner, no launch.
- If SEO matters and robots/canonical/sitemap are unknown, pause.
