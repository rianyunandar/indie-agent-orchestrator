# SEO + AEO Optimization Skill

Use this skill for SEO audits, answer engine optimization (AEO), content rewrites, page briefs, content pruning, schema recommendations, and search-intent mapping.

## Core Principle

Do not optimize weak content. Diagnose first, then decide whether to keep, improve, merge, delete, or noindex.

SEO makes the page discoverable. AEO makes the answer extractable, trustworthy, and easy for answer engines to cite.

## Load Triggers

Load this skill when the task mentions:

- SEO, AEO, answer engine optimization, AI Overview, AI Mode, GEO, search visibility
- title tags, meta descriptions, snippets, schema, structured data
- content brief, content cluster, topical authority, search intent
- page audit, content audit, content pruning, organic traffic, indexing

## Brutal Verdict First

For every page or content item, produce this verdict before giving fixes:

```md
Verdict: KEEP | IMPROVE | MERGE | DELETE | NOINDEX
Reason:
Search intent:
Missing intent:
Missing entity:
Missing proof:
Missing conversion:
Risk:
Fix priority: P0 | P1 | P2 | P3
```

Decision rules:

- `KEEP`: page already satisfies intent, has proof, and can be improved incrementally.
- `IMPROVE`: useful page, but missing structure, proof, entities, internal links, or answer blocks.
- `MERGE`: overlaps another page and splits authority.
- `DELETE`: thin, outdated, duplicated, or harmful.
- `NOINDEX`: useful for users but not useful as a search landing page.

## Workflow

### 1. Technical SEO Audit

Check:

- Crawlability: robots, blocked assets, server errors
- Indexability: noindex, canonical, duplicate pages, thin pages
- URL quality: descriptive, stable, clean hierarchy
- Metadata: unique title, meta description, H1
- Internal links: orphan pages, weak anchor text, broken links
- Sitemap: present, fresh, canonical URLs only
- Performance: Core Web Vitals, mobile usability, render-blocking issues
- Media: image alt text, compression, lazy loading, relevant placement

Output:

```md
Technical SEO:
- Crawlability:
- Indexability:
- Metadata:
- Internal links:
- Sitemap:
- Performance:
- Media:
- P0 fixes:
```

### 2. Search Intent Mapping

Classify the primary intent:

- `informational`
- `commercial`
- `transactional`
- `navigational`
- `local`
- `comparison`
- `troubleshooting`

Then define:

```md
Primary query:
Secondary queries:
Audience:
Awareness stage:
User wants:
User does not want:
Best page type:
SERP expectation:
Conversion path:
```

Rule: if intent is unclear, stop optimizing and rewrite the page brief first.

### 3. Entity & Topical Authority

Map the content as entities, not just keywords:

```md
Main entity:
Entity type:
Related entities:
Attributes:
Synonyms:
Questions:
Comparisons:
Missing supporting pages:
Internal links to add:
Internal links from:
```

Rule: if the topic is important but only has one thin page, propose a cluster.

### 4. AEO Answer Block

Every important page should include an answer block that can stand alone:

```md
Short Answer:
[40-70 words. Direct, specific, no fluff.]

Expanded Answer:
[Add nuance, conditions, examples, and caveats.]

Evidence:
[Data, source, product detail, first-hand experience, screenshot, pricing, benchmark, or example.]

Next Step:
[What the reader should do next.]
```

Rules:

- Put the direct answer near the top of the page.
- Use plain language and concrete nouns.
- Answer the actual question before adding context.
- Add proof immediately after important claims.
- Do not bury the answer inside a long introduction.

### 5. Snippet & Citation Optimization

Create:

```md
Title:
Meta description:
H1:
URL slug:
Featured snippet candidate:
FAQ questions:
Definition block:
Comparison table:
Best for:
Not for:
```

Rules:

- Title must be clear, unique, and accurate.
- Meta description must summarize the page, not stuff keywords.
- H1 must match the page promise.
- Use tables when users compare options.
- Use definitions when users ask "what is".
- Use steps when users ask "how to".

### 6. Structured Data Recommendation

Recommend schema only when visible content supports it.

Common choices:

- `Article`
- `FAQPage`
- `HowTo`
- `Product`
- `Review`
- `BreadcrumbList`
- `Organization`
- `LocalBusiness`
- `SoftwareApplication`

Output:

```md
Schema recommendation:
Eligible schema:
Do not use:
Required visible content:
JSON-LD fields:
Validation notes:
```

Rules:

- Structured data must match visible page content.
- Do not add fake FAQ, fake reviews, fake ratings, or fake author details.
- Do not promise rich results. Eligibility is not a guarantee.

### 7. Content Rewrite Brief

When rewriting, produce this:

```md
Page goal:
Primary intent:
Primary query:
Secondary queries:
Required entities:
Required proof:
Outline:
Opening answer:
Sections to remove:
Sections to add:
Internal links:
CTA:
Schema:
Success metric:
```

## Red Flags

Block or challenge the work when:

- The content exists only to chase keywords.
- The page has no clear audience or intent.
- The answer is vague, padded, or delayed.
- The page has no proof, examples, data, product details, or lived experience.
- The page duplicates another URL.
- The schema does not match visible content.
- The page asks for rankings but blocks indexing.
- The page targets a competitive query with thin content.

## Output Formats

### Fast Audit

```md
Verdict:
Top 5 Problems:
P0 Fixes:
P1 Fixes:
Model Answer Block:
Recommended Schema:
Internal Links:
```

### Full Audit

```md
Verdict:
Technical SEO:
Intent Mapping:
Entity Map:
AEO Answer Block:
Snippet Package:
Schema Recommendation:
Content Rewrite Brief:
Pruning Decision:
Execution Plan:
```

## Source Grounding

Use current official guidance when available:

- Google SEO Starter Guide
- Google AI features and your website
- Google Search structured data documentation
- Google structured data policies
- Bing Webmaster Guidelines when Bing visibility matters

Core constraints:

- AI search features still depend on SEO fundamentals.
- Pages must be crawlable, indexable, and eligible for snippets.
- No special AI markup is required for Google AI features.
- Structured data must match visible content.
- Helpful, reliable, people-first content beats keyword stuffing.
