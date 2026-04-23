---
name: production-debugging
description: Production debugging discipline, error taxonomy, env var loading, cross-platform hazards (Windows→Linux), process manager basics, async error handling, and deploy script hygiene.
origin: custom
---

# Production Debugging & Deploy Workflow

Action guide for when production is down or a deploy has gone wrong. Priority: concrete action, not theory.

## When to Activate

- Production down or error on the live server
- Deploy failed or regression introduced after deploy
- Environment variable not loading correctly on the server
- Cross-platform issue (dev Windows, server Linux)
- Crash loop / process keeps restarting
- Debugging an async error that is hard to reproduce

---

## Debugging Discipline — 5 Rules

1. **Logs before guesses.** Ask for concrete output (`logs`, `status`, `ps`, query error) BEFORE hypothesizing.
2. **Numbered copy-paste steps**, not narrative paragraphs. One step = one ready-to-paste command block.
3. **State the expected output** at every step — the person debugging must be able to tell success/failure without asking again.
4. **One step fails = STOP.** Paste the output, diagnose, then continue. Do not cascade assumptions.
5. **Theory goes last.** "Why this works" after the problem is resolved, not at the start.

### Anti-Patterns (Avoid)

- "Maybe try this" without a way to verify
- Abstract solutions ("check your DB config") without concrete commands
- Asking the user to repeat a step that already failed without diagnosing why
- Destructive actions as shortcuts (`rm -rf`, `reset --hard`, `DROP TABLE`) without explicit user confirmation

---

## Generic Error Taxonomy

Classify the error into one of these categories before suggesting a solution:

| Category | Symptoms | Strategy |
|---|---|---|
| **Config/env missing** | Missing var, auth fail, connection refused, fallback to default | Verify env file exists and is loaded; verify runtime picks it up (env can be stale after restart) |
| **Stale deployment** | File/asset/action that no longer exists in the new code | Verify git HEAD on server matches local, rebuild cache, restart process with fresh env |
| **Infrastructure down** | Connection refused, service not found, socket missing | Check service status, check listener, check network reachability |
| **Unhandled async error** | Crash loop, restart count keeps climbing | Look for EventEmitter without error handler, promise without catch, stream without `error` listener |
| **Race / cache** | Works sometimes, different results in different environments | Reproduce first, invalidate cache, test with a fresh process |
| **Cross-platform** | File looks correct but runtime behaves oddly (truncated, wrong delimiter, permission error) | Check line endings, encoding, permissions, path case sensitivity |
| **Bot/scanner noise** | Odd paths/actions, random patterns in logs | Ignore — not a real bug, filter from log analysis |

---

## Environment Variable Loading

### Golden Rules

- `.env` is **never committed** (add to `.gitignore`). The template `.env.example` may be committed.
- When the app is restarted, make sure the process manager (PM2, systemd, docker-compose) **reloads env** — many cache env from the time of first start.
- Verify at runtime that variables are actually loaded:
  - Node.js: `console.log(process.env.DB_URL)`
  - PHP: `echo getenv('DB_URL');` or `$_ENV['DB_URL']`
  - Python: `print(os.getenv("DB_URL"))`
  - Do not assume.
- If the env file was created with a Windows editor, always convert to LF before pushing to the server.

### Safe Pattern — Create Config File on Server

Use heredoc via SSH (bash native LF), **not uploading from Windows**:

```bash
cat > .env <<'EOF'
DB_URL=postgres://user:pass@host:5432/db
SECRET=your_secret_here
EOF
chmod 600 .env
```

### Verify Env Loaded at Runtime

```bash
# Node.js — check before startup
node -e "require('dotenv').config(); console.log(process.env.DB_URL)"

# PHP — check from CLI
php -r "require 'vendor/autoload.php'; (new \Dotenv\Dotenv(__DIR__))->load(); echo getenv('DB_URL');"

# Python
python -c "import os; from dotenv import load_dotenv; load_dotenv(); print(os.getenv('DB_URL'))"

# PM2 — show currently active env
pm2 env <app-name>
```

---

## Cross-Platform Hazards (Windows Dev → Linux Server)

| Hazard | Detect | Fix |
|---|---|---|
| CRLF line ending | `cat -A file` → shows `^M` | `sed -i 's/\r$//' file` or toggle CRLF→LF in VS Code status bar |
| Path separator | Script uses `\` on Linux | Always use `/`, or `path.join()` / `os.path.join()` |
| Case sensitivity | `import "./Foo"` works on Windows, fails on Linux because the file is `foo.ts` | Use consistent lowercase, or enable `forceConsistentCasingInFileNames` in tsconfig |
| File permissions | Script not executable after clone | `chmod +x deploy.sh` or `git update-index --chmod=+x` before committing |
| Hidden BOM | UTF-8 BOM causes parser errors on Linux | Save as "UTF-8" (without BOM) in your editor |

### Quick Line Ending Check

```bash
# Detect
cat -A .env | head -5          # ^M = CRLF → problem
file .env                       # "CRLF line terminators" = problem

# Fix a single file
sed -i 's/\r$//' .env

