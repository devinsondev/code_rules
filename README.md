# code_rules

Opinionated AI coding rules for Android-first applications, with Kotlin Multiplatform support when Android + Windows share one product.

The repository is intentionally **text-only**. No npm runtime, no binaries, no hooks are required. An AI coding agent reads `SKILL.md` and the referenced rules before it writes or reviews code.

## Structure

```text
SKILL.md                 # entry point and precedence
AGENTS.md                # short bootstrap for coding agents
rules/
  CODE_QUALITY.md        # 377-line rule, anti-god-file, naming, complexity
  ARCHITECTURE.md        # feature-first architecture, KMP boundaries
  ANDROID.md             # Android-native behavior and platform rules
  COMPOSE.md             # Jetpack/Compose Multiplatform implementation rules
  UI_UX.md               # anti-generic design direction and UX quality
  GRADLE.md              # Gradle Wrapper + Windows terminal build rules
  VERIFICATION.md        # build, test and release checklist
SOURCES.md               # upstream inspiration and licenses
```

## How to use

Tell the coding agent:

> Read https://github.com/devinsondev/code_rules/blob/main/SKILL.md and follow it for this project.

For a stricter workflow, clone or vendor this repository into the project and point the agent to `SKILL.md`.

## Core defaults

- Kotlin + Compose.
- Kotlin Multiplatform when Android and Windows should share product logic/UI.
- Feature-first organization.
- Platform code kept thin.
- No handwritten source file over **377 lines**.
- No god files, god ViewModels, grab-bag utilities, hidden mutable state or placeholder implementations.
- Android UI should feel native, not like a website squeezed into a phone.
- On Windows, use the project's `gradlew.bat` when available.
- The full Gradle Wrapper belongs in each app repository; this rules repo intentionally does not freeze one Gradle version.
- Build and verification are part of completion.
