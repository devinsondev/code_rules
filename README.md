# code_rules

Single-source AI coding standard for Android-first applications, with Kotlin Multiplatform support when Android + Windows intentionally share one product.

## One instruction for the AI

Use exactly this entry point:

> Read https://github.com/devinsondev/code_rules/blob/main/SKILL.md and follow it as the single source of truth. Modify the target GitHub repository until it satisfies READY FOR USER PULL.

You do **not** need to separately tell the agent to read every file under `rules/`. `SKILL.md` is canonical and takes precedence.

## Intended workflow

The AI edits/pushes the application repository.

On the configured Windows workstation, the normal user workflow is then:

```powershell
cd D:\ORDERED_CODE\PHONE\APPS\<repo>
git pull --ff-only
.\build-debug.bat
```

The project-local BAT must fail closed unless the Gradle wrapper, official distribution checksum, wrapper-JAR checksum, dependency verification metadata, JDK and Android SDK all pass preflight.

Normal builds use strict Gradle dependency verification.

## Fixed workstation

Projects:

```text
D:\ORDERED_CODE\PHONE\APPS\<repo>
```

Android Studio JBR:

```text
D:\TOOLS\andrstdio\jbr
```

Android SDK:

```text
%LOCALAPPDATA%\Android\Sdk
```

## Repository structure

```text
SKILL.md                 # SINGLE CANONICAL STANDARD
AGENTS.md                # tells agents to use SKILL.md
rules/                   # optional deeper references
templates/
  build-debug.bat        # fail-closed secure build template
  install-debug.bat      # build + adb install helper
SOURCES.md
```

## Core guarantees expected from generated projects

- complete Gradle Wrapper committed;
- official Gradle distribution SHA-256 pinned;
- trusted wrapper-JAR SHA-256 checked before Gradle runs;
- `gradle/verification-metadata.xml` committed;
- strict dependency verification on normal builds;
- no automatic regeneration of trusted hashes during ordinary builds;
- tests + debug assemble in `build-debug.bat`;
- no `git pull` inside the BAT;
- no secrets/keystores/build outputs committed;
- Kotlin/Compose code-quality and Android UX rules from `SKILL.md`.

Supporting rule files may add detail, but `SKILL.md` always wins.
