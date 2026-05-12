# Models List

List of AI models available to developers.

## OpenAI

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

## Anthropic

| Model | Status |
|---|---|
| `Claude Sonnet 4.6` | `ON` |
| `Claude Opus 4.7` | `OFF` |
| `Claude Sonnet 4.5` | `ON` |
| `Claude Haiku 4.5` | `ON` |

## Google

| Model | Status |
|---|---|
| `Gemini 3.1 Pro (Preview)` | `ON` |
| `Gemini 2.5 Pro` | `ON` |
| `Gemini 3 Flash (Preview)` | `ON` |

## xAI

| Model | Status |
|---|---|
| `Grok Code Fast 1` | `ON` |

## Other / Optional

| Model | Status |
|---|---|
| `Raptor mini (Preview)` | `OFF` |

## Legacy/OpenAI Variants (still available)

| Model | Status |
|---|---|
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
  main: `GPT-5.4` | alternative: `Claude Sonnet 4.6` | review: `GPT-5.3-Codex`
- `Scope breakdown`  
  main: `GPT-5.4` | alternative: `Gemini 3.1 Pro (Preview)` | review: `Claude Sonnet 4.6`
- `Task estimation`  
  main: `Claude Sonnet 4.6` | alternative: `GPT-5.4 mini` | review: `GPT-5.4`

### 2) Architecture & Design

- `System design`  
  main: `GPT-5.4` | alternative: `Claude Sonnet 4.6` | review: `GPT-5.3-Codex`
- `API contract design`  
  main: `GPT-5.3-Codex` | alternative: `GPT-5.2-Codex` | review: `GPT-5.4`
- `Database/schema planning`  
  main: `GPT-5.3-Codex` | alternative: `GPT-5.2` | review: `GPT-5.4`

### 3) Implementation

- `Feature coding`  
  main: `GPT-5.3-Codex` | alternative: `GPT-5.2-Codex` | review: `GPT-5.4`
- `Refactor`  
  main: `GPT-5.3-Codex` | alternative: `Grok Code Fast 1` | review: `Claude Sonnet 4.6`
- `Quick patch/hotfix`  
  main: `GPT-5.2` | alternative: `GPT-5.4 mini` | review: `GPT-5.3-Codex`

### 4) Testing & QA

- `Unit/integration test generation`  
  main: `GPT-5.3-Codex` | alternative: `GPT-5.2-Codex` | review: `GPT-5.4`
- `Bug triage`  
  main: `GPT-5.2` | alternative: `Claude Haiku 4.5` | review: `GPT-5.3-Codex`
- `Regression checklist`  
  main: `Claude Sonnet 4.6` | alternative: `GPT-5.4 mini` | review: `GPT-5.4`

### 5) Review & Security

- `Code review`  
  main: `GPT-5.3-Codex` | alternative: `GPT-5.4` | review: `Claude Sonnet 4.6`
- `Security review`  
  main: `GPT-5.4` | alternative: `Claude Sonnet 4.6` | review: `GPT-5.3-Codex`
- `Performance review`  
  main: `GPT-5.4` | alternative: `Gemini 2.5 Pro` | review: `GPT-5.3-Codex`

### 6) Documentation & Handover

- `Technical docs`  
  main: `Claude Sonnet 4.6` | alternative: `GPT-5.4 mini` | review: `GPT-5.4`
- `Release note/changelog`  
  main: `GPT-5.4 mini` | alternative: `Claude Haiku 4.5` | review: `Claude Sonnet 4.6`
- `Knowledge transfer summary`  
  main: `Claude Sonnet 4.6` | alternative: `GPT-5.4` | review: `GPT-5.3-Codex`

