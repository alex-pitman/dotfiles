---
name: brainstorm
description: Use when you need to figure out how to approach a feature, change, or fix before writing any code or plan — explores the codebase deeply to understand context, asks focused clarifying questions, then presents 2-3 approaches with explicit pros and cons. Use this whenever the right implementation path isn't obvious, even if the idea feels simple. Do NOT write code or a plan until this skill completes.
---

# Brainstorm

Turn a rough idea into a clear direction through codebase-informed conversation.

No spec documents. No commits. Just alignment on the right approach.

## Checklist

Create a task for each step and complete them in order:

1. **Explore codebase** — find similar patterns, affected surfaces, tests, recent commits, dependencies
2. **Ask clarifying questions** — one at a time until you have enough to propose approaches
3. **Present 2-3 approaches** — with explicit pros, cons, and a recommendation
4. **Confirm alignment** — summarize the chosen approach, offer to hand off to plan

## Process

### 1. Deep Codebase Exploration

Before asking a single question, understand what exists. The goal is to arrive at questions and options that are grounded in reality, not hypotheticals.

Look for:
- **Similar patterns** — how has the codebase solved analogous problems? What conventions emerged?
- **Affected surfaces** — what existing code will this touch? Which interfaces, modules, services, or workflows?
- **Tests** — what behavior is already locked in? What do the tests reveal about intent and edge cases?
- **Recent history** — commits near the affected area reveal what's in motion or recently changed
- **Dependencies** — what does the relevant code depend on, and what depends on it?

Spend enough time here that you could explain the surrounding context to someone unfamiliar with the codebase. Don't ask questions the code already answers.

### 2. Clarifying Questions

Ask one question at a time. Prefer multiple-choice when the options are clear; open-ended when they aren't. Focus on:
- **Purpose**: what problem is this solving, and for whom?
- **Constraints**: what can't change? What must it work with?
- **Success criteria**: how will we know it's done and correct?
- **Scope**: what's in, what's out?

Stop asking once you have enough to propose approaches.

### 3. Present Approaches

Propose 2-3 distinct approaches. For each:
- A short name or label
- 2-3 sentence description
- Explicit **pros** grounded in this codebase and context
- Explicit **cons** grounded in this codebase and context
- The key tradeoff in one sentence

Lead with your recommended approach and explain why.

Present the approaches as a multiple-choice question using `AskUserQuestion` so the user can select one directly.

### 4. Confirm Alignment

Once the user chooses an approach, summarize what you'll build in 3-5 sentences so they can catch any misunderstanding before a plan is written.

Offer to transition to the plan skill.

## Principles

- **Explore before asking** — questions informed by the actual codebase are better than generic ones
- **One question at a time** — don't overwhelm with multiple questions
- **Options, not answers** — present tradeoffs, let the user decide
- **Stay in the chat** — no spec documents, no commits
- **KISS & YAGNI** — if the idea feels overbuilt, surface a simpler alternative as one of the options
