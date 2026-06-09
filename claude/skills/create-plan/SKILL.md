---
name: create-plan
description: Use after a brainstorm or design decision to write a concrete implementation plan. Breaks a feature into ordered tasks — each specifying which files change, what test to write first, and the implementation approach — without writing any actual code. Trigger when the user says "write a plan", "create a plan", "plan this out", "let's plan", or naturally transitions from /brainstorm. Also trigger when a Jira ticket or feature description is handed over for planning.
---

# Create Plan

Turn a design decision into a concrete, ordered task list — specific enough to implement without guesswork, without writing the code itself.

## Checklist

Create a task for each step and complete them in order:

1. **Scope check** — one coherent feature, or multiple independent pieces?
2. **Discover codebase** — find affected files, existing patterns, relevant interfaces
3. **Write file map** — every file being created or modified and its responsibility
4. **Write tasks** — each with Writes, Test (RED), Implementation (GREEN)
5. **Map execution order** — dependencies and parallel groups
6. **Self-review** — coverage, consistency, no placeholders
7. **Approval gate** — save the plan file and ask the user to confirm

## Process

### 1. Scope Check

Check whether this covers one coherent feature or multiple independent subsystems. If multiple, name the pieces, explain how they relate, and ask which to plan first. Each plan should produce working, testable software on its own.

### 2. Codebase Discovery

Look before writing. Don't guess file paths or patterns:
- Find files that will be touched and understand their current interfaces
- Find existing patterns to follow (how similar things were done before)
- Check tests to understand what invariants are already locked in
- Note conventions: naming, package structure, auth patterns, logging keys

### 3. File Map

List every file being created or modified and what it's responsible for. This is where decomposition decisions get made — each file should have one clear responsibility.

```
**File Map**
- Create: `src/foo/Bar.java` — new Bar service handling X
- Modify: `src/foo/BazService.java` — inject Bar, call doThing() in processRequest()
- Create: `src/test/foo/BarTest.java` — unit tests for Bar
```

### 4. Tasks

Each task is one logical unit of change — a single behavior that can be committed independently. A skilled developer should finish a task in 5–15 minutes.

```markdown
### Task N: [Name]

[One sentence: what behavior this adds or changes.]

**Writes:**
- `path/to/File.java` — what changes here (one line)
- `path/to/FileTest.java` — what this tests

**Test (RED):** `ClassName#methodName` — [one line: what the test asserts]

**Implementation (GREEN):** [2–4 sentences describing the approach — no code]

**Pattern:** `ExistingClass` in `path/to/ExistingClass.java` *(optional)*
```

The **Writes** list must include every file the task touches — source, test, and any export/config files. This is what determines whether two tasks can run in parallel; a missing file causes false-positive parallelism and conflicts.

**Test (RED)** and **Implementation (GREEN)** describe what to write, not the code itself. The implementer writes the actual code; the plan gives them enough to know what it should do and how to approach it.

### 5. Execution Order

Map dependencies across tasks:
- Two tasks are independent if their **Writes** lists are fully disjoint AND neither imports the other's output
- Group independent tasks together — they can run in parallel
- Order groups by dependency

```markdown
## Execution Order

### Group A — parallel
- Task 1: [Name]
- Task 2: [Name]

### Group B — sequential (after A)
- Task 3: [Name] — imports types from Tasks 1 and 2
```

### 6. Self-Review

After writing the complete plan:

1. **Coverage** — does every requirement map to at least one task?
2. **Placeholders** — any vague language like "handle errors appropriately"? Make it concrete.
3. **Consistency** — do type names, method signatures, and file paths match across tasks?
4. **Writes completeness** — would any task's changes require touching a file not in its Writes list?

Fix issues inline.

### 7. Approval Gate

Determine the plan filename:
- If a Jira ticket is in context: `PROJ-123-plan.md` (e.g. `FPLT-456-plan.md`)
- Otherwise: `<topic>-plan.md` (e.g. `provider-search-plan.md`)

Save the plan, then ask:

> "Plan saved to `<filename>`. Take a look and let me know if anything needs adjusting before you start implementing."

Wait for confirmation before finishing.

## Principles

- **Specify, don't implement** — describe what each piece does and the approach; the implementer writes the code
- **Writes list is the contract** — accuracy matters more than brevity; a missing file causes problems downstream
- **TDD order** — test first, then implementation; make this order explicit in every task
- **One behavior per task** — if a task name has "and" in it, consider splitting it
- **Look before writing** — plans based on assumptions about the codebase are usually wrong
