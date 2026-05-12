# Models List

List of AI models available to developers.

## Model Aliases (Use These in Plans)

| Alias | Model | Status |
|---|---|---|
| `codex_main` | `GPT-5.3-Codex` | `ON` |
| `reasoning_main` | `GPT-5.4` | `ON` |
| `fast_budget` | `GPT-5.4 mini` | `ON` |
| `review_main` | `Claude Sonnet 4.6` | `ON` |
| `fallback_fast` | `GPT-5.2` | `ON` |

## Task Type Defaults

Use this table when a task does not already define a more specific phase model.

| Task Type | Main | Alternative | Review |
|---|---|---|---|
| `coding` | `codex_main` | `GPT-5.2-Codex` | `reasoning_main` |
| `architecture` | `reasoning_main` | `review_main` | `codex_main` |
| `docs` | `review_main` | `fast_budget` | `reasoning_main` |
| `quick_fix` | `fallback_fast` | `fast_budget` | `codex_main` |
| `cheap_task` | `fast_budget` | `Claude Haiku 4.5` | `review_main` |
| `review` | `codex_main` | `reasoning_main` | `review_main` |
| `security` | `reasoning_main` | `review_main` | `codex_main` |
| `handover` | `review_main` | `reasoning_main` | `codex_main` |

## Active Models (Recommended Daily Use)

### OpenAI

| Model | Status |
|---|---|
| `GPT-5.5` | `ON` |
| `GPT-5.4` | `ON` |
| `GPT-5.4 mini` | `ON` |
| `GPT-5.3-Codex` | `ON` |
| `GPT-5.2` | `ON` |
| `GPT-5.2-Codex` | `ON` |
| `GPT-5 mini` | `ON` |
| `GPT-4.1` | `ON` |
| `GPT-4o` | `ON` |
| `o1` | `ON` |
| `o1-mini` | `ON` |
| `o3-mini` | `ON` |

### Anthropic

| Model | Status |
|---|---|
| `Claude Sonnet 4.6` | `ON` |
| `Claude Sonnet 4.5` | `ON` |
| `Claude Haiku 4.5` | `ON` |

### Google

| Model | Status |
|---|---|
| `Gemini 3.1 Pro (Preview)` | `ON` |
| `Gemini 2.5 Pro` | `ON` |
| `Gemini 3 Flash (Preview)` | `ON` |

### xAI

| Model | Status |
|---|---|
| `Grok Code Fast 1` | `ON` |

## Inventory Models (Optional/Legacy)

| Model | Status |
|---|---|
| `Claude Opus 4.7` | `OFF` |
| `Raptor mini (Preview)` | `OFF` |
| `gpt-3.5-turbo` | `OFF` |
| `gpt-3.5-turbo-16k` | `OFF` |
| `gpt-4` | `OFF` |
| `gpt-4-turbo` | `OFF` |
| `gpt-4-vision-preview` | `OFF` |
| `gpt-4o-mini` | `ON` |
| `gpt-4o-realtime-preview` | `OFF` |
| `text-embedding-3-large` | `ON` |
| `text-embedding-3-small` | `ON` |
| `text-moderation-latest` | `ON` |
| `whisper-1` | `ON` |
| `tts-1` | `ON` |
| `tts-1-hd` | `OFF` |
| `dall-e-3` | `ON` |

## Phase & Subphase Model Guide

Use this guide to choose models for each work phase.

### 1) Discovery & Planning

- `Requirement parsing`  
  main: `reasoning_main` | alternative: `review_main` | review: `codex_main`
- `Scope breakdown`  
  main: `reasoning_main` | alternative: `Gemini 3.1 Pro (Preview)` | review: `review_main`
- `Task estimation`  
  main: `review_main` | alternative: `fast_budget` | review: `reasoning_main`

### 2) Architecture & Design

- `System design`  
  main: `reasoning_main` | alternative: `review_main` | review: `codex_main`
- `API contract design`  
  main: `codex_main` | alternative: `GPT-5.2-Codex` | review: `reasoning_main`
- `Database/schema planning`  
  main: `codex_main` | alternative: `fallback_fast` | review: `reasoning_main`

### 3) Implementation

- `Feature coding`  
  main: `codex_main` | alternative: `GPT-5.2-Codex` | review: `reasoning_main`
- `Refactor`  
  main: `codex_main` | alternative: `Grok Code Fast 1` | review: `review_main`
- `Quick patch/hotfix`  
  main: `fallback_fast` | alternative: `fast_budget` | review: `codex_main`

### 4) Testing & QA

- `Unit/integration test generation`  
  main: `codex_main` | alternative: `GPT-5.2-Codex` | review: `reasoning_main`
- `Bug triage`  
  main: `fallback_fast` | alternative: `Claude Haiku 4.5` | review: `codex_main`
- `Regression checklist`  
  main: `review_main` | alternative: `fast_budget` | review: `reasoning_main`

### 5) Review & Security

- `Code review`  
  main: `codex_main` | alternative: `reasoning_main` | review: `review_main`
- `Security review`  
  main: `reasoning_main` | alternative: `review_main` | review: `codex_main`
- `Performance review`  
  main: `reasoning_main` | alternative: `Gemini 2.5 Pro` | review: `codex_main`

### 6) Documentation & Handover

- `Technical docs`  
  main: `review_main` | alternative: `fast_budget` | review: `reasoning_main`
- `Release note/changelog`  
  main: `fast_budget` | alternative: `Claude Haiku 4.5` | review: `review_main`
- `Knowledge transfer summary`  
  main: `review_main` | alternative: `reasoning_main` | review: `codex_main`
