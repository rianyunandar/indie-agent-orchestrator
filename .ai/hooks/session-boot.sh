#!/usr/bin/env bash
# .ai/hooks/session-boot.sh
# Run at the start of every agent session.
# Discovers project stack and reports available skills.
# Usage: bash .ai/hooks/session-boot.sh
set -euo pipefail

echo "╔══════════════════════════════════════════╗"
echo "║  ENTERPRISE AGENTIC FRAMEWORK — BOOT     ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# ── 1. Discover manifest ──────────────────────────────────────────────────────
echo "▶ Stack Discovery"
if   [ -f package.json ];   then echo "  → Node.js project"; cat package.json | grep -E '"name"|"version"|"scripts"' | head -6
elif [ -f composer.json ];  then echo "  → PHP/Composer project"; cat composer.json | grep -E '"name"|"require"' | head -6
elif [ -f go.mod ];         then echo "  → Go project"; head -3 go.mod
elif [ -f Cargo.toml ];     then echo "  → Rust project"; head -5 Cargo.toml
elif [ -f pyproject.toml ]; then echo "  → Python project"; head -6 pyproject.toml
elif [ -f pom.xml ];        then echo "  → Java/Maven project"; grep -m2 '<artifactId>\|<version>' pom.xml
else echo "  → No standard manifest found. Inspect manually."
fi
echo ""

# ── 2. Project structure (2 levels) ──────────────────────────────────────────
echo "▶ Directory Structure (depth 2)"
find . -maxdepth 2 -type d \
  ! -path './.git*' \
  ! -path './node_modules*' \
  ! -path './vendor*' \
  ! -path './.cache*' \
  | sort | head -40
echo ""

# ── 3. Read operational memory ────────────────────────────────────────────────
echo "▶ Operational Memory (.ai/MEMORY.md)"
if [ -f .ai/MEMORY.md ]; then
  cat .ai/MEMORY.md | head -30
  echo "  [truncated — read full file if needed]"
else
  echo "  No MEMORY.md found."
fi
echo ""

# ── 4. List available skills ──────────────────────────────────────────────────
echo "▶ Available Skills (.ai/skills/)"
if [ -d .ai/skills ]; then
  ls .ai/skills/ | sed 's/\.md$//' | while read s; do echo "  cat .ai/skills/$s.md"; done
else
  echo "  No .ai/skills/ directory found."
fi
echo ""

# ── 5. Environment check ──────────────────────────────────────────────────────
echo "▶ Environment"
echo "  .env.example: $([ -f .env.example ] && echo 'EXISTS' || echo 'MISSING')"
echo "  .env:         $([ -f .env ] && echo 'EXISTS' || echo 'missing (expected)')"
echo ""

echo "╔══════════════════════════════════════════╗"
echo "║  BOOT COMPLETE — update .ai/ARCHITECTURE  ║"
echo "║  then load relevant skills before working ║"
echo "╚══════════════════════════════════════════╝"
