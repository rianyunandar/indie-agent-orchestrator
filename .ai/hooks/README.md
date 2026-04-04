# hooks/README.md — Agentic Hooks Reference
# These hooks are designed to be triggered by Roo Code agents via terminal bash.
# They are shell-executable, not Claude Code-specific.
# ─────────────────────────────────────────────────────────────────────────────

## Available Hooks

| Script | Trigger | Purpose |
|--------|---------|---------|
| `pre-commit.sh` | Before every `git commit` | Lint, format, type-check, secret scan |
| `post-task.sh` | After agent completes a task | Update MEMORY.md, validate coverage |
| `session-boot.sh` | Start of every agent session | Stack discovery, skill listing |

## How Roo Code Agents Run These

Agents invoke hooks via terminal instruction in `.clinerules`:

```bash
bash .ai/hooks/pre-commit.sh
bash .ai/hooks/session-boot.sh
bash .ai/hooks/post-task.sh "Task description"
```

## Adding a New Hook

1. Create `.ai/hooks/<name>.sh`
2. Make it executable: `chmod +x .ai/hooks/<name>.sh`
3. Add a row to the table above
4. Reference the trigger condition in `.clinerules` Section 9 or relevant rule
