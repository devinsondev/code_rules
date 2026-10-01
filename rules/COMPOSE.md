# Compose rules

Applies to Jetpack Compose and, where compatible, Compose Multiplatform.

## 1. Composables render UI

Composable functions should primarily:
- receive state;
- emit callbacks/events;
- render UI.

Do not call repositories/use cases directly from reusable UI composables.

## 2. Stateless by default

Prefer state hoisting.

Use local `remember` state only for genuinely local UI concerns such as:
- expansion;
- transient animation state;
- focus;
- scroll position.

Business/product state belongs in the screen state owner.

Use `rememberSaveable` for small UI state that should survive recreation when appropriate.

## 3. Single source of truth

Prefer one coherent immutable `UiState` per screen rather than a pile of unrelated observable fields.

Avoid “boolean soup” such as:
```text
isLoading
isLoaded
hasError
showEmpty
showDialog
isSuccess
```
when explicit state modeling would be clearer.

## 4. Immutable state

Expose immutable state from ViewModels/controllers.

Prefer `StateFlow`/read-only flows and immutable collections/models.

Do not expose mutable state containers to UI callers.

## 5. Lifecycle-aware collection

On Android, collect observable state with lifecycle-aware APIs where appropriate.

Long-running work should not be tied to arbitrary composition lifetime.

## 6. Side effects

Use Compose side-effect APIs deliberately.

- `LaunchedEffect`: keys must represent when the effect should restart.
- `DisposableEffect`: clean up resources.
- `rememberUpdatedState`: avoid stale captured callbacks when needed.
- `rememberCoroutineScope`: UI-scoped jobs only.

Never use unmanaged global coroutine scopes.

## 7. Small composables

A composable should have one clear visual responsibility.

Extract:
- repeated components;
- complex sections;
- stateful boundaries;
- reusable layout structures.

Do not fragment every 5 lines into a function; split where it clarifies responsibility.

## 8. Layout

Prefer:
- `Modifier` for padding/size/semantics;
- `Row`/`Column` for simple linear layout;
- `Box` when overlap is actually needed;
- Lazy layouts for large/unknown lists.

Avoid deep wrapper nesting and nested scroll containers without a real interaction need.

## 9. Lists

For lazy lists:
- provide stable keys when identity exists;
- avoid expensive per-item work during composition;
- keep item state stable;
- do not decode/transform heavy assets inside item composition.

## 10. Recomposition discipline

Prefer immutable/stable inputs.

Move heavy computation out of composition or cache it appropriately.

Do not chase micro-optimizations without evidence, but avoid obvious repeated expensive work.

## 11. Theme

Centralize:
- colors;
- typography;
- shapes;
- spacing/tokens where useful.

Feature composables should not scatter raw hex colors and arbitrary text styles.

## 12. Navigation events

Do not represent one-time navigation as persistent screen state that can replay unexpectedly.

Keep navigation behavior explicit and lifecycle-safe.

## 13. Previews

For significant reusable components/screens, previews are valuable for:
- normal state;
- empty state;
- long text;
- dark theme;
- large content variants.

Do not treat previews as a substitute for device testing.

## 14. Accessibility

Use semantics intentionally.

Interactive icon-only controls need meaningful accessible labels.

Do not attach redundant descriptions to decorative elements.

## 15. Testing

Keep business logic testable without Compose or Android runtime.

Composable tests should focus on observable UI behavior and semantics, not implementation structure.
