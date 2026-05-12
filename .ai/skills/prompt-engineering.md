# Prompt Engineering Skill

Use this skill to design prompts, system instructions, output schemas, examples, evaluation cases, and prompt upgrade plans for AI features.

## Core Principle

A prompt is a product contract. It must define role, task, context, constraints, output shape, refusal behavior, and quality checks.

## Load Triggers

Load this skill when the task mentions:

- prompt, system prompt, instruction, output schema
- AI assistant behavior, chatbot behavior, agent behavior
- structured output, JSON schema, eval, examples
- hallucination, refusal, prompt upgrade, prompt debugging

## Prompt Structure

Use this layout:

```md
Role:
Goal:
Context:
Inputs:
Constraints:
Process:
Output format:
Refusal behavior:
Quality checks:
```

## Output Schema

For app integration, prefer structured output:

```json
{
  "status": "success | needs_clarification | blocked",
  "summary": "",
  "items": [],
  "risks": [],
  "next_action": ""
}
```

Rules:

- Use JSON only when code needs to parse it.
- Keep schema stable.
- Put dynamic content in fields, not keys.
- Define what to do when data is missing.

## Prompt Debugging

Diagnose:

```md
Observed failure:
Likely cause:
Missing instruction:
Conflicting instruction:
Missing context:
Bad output constraint:
Fix:
Eval case:
```

## Examples

Use examples when:

- output style matters
- edge cases are common
- schema is strict
- user intent is ambiguous

Avoid examples when they cause overfitting or make the prompt too long.

## Eval Set

Every production prompt should have:

- happy path
- ambiguous request
- missing data
- malicious or policy-violating input
- long noisy input
- domain-specific edge case

## Brutal Rules

- If code consumes the output, require schema.
- If failure is expensive, add evals before shipping.
- If prompt says "be accurate" but provides no source, expect hallucination.
- If prompt has conflicting priorities, simplify it.
- If the model must not guess, explicitly say what to do when information is missing.

## Output Format

```md
Prompt:
Output Schema:
Examples:
Refusal / Missing Data Behavior:
Eval Cases:
Known Risks:
Upgrade Notes:
```