# Fix all shell scripts in the project
find . -type f -name "*.sh" -exec sed -i 's/\r$//' {} +
find . -type f -name ".env*" -exec sed -i 's/\r$//' {} +
```

---

## Process Manager Basics (PM2, systemd, supervisor, docker)

Common principles regardless of manager:

| Concern | What to check |
|---|---|
| **Env refresh** | A normal restart often reuses the old env. Look for a "reload env" / `--update-env` option, or do a full stop + start. |
| **Log location** | Always know where the log file is — being able to `tail -f` it is mandatory. |
| **Crash loop** | If restart count keeps rising: stop the process, run manually in the foreground to see the real error. |
| **UI vs CLI** | Dashboard/panel UIs are often stale. CLI = source of truth. |

### PM2 Commands

```bash
# Source of truth — do not trust the UI panel
pm2 list
pm2 logs <app-name> --lines 100
pm2 env <app-name>

# Restart with fresh env (not a simple reload)
pm2 stop <app-name>
pm2 delete <app-name>
pm2 start ecosystem.config.js    # or the appropriate start command

# Run manually in the foreground to debug a crash loop
pm2 stop <app-name>
node app.js    # run manually, read the first error that appears
```

### systemd Commands

```bash
systemctl status myapp.service
journalctl -u myapp.service -n 100 --no-pager
systemctl stop myapp.service
systemctl daemon-reload            # required after editing the .service file
systemctl start myapp.service
```

### docker-compose Commands

```bash
docker-compose ps
docker-compose logs --tail=100 app
docker-compose down && docker-compose up -d    # full stop + start with fresh env
```

### PHP / Laravel (Apache or Nginx + PHP-FPM)

```bash
# Restart PHP-FPM to flush opcode cache
sudo systemctl restart php8.2-fpm   # adjust version as needed

# Clear Laravel caches after deploy
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear

# Rebuild caches for production
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Check Laravel logs
tail -n 100 storage/logs/laravel.log
```

---

## Async Error Handling (Node.js)

Similar principles apply for PHP (exceptions) and Go (deferred error returns).

```javascript
// Connection pool MUST have an error handler
// Without this: an idle error crashes the process
pool.on('error', (err) => {
  console.error('pool error:', err);
});

// EventEmitter 'error' event without a handler = uncaught throw
emitter.on('error', (err) => {
  console.error('emitter error:', err);
});

// Catch unhandled promise rejections
process.on('unhandledRejection', (reason, promise) => {
  console.error('Unhandled rejection at:', promise, 'reason:', reason);
});

// Graceful shutdown
process.on('SIGTERM', async () => {
  await cleanup();
  process.exit(0);
});
```

### Crash Loop Diagnosis

```bash
# PM2 — check restart count
pm2 list    # the "↺" column = restart count

# If restart count is high:
pm2 stop <app-name>
node app.js    # run manually, read the first error that appears

# PHP-FPM crash — check system log
journalctl -u php8.2-fpm -n 50 --no-pager
tail -n 50 /var/log/php8.2-fpm.log
```

---

## Deploy Script Hygiene

```bash
#!/bin/bash
set -e            # exit on any error
set -o pipefail   # fail if any part of a pipe fails

LOG_FILE="deploy.log"

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"; }

log "=== Deploy started ==="

# Skip pull if already up to date
CURRENT_SHA=$(git rev-parse HEAD)
REMOTE_SHA=$(git ls-remote origin HEAD | cut -f1)

if [ "$CURRENT_SHA" = "$REMOTE_SHA" ]; then
  log "Already up to date. Skipping pull."
else
  git pull origin main
  log "Pulled latest: $REMOTE_SHA"
fi

# Run migrations BEFORE restarting the app
log "Running migrations..."
# Node.js/Prisma:   npx prisma migrate deploy
# Laravel:          php artisan migrate --force
# Raw SQL:          mysql -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < migrations/latest.sql

# Restart app with fresh env
log "Restarting app..."
# Node.js/PM2:
pm2 stop app && pm2 delete app && pm2 start ecosystem.config.js
# Laravel/PHP-FPM:
# php artisan config:cache && sudo systemctl restart php8.2-fpm

log "=== Deploy done ==="
```

### Deploy Checklist

- [ ] `set -e` and `set -o pipefail` at the top
- [ ] Log to file + stdout (`tee -a deploy.log`)
- [ ] Idempotent: re-running with the same state must be safe
- [ ] Skip heavy steps when there are no relevant git changes
- [ ] Backup / warning before any destructive action
- [ ] Migrations run **before** restarting the app
- [ ] Opcode/config cache cleared after deploy (PHP)

---

## Database Migrations (Language-Agnostic)

- Versioned SQL files in `migrations/` with ordered prefix: `001_`, `002_`, etc.
- Track applied migrations in a metadata table (`schema_migrations` or equivalent).
- Idempotent when possible: `CREATE TABLE IF NOT EXISTS`, `ADD COLUMN IF NOT EXISTS`.
- Transactional per file: wrap with `BEGIN` / `COMMIT` so partial failures do not corrupt the schema.
- Auto-run in deploy: hook in the deploy script **before** restarting the app. Do not lazy-init in a request handler (race condition + first-request delay).
- **Never edit an applied migration** — create a new migration to fix.

---

## What NOT to Reflexively Suggest

- Reinstall everything when debugging a single bug — overkill and masks the root cause
- Bypass safety flags (`--no-verify`, `-f`, `--allow-unauthenticated`) unless the user explicitly requests it
- Add a dependency for a problem that can be solved with ~10 lines of code
- Refactor while the user asked for a bug fix — do one thing
- Create docs/summary files unless explicitly asked — work from conversation context
