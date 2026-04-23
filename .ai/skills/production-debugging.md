---
name: production-debugging
description: Production debugging discipline, error taxonomy, env var loading, cross-platform hazards (Windows→Linux), process manager basics, async error handling, and deploy script hygiene.
origin: custom
---

# Production Debugging & Deploy Workflow

Panduan tindakan saat production down atau deploy bermasalah. Prioritas: aksi cepat, bukan teori.

## When to Activate

- Production down atau ada error di live server
- Deploy gagal atau terjadi regresi setelah deploy
- Environment variable tidak terbaca dengan benar di server
- Cross-platform issue (dev Windows, server Linux)
- Crash loop / proses restart terus-menerus
- Debugging async error yang susah direproduksi

---

## Debugging Discipline — 5 Rules

1. **Logs before guesses.** Minta output konkret (`logs`, `status`, `ps`, query error) SEBELUM hypothesizing.
2. **Numbered copy-paste steps**, bukan paragraf naratif. Satu step = satu blok command siap tempel.
3. **State expected output** di setiap step — user harus bisa tahu sukses/gagal tanpa bertanya lagi.
4. **One step fails = STOP.** Paste output, diagnose, baru lanjut. Jangan cascade asumsi.
5. **Theory goes last.** "Why this works" setelah masalah beres, bukan di awal.

### Anti-Patterns (Hindari)

- "Mungkin ini, coba aja" tanpa cara verify
- Solusi abstrak ("cek config DB") tanpa command konkret
- Minta user mengulang langkah yang sudah gagal tanpa diagnose kenapa
- Destructive action sebagai shortcut (`rm -rf`, `reset --hard`, `DROP TABLE`) tanpa konfirmasi eksplisit user

---

## Generic Error Taxonomy

Kategorikan error ke salah satu ini sebelum suggest solusi:

| Kategori | Ciri | Strategi |
|---|---|---|
| **Config/env missing** | Missing var, auth fail, connection refused, fallback ke default | Verify env file exists + loaded; verify runtime picks it up (cache env bisa stale) |
| **Stale deployment** | File/asset/action yang sudah tidak ada di kode baru | Verify git HEAD di server match lokal, rebuild cache, restart proses dengan env fresh |
| **Infrastructure down** | Connection refused, service not found, socket missing | Check service status, check listener, check network reachability |
| **Unhandled async error** | Crash loop, restart count naik terus | Cari EventEmitter tanpa error handler, promise tanpa catch, stream tanpa `error` listener |
| **Race / cache** | Kadang jalan kadang tidak, beda hasil di env berbeda | Reproduce dulu, invalidate cache, test with fresh process |
| **Cross-platform** | File kelihatan benar tapi runtime aneh (truncate, wrong delimiter, permission) | Check line endings, encoding, permissions, path case sensitivity |
| **Bot/scanner noise** | Path/action aneh, pattern random di log | Abaikan — bukan bug real, filter dari log analysis |

---

## Environment Variable Loading

### Golden Rules

- `.env` **tidak pernah di-commit** (masuk `.gitignore`). Template-nya `.env.example` boleh committed.
- Saat app di-restart, pastikan proses manager (PM2, systemd, docker-compose) **reload env** — banyak yang cache env dari saat pertama start.
- Verify di runtime bahwa var benar-benar ter-load:
  - Node.js: `console.log(process.env.DB_URL)`
  - Python: `print(os.getenv("DB_URL"))`
  - Jangan asumsi.
- Kalau env file dibuat via editor Windows, selalu convert ke LF sebelum naik ke server.

### Safe Pattern — Buat Config File di Server

Pakai heredoc via SSH (bash native LF), **bukan upload dari Windows**:

```bash
cat > .env <<'EOF'
DB_URL=postgres://user:pass@host:5432/db
SECRET=your_secret_here
EOF
chmod 600 .env
```

### Verify Env Loaded di Runtime

```bash
# Node.js — cek sebelum startup
node -e "require('dotenv').config(); console.log(process.env.DB_URL)"

# Python
python -c "import os; from dotenv import load_dotenv; load_dotenv(); print(os.getenv('DB_URL'))"

# PM2 — lihat env yang sedang aktif
pm2 env <app-name>
```

---

## Cross-Platform Hazards (Windows Dev → Linux Server)

| Hazard | Detect | Fix |
|---|---|---|
| CRLF line ending | `cat -A file` → muncul `^M` | `sed -i 's/\r$//' file` atau VS Code toggle CRLF→LF di status bar |
| Path separator | Script pakai `\` di Linux | Pakai `/` selalu, atau `path.join()` / `os.path.join()` |
| Case sensitivity | `import "./Foo"` work di Windows, fail di Linux karena file aslinya `foo.ts` | Konsisten lowercase, atau aktifkan `forceConsistentCasingInFileNames` di tsconfig |
| File permissions | Script tidak executable setelah clone | `chmod +x deploy.sh` atau `git update-index --chmod=+x` sebelum commit |
| Hidden BOM | File UTF-8 BOM bikin parser error di Linux | Save "UTF-8" (tanpa BOM) di editor |

### Quick Line Ending Check

```bash
# Detect
cat -A .env | head -5          # ^M = CRLF → problem
file .env                       # "CRLF line terminators" = problem

