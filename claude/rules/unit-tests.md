---
paths:
  - "src/test/java/**/*.java"
---

# Testing Conventions

## Setup
- Use `@ExtendWith(MockitoExtension.class)` for unit tests
- Declare dependencies as `@Mock` fields, suffixed with `Mock` (e.g. `billingServiceMock`)
- Use `@InjectMocks` to instantiate the subject under test where possible; fall back to manual constructor instantiation in `@BeforeEach` when `@InjectMocks` is not suitable
- Name the setup method `setup()`

## Test Naming
- Prefer the `methodName_WhenCondition_ShouldOutcome` pattern for tests with meaningful scenarios (e.g. `getInvoice_WhenInvoiceExists_ShouldReturnInvoice`)
- Simple delegation tests with no interesting condition may use `methodNameTest` (e.g. `deleteInvoiceTest`)

## Assertions
- Use AssertJ (`assertThat`, `assertThatExceptionOfType`) as the primary assertion library — not JUnit `assertEquals`/`assertTrue`
- Use `assertThatExceptionOfType(...).isThrownBy(...)` or `assertThatThrownBy(...).isInstanceOf(...)` for expected exceptions — both allow chaining assertions on the exception (e.g. `.withMessage(...)`, `.hasMessage(...)`)
- Always `verify(...)` interactions with mocks to confirm the correct collaborator was called

## Test Organisation
- For multi-step tests, use `// Arrange`, `// Act`, `// Assert` comments to separate sections
- Keep single-behavior tests concise — no section comments needed when the test is short

## Test Data
- Use shared factory methods from `TestUtil` for common fixtures (e.g. `TestUtil.createSomeEntity()`, `createSomeDto(UUID)`)
- Use realistic but clearly fake values in fixtures (e.g. `"555-555-1234"`, `"addressLine1"`)

## Imports
- Use static imports for `assertThat`, `verify`, `when`, and `TestUtil` factory methods

## Test Scope
- **DO NOT:** write trivial tests for simple classes (e.g. records, POJOs) whose behavior will already be exercised through tests of their consumers (e.g. a handler test that processes exceptions covers the exception constructors)
- **DO NOT:** test framework guarantees. Skip tests that verify standard bean validation, Jackson, or Spring annotation behavior.
- **DO:** Look for an existing that can easily be updated rather than immediately jumping to write a new test
- **DO:** Focus tests on classes with non-obvious logic, branching, or state management
- **DO:** Write one test per behavior, not per edge case. Prefer a single test with multiple assertions over a separate test per case. Split only when inputs reach distinct code paths.
