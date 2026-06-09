---
paths:
  - "src/main/java/**/*Controller.java"
---

# Controller Conventions

## Structure
- `@RestController` methods should act purely as a passthrough and be as thin as possible
- Return `ResponseEntity.ok(response)` for all successful responses

## Logging
- Log at the start of every endpoint using `LOGGER.atInfo()` with structured key-value pairs
- If a principal argument is present, attempt to extract an ID and include it when logging
- Log success after the service call with the same keys plus any response metadata (e.g. count)
- Always use `LogKeys` constants for log keys — never raw strings
- Log messages should be present-tense for start ("Creating...") and past-tense for success ("Successfully created...")

## Error Handling
- Let exceptions propagate from all endpoints — no catch blocks needed
- Error logging is handled centrally (e.g. `GlobalExceptionHandler` or logging interceptor)