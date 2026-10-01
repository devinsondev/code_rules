---
name: android-product-engineering
description: Opinionated rules for production Android and Kotlin Multiplatform apps: architecture, code quality, Compose, Android-native UX, anti-generic UI, testing and build verification.
---

# Android Product Engineering Skill

Use this skill for Android apps and Kotlin Multiplatform products that target Android plus desktop/Windows.

## Mandatory reading order

Before implementing or reviewing substantial code, read:

1. `rules/CODE_QUALITY.md`
2. `rules/ARCHITECTURE.md`
3. `rules/ANDROID.md`
4. `rules/COMPOSE.md`
5. `rules/UI_UX.md`
6. `rules/GRADLE.md`
7. `rules/LOCAL_WINDOWS.md`
8. `rules/VERIFICATION.md`

Apply only rules relevant to the task, but the hard constraints in CODE_QUALITY always apply.

## Priorities

When rules conflict, use this order:

1. Correctness and data safety.
2. User request and existing product requirements.
3. Platform conventions and accessibility.
4. Maintainability and testability.
5. Performance.
6. Visual polish.
7. Cleverness last.

Prefer simple, explicit, boring code over clever abstractions.

## Default stack

Unless the project already establishes another stack:

- Kotlin.
- Jetpack Compose on Android.
- Compose Multiplatform for shared Android/Desktop UI when appropriate.
- Coroutines + Flow.
- Immutable UI state.
- Material 3 as the Android structural baseline.
- SQLDelight or Room depending on actual platform scope; do not force either without need.
- Constructor injection; use the project's DI framework if one already exists.

Do not introduce a library merely because this skill mentions a category.

## Completion standard

A feature is not complete merely because code was emitted.

Before declaring completion:

- no handwritten source file exceeds 377 lines;
- no obvious god class or god composable remains;
- platform-specific code is isolated;
- UI follows Android conventions;
- accessibility and large text are considered;
- placeholder/TODO implementation is absent unless explicitly requested;
- relevant build/tests are run when tools are available;
- on Windows, use the project's `gradlew.bat` when present instead of requiring global Gradle;
- for repositories intended for the configured local workstation, include/update the simple helper BAT when useful.

## Design behavior

Do not default to stereotypical AI UI: purple-blue gradients, glass everywhere, nested cards, arbitrary pills, giant whitespace with tiny text, fake dashboards, or iOS controls on Android.

Infer the product context first, then choose an appropriate visual language. Distinctive is good; off-platform is not.

## Existing projects

Respect established architecture and visual language unless they are clearly harmful or the user asked for a redesign/refactor. Improve incrementally instead of rewriting working code without cause.
