# AI Feature Design Skill

Use this skill to design AI-powered web features, decide whether AI is needed, choose interaction patterns, control cost, reduce hallucination risk, and define fallback behavior.

## Core Principle

Do not add AI because it sounds impressive. Add AI when uncertainty, language, reasoning, generation, extraction, or personalization creates real user value.

## Load Triggers

Load this skill when the task mentions:

- AI feature, chatbot, assistant, agent, copilot, generator
- model selection, prompt flow, streaming, RAG, embeddings
- hallucination, fallback, eval, AI cost, latency
- AI web app, AI SaaS, AI landing page tool

## AI Feature Fit

Before designing, answer:

```md
User problem:
Why AI is needed:
Could rules solve it:
Input:
Output:
Quality bar:
Failure cost:
Latency target:
Cost target:
```

Decision:

- `AI`: model is needed.
- `Rules`: deterministic logic is enough.
- `Hybrid`: rules first, model for ambiguous cases.

## Interaction Pattern

Choose one:

- `single-shot generation`
- `chat`
- `structured extraction`
- `classification`
- `recommendation`
- `rewrite`
- `agentic workflow`
- `RAG answer`

Define:

```md
Pattern:
User input:
System context:
Tools/data:
Output format:
Streaming needed:
Human review needed:
```

## Guardrails

```md
Allowed:
Disallowed:
Refusal behavior:
Required citations:
Confidence handling:
Fallback:
Escalation:
```

Rules:

- Use structured output for anything consumed by code.
- Use citations or source excerpts when answering from documents.
- Add human review for high-impact business, legal, medical, financial, or destructive actions.
- Do not let the model invent unavailable data.

## Cost & Latency

```md
Model:
Input size:
Output size:
Expected calls per user action:
Cacheable:
Streaming:
Fallback model:
Rate limit behavior:
```

## Evaluation

Create eval cases:

```md
Happy path:
Ambiguous input:
Missing data:
Malicious input:
Long input:
Wrong assumption:
Expected output:
Failure criteria:
```

## Output Format

```md
AI Feature Verdict:
Recommended Pattern:
Model Strategy:
Prompt/Data Flow:
Guardrails:
Fallback:
Cost/Latency Notes:
Eval Cases:
Implementation Plan:
```
