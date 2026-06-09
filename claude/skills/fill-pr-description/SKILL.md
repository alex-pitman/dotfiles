---
name: fill-pr-description
description: Use when a PR has been opened and needs its description filled out, when asked to fill in or update a PR body, or when a PR template has placeholder sections that need populating
---

# Fill PR Description

## Overview

Populate the Description and JIRA ticket sections of a PR from the repository's pull request template, using the branch name and code changes as context.

## When to Use

- PR has just been opened and still has template placeholders
- User says "fill out the PR description" or "update the PR body"

## Process

### Step 1: Gather context

Run these in parallel:

- **PR template:** Read `.github/pull_request_template.md`
- **Current PR:** `gh pr list --head <current-branch> --json number,title,body,url`
- **Ticket key:** Extract from branch name (e.g. `PROJ-123` from branch `PROJ-123`) or ask the user

### Step 2: Fill in Description

Always write in the **past tense** (e.g. "Added ...", "Replaced ...", "Updated ...") since the work is already done.

Write bullet points covering:
- What columns/fields/behavior was added or changed
- Any constraints, defaults, or notable implementation decisions
- How existing code was updated to reflect the change (e.g. hardcoded values replaced with real data)

Keep bullets factual and specific. One bullet per distinct change.

### Step 3: Fill in JIRA ticket link

Format as a Markdown hyperlink displaying only the ticket key, using the base URL detected in Step 1:

```markdown
[PROJ-123](https://carecom.atlassian.net/browse/PROJ-123)
```

### Step 4: Present the description and ask for approval

Show the filled-in sections as they would appear in the PR, then ask for approval before proceeding:

```markdown
## Description

- Added X
- Updated Y to use Z

## Links to related JIRA ticket(s)

[PROJ-123](https://carecom.atlassian.net/browse/PROJ-123)
```

Does this look good? I'll update the PR once you confirm.

### Step 5: Update the PR

Preserve all other template sections unchanged (How To Test, Reviewer Checklist). Use a HEREDOC to avoid quoting issues:

```bash
gh pr edit <number> --body "$(cat <<'EOF'
## Description

- ...

## Links to related JIRA ticket(s)

[PROJECT-XXX](https://carecom.atlassian.net/browse/PROJECT-XXX)

<all remaining sections from the current PR body, preserved verbatim>
EOF
)"
```

## Rules
- Always ask for user approval before updating the PR
- Use a HEREDOC (`<<'EOF'`) for `--body` when updating the PR
- Use `[PROJECT-XXX](url)` hyperlink format over raw URLs when linking tickets
- Only update the description and provide the link, leave the other sections for the author to fill in
- Less is more, don't include bullets for trivial changes (logging additions, new constants, etc.)