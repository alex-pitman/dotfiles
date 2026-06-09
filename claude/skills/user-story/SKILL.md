---
name: user-story
description: Use this skill whenever the user wants to create, write, draft, update, or modify a Jira user story or ticket. Trigger on phrases like "create a user story", "write a jira story", "update the acceptance criteria", "add technical details to PROJ-123", "draft a story for X feature", or any request to prepare or edit structured Jira ticket content. Use even if the user just describes a feature or bug without explicitly saying "user story" — if they want it to land in Jira, use this skill.
---

# User Story Skill

This skill helps you draft and submit well-structured Jira user stories. Your job is to turn a rough description into a polished ticket — title, summary, technical details, and Gherkin-formatted acceptance criteria — then create or update it in Jira using the available MCP tools.

## Workflow

### Step 1: Gather context

Ask the user (only for what you don't already have):
- **What does this story need to do?** (the core requirement — get as much detail as possible)
- **Project key** (e.g. `FPLT`, `CORE`) — required for creating new stories; not needed for updates if a ticket key is given
- **Ticket key** — required for updates (e.g. `FPLT-123`); skip for new stories
- **What needs to change** — for updates, clarify which sections need updating (Technical Details, Acceptance Criteria, or both)

If the user provides a ticket key for an update, fetch the current ticket content first so you're not writing over details they want to keep:
```
jira_get_issue(issue_key="PROJ-123")
```

Don't ask for content you can reasonably draft yourself — the whole point is for Claude to write it.

### Step 2: Draft the content

Write the full story content. The description must use this exact structure:

```
## Summary
A concise 1–3 sentence overview of what change needs to be made and why. Think of this as what a PM or stakeholder would read to understand the ticket at a glance — no implementation details.

## Technical Details
Implementation guidance for the developer. Include things like: which services, endpoints, database tables, or components are affected; any constraints or architectural decisions; relevant context about the existing code that shapes how this should be built. Be specific and practical.

## Acceptance Criteria
Gherkin-format scenarios that define when this story is done. Each scenario should test one specific behavior.

Example format:
Scenario: [scenario name]
  Given [initial context]
  When [action taken]
  Then [expected outcome]
```

**For the title:** Use the format `[verb] [object]` — e.g., "Add payment retry logic to checkout flow", "Update user profile endpoint to support avatar uploads". Keep it under 80 characters.

**Drafting tips:**
- The Summary must only state what the user has actually told you or what is directly evident from the code. Do not infer or embellish the business impact — if you don't know the "why," state the change without speculating.
- The Summary should be readable by a non-technical stakeholder
- Technical Details should be specific enough that a developer can start work without needing to ask questions
- Write at least 2–3 Gherkin scenarios covering the happy path and the most important edge cases
- For updates, preserve any existing content in sections you're not changing

### Step 3: Show the draft and get approval

Present the full draft to the user in a readable format before submitting anything to Jira. Ask: "Does this look right? Any changes before I submit?"

Make any revisions the user requests. Don't submit until they approve.

### Step 4: Submit to Jira

**Creating a new story:**
```
jira_create_issue(
  project_key="PROJ",
  summary="[title]",
  issue_type="Story",
  description="[full description with ## headers]"
)
```

**Updating an existing story:**
```
jira_update_issue(
  issue_key="PROJ-123",
  summary="[title if changed]",
  description="[full updated description]"
)
```

After submitting, share the ticket key and URL with the user.

## Notes

- If the user only wants to update one section (e.g., just the Acceptance Criteria), fetch the existing ticket, update only that section, and resubmit the full description with the other sections unchanged.
- If the project key isn't known and this is a new story, ask — don't guess.
- If the user seems to be describing something vague, ask a clarifying question or two before drafting. A little more context up front leads to much better tickets.
- Do not infer motivation when drafting the summary section.
