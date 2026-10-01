# code_rules

Opinionated AI coding rules for Android-first applications, with Kotlin Multiplatform support when Android + Windows share one product.

The repository is intentionally **text-first**. No npm runtime, no installed CLI and no hooks are required. It also contains tiny BAT templates that can be copied into app repositories.

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
  LOCAL_WINDOWS.md       # fixed paths/workflow for the target workstation
  VERIFICATION.md        # build, test and release checklist
templates/
  build-debug.bat        # reusable local build helper
  install-debug.bat      # optional build + adb install helper
SOURCES.md               # upstream inspiration and licenses
```

## How to use

Tell the coding agent:

> Read https://github.com/devinsondev/code_rules/blob/main/SKILL.md and follow it for this project.

## Local Android workflow

Projects are expected under:

```text
D:\ORDERED_CODE\PHONE\APPS\<repo>
```

On the configured workstation, an app repository can contain its own `build-debug.bat`, so the normal workflow becomes:

```powershell
git pull
.\build-debug.bat
```

The BAT sets the known JDK/SDK environment and invokes the project's own Gradle Wrapper.

## Core defaults

- Kotlin + Compose.
- Kotlin Multiplatform when Android and Windows should share product logic/UI.
- Feature-first organization.
- Platform code kept thin.
- No handwritten source file over **377 lines**.
- No god files, god ViewModels, grab-bag utilities, hidden mutable state or placeholder implementations.
- Android UI should feel native, not like a website squeezed into a phone.
- On Windows, use the project's `gradlew.bat` when available.
- The full Gradle Wrapper belongs in each app repository.
- Build and verification are part of completion.
