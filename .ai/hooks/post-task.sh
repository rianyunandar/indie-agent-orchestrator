#!/usr/bin/env bash
# .ai/hooks/post-task.sh
# Run after agent completes a task. Logs completion and checks coverage gate.
# Usage: bash .ai/hooks/post-task.sh "Task description"
set -euo pipefail

TASK="${1:-[no description provided]}"
DATE=$(date '+%Y-%m-%d %H:%M')

echo "╔══════════════════════════════════════╗"
echo "║   POST-TASK VERIFICATION             ║"
echo "╚══════════════════════════════════════╝"
echo ""
echo "Task: $TASK"
echo "Time: $DATE"
echo ""

# ── Coverage check (Node.js) ──────────────────────────────────────────────────
if [ -f coverage/coverage-summary.json ] 2>/dev/null; then
  echo "▶ Coverage Check (Node.js)"
  COVERAGE=$(cat coverage/coverage-summary.json | grep -o '"pct":[0-9.]*' | head -1 | grep -o '[0-9.]*')
  if (( $(echo "$COVERAGE >= 80" | bc -l) )); then
    echo "  ✓ Coverage: $COVERAGE% (≥ 80% required)"
  else
    echo "  ✗ Coverage: $COVERAGE% — below 80% minimum"
    echo "  Add more tests before marking task done."
  fi
  echo ""
fi

# ── Coverage check (PHP) ──────────────────────────────────────────────────────
if [ -d coverage-html ] || [ -f coverage.xml ] 2>/dev/null; then
  echo "▶ Coverage Check (PHP)"
  echo "  Run: vendor/bin/pest --coverage --min=80 to verify"
  echo ""
fi

# ── Append to MEMORY.md ───────────────────────────────────────────────────────
echo "▶ Logging to .ai/MEMORY.md"
if [ -f .ai/MEMORY.md ]; then
  echo "" >> .ai/MEMORY.md
  echo "[$DATE] [DONE]  $TASK" >> .ai/MEMORY.md
  echo "  ✓ Appended to MEMORY.md"

  # Rolling window check
  LINE_COUNT=$(wc -l < .ai/MEMORY.md)
  if [ "$LINE_COUNT" -gt 200 ]; then
    echo ""
    echo "  ⚠ MEMORY.md has $LINE_COUNT lines (max 200)."
    echo "  Apply rolling window compression (see RULES.md Rule 10)."
  fi
else
  echo "  ⚠ .ai/MEMORY.md not found — skipping log"
fi

echo ""
echo "╔══════════════════════════════════════╗"
echo "║  POST-TASK COMPLETE                  ║"
echo "║  Next: verification-loop.md ✓        ║"
echo "╚══════════════════════════════════════╝"