# Fix satu file
sed -i 's/\r$//' .env

# Fix semua file di folder
find . -type f -name "*.sh" -exec sed -i 's/\r$//' {} +
find . -type f -name ".env*" -exec sed -i 's/\r$//' {} +
```

---

## Process Manager Basics (PM2, systemd, supervisor, docker)

Prinsip umum apapun managernya:

| Concern | Apa yang perlu dicek |
|---|---|
| **Env refresh** | Restart biasa kadang pakai env lama. Cari opsi "reload env" / `--update-env` / full stop+start |
| **Log location** | Selalu tau di mana log file-nya — `tail -f` itu wajib tau |
| **Crash loop** | Kalau restart count naik cepat: stop proses, run manual di foreground untuk lihat error beneran |
| **UI vs CLI** | Dashboard/panel UI sering stale. CLI = source of truth |

### PM2 Commands

```bash
# Source of truth — jangan percaya UI panel
pm2 list
pm2 logs <app-name> --lines 100
pm2 env <app-name>

# Restart dengan env fresh (bukan reload biasa)
pm2 stop <app-name>
pm2 delete <app-name>
pm2 start ecosystem.config.js    # atau command start yang sesuai

# Run manual di foreground untuk debug crash loop
pm2 stop <app-name>
node app.js    # jalankan manual, lihat error langsung
```

### systemd Commands

```bash
systemctl status myapp.service
journalctl -u myapp.service -n 100 --no-pager
systemctl stop myapp.service
systemctl daemon-reload            # setelah edit .service file
systemctl start myapp.service
```

### docker-compose Commands

```bash
docker-compose ps
docker-compose logs --tail=100 app
docker-compose down && docker-compose up -d    # full stop+start dengan env fresh
```

---

## Async Error Handling (Node.js)

Prinsip berlaku mirip untuk Python/Go.

```javascript
// Connection pool HARUS punya error handler
// Tanpa ini: idle error = process crash
pool.on('error', (err) => {
  console.error('pool error:', err);
});

// EventEmitter 'error' event tanpa handler = throw uncaught
emitter.on('error', (err) => {
  console.error('emitter error:', err);
});

// Unhandled promise rejection catcher
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
# PM2 — lihat restart count
pm2 list    # kolom "↺" = restart count

# Kalau restart count tinggi:
pm2 stop <app-name>
node app.js    # run manual, baca error pertama yang keluar
```

---

## Deploy Script Hygiene

```bash
#!/bin/bash
set -e            # exit on any error
set -o pipefail   # fail if any part of a pipe fails

LOG_FILE="deploy.log"

# Log ke file + stdout
log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"; }

log "=== Deploy started ==="

# Skip heavy steps kalau tidak perlu
CURRENT_SHA=$(git rev-parse HEAD)
REMOTE_SHA=$(git ls-remote origin HEAD | cut -f1)

if [ "$CURRENT_SHA" = "$REMOTE_SHA" ]; then
  log "Already up to date. Skipping pull."
else
  git pull origin main
  log "Pulled latest: $REMOTE_SHA"
fi

# Run migrations SEBELUM restart app
log "Running migrations..."
# <your migration command here>

# Restart app dengan env fresh
log "Restarting app..."
pm2 stop app && pm2 delete app
pm2 start ecosystem.config.js

log "=== Deploy done ==="
```

### Deploy Checklist

- [ ] `set -e` dan `set -o pipefail` di awal
- [ ] Log ke file + stdout (`tee -a deploy.log`)
- [ ] Idempotent: re-run dengan state sama harus safe
- [ ] Skip heavy steps kalau git diff tidak ada perubahan
- [ ] Backup / warning sebelum destructive action
- [ ] Migrations jalan **sebelum** restart app

---

## Database Migrations (Language-Agnostic)

- Versioned SQL files di `migrations/` dengan prefix urut: `001_`, `002_`, dst.
- Track applied migrations di tabel metadata (`schema_migrations` atau sejenisnya).
- Idempotent when possible: `CREATE TABLE IF NOT EXISTS`, `ADD COLUMN IF NOT EXISTS`.
- Transactional per file: wrap `BEGIN` / `COMMIT` supaya partial failure tidak corrupt schema.
- Auto-run di deploy: hook di deploy script **sebelum** restart app. Jangan lazy-init di request handler (race condition + first-request delay).
- **Never edit applied migration** — buat migration baru untuk fix.

---

## What NOT to Reflexively Suggest

- Reinstall everything saat debug 1 bug — overkill + masking root cause
- Bypass safety flags (`--no-verify`, `-f`, `--allow-unauthenticated`) kecuali user eksplisit minta
- Add dependency untuk masalah yang bisa solved dengan ~10 baris kode
- Refactor sekalian saat user minta fix bug — do one thing
- Create docs/summary file kecuali diminta — kerja dari konteks percakapan
