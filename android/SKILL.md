---
name: android-product-engineering
description: Single source of truth for AI-built Android/Kotlin projects stored in GitHub and built on the configured Windows workstation.
---

# Android Product Engineering — CANONICAL STANDARD

This file is the **single mandatory source of truth** for Android projects created or modified by an AI agent.

The intended workflow is:

```text
AI edits/pushes the GitHub repository
→ user runs git pull --ff-only
→ user runs .\build-debug.bat
→ project verifies its build chain
→ tests run
→ APK builds
```

The user should not need to manually repair Gradle, regenerate security metadata, install a global Gradle, or edit machine paths after an ordinary pull.

Supporting files under `rules/` may provide additional detail, but **if anything conflicts with this file, this file wins**.

---

# 1. Non-negotiable agent contract

The agent MUST:

- leave the target GitHub branch in a coherent, buildable state;
- use the repository's own Gradle Wrapper;
- keep build-security files committed;
- make local Windows builds fail closed when a required security check is missing;
- update verification metadata when dependencies legitimately change;
- run available build/tests before claiming completion;
- state explicitly what could not be verified.

The agent MUST NOT:

- silently omit a required security file;
- weaken or bypass checksum/dependency verification just to make a build pass;
- automatically regenerate verification metadata during every normal build;
- use `curl | sh`, remote PowerShell execution, downloaded executable helpers, or arbitrary mirrors;
- require a global Gradle when a project wrapper can be committed;
- put secrets, tokens, passwords, private keys, signing keystores, or credentials into Git;
- place `git pull` inside the normal build BAT. Pulling and executing remain two explicit user actions.

Normal user workflow MUST remain:

```powershell
git pull --ff-only
.\build-debug.bat
```

---

# 2. Default Android stack

Unless an existing project already establishes a compatible alternative:

- Kotlin;
- Jetpack Compose;
- Material 3;
- Coroutines + Flow;
- immutable UI state;
- StateFlow / unidirectional state flow where appropriate;
- feature-first organization;
- constructor injection unless an existing DI framework is already present.

For products that intentionally share Android + Windows/Desktop logic/UI, Kotlin Multiplatform / Compose Multiplatform may be used.

Do not add a dependency merely because it is fashionable or convenient.

---

# 3. Code quality hard constraints

These are mandatory:

- handwritten source files: **377 lines maximum**;
- no god files;
- no god classes;
- no god ViewModels;
- no god composables;
- no grab-bag utility classes;
- no hidden mutable global state;
- no business logic inside Compose UI;
- no placeholder/TODO implementation presented as complete work;
- no unnecessary abstraction layers;
- platform-specific APIs stay in platform-specific code.

Prefer small, explicit, boring code over clever code.

---

# 4. Android application security baseline

Use least privilege.

The app MUST request only permissions required by actual product behavior.

Defaults unless a feature explicitly requires otherwise:

- do not request `INTERNET`;
- do not allow cleartext network traffic;
- do not export Android components unless required;
- avoid WebView;
- avoid dynamic code loading;
- avoid executing shell/process commands from the Android app;
- do not accept arbitrary file/content/network URIs when a narrower trusted source is available;
- validate untrusted external input before parsing/decoding;
- keep backups disabled for apps containing local/private data unless backup is an explicit product requirement.

When handling media/files:

- validate MIME/type where meaningful;
- validate size before expensive processing;
- constrain dimensions/duration where malformed input could exhaust resources;
- prefer system providers such as MediaStore/SAF over raw arbitrary paths;
- do heavy decoding/IO off the main thread.

Security rules must fit the product. Do not add fake security code that provides no real boundary.

---

# 5. Gradle Wrapper — mandatory supply-chain rules

Every Android application repository MUST commit the complete wrapper:

```text
gradlew
gradlew.bat
gradle/
  wrapper/
    gradle-wrapper.jar
    gradle-wrapper.properties
```

The wrapper version MUST be compatible with the project's Android Gradle Plugin and Kotlin versions.

`gradle-wrapper.properties` MUST use the official HTTPS Gradle distribution and MUST contain an exact official SHA-256:

```properties
distributionUrl=https\://services.gradle.org/distributions/gradle-X.Y.Z-bin.zip
distributionSha256Sum=<official exact SHA-256>
validateDistributionUrl=true
```

The checksum MUST be obtained from Gradle's official release/checksum source.

Do not use an arbitrary mirror.

## Wrapper JAR verification

`gradle-wrapper.jar` executes before project Gradle build logic and therefore MUST also be treated as security-sensitive.

For every project, the agent MUST determine the trusted SHA-256 of the committed wrapper JAR and put that exact expected value into the project's local build preflight.

A changed wrapper JAR MUST NOT be accepted merely because the distribution ZIP checksum is valid.

Whenever the wrapper version/JAR changes, the agent MUST:

1. verify the intended Gradle version;
2. update `distributionUrl`;
3. update `distributionSha256Sum`;
4. verify the wrapper JAR against a trusted official/reference source;
5. update the local BAT expected wrapper-JAR SHA;
6. update CI preflight if CI exists.

---

# 6. Dependency verification — mandatory

Every completed Android project MUST commit:

```text
gradle/verification-metadata.xml
```

The metadata MUST verify dependency metadata and contain SHA-256 hashes for resolved artifacts.

Generation command on a trusted dependency set:

```powershell
.\gradlew.bat --write-verification-metadata sha256 :app:testDebugUnitTest :app:assembleDebug
```

Generation is trust-on-first-use.

Therefore:

- do not regenerate this file automatically during ordinary builds;
- do not automatically accept new hashes merely because a build requested them;
- review intentional dependency/plugin changes;
- commit metadata updates together with the dependency change;
- normal builds MUST run with strict dependency verification.

Normal build invocation MUST include:

```text
--dependency-verification strict
```

If an agent adds/upgrades/removes a dependency or plugin, it is responsible for leaving `verification-metadata.xml` consistent with the final dependency graph before claiming the repository is ready.

If its current environment cannot generate/verify required metadata, the agent MUST say the repository is not yet fully verified. It MUST NOT pretend the secure workflow is complete.

Preferred repositories:

- `google()`;
- `mavenCentral()`;
- `gradlePluginPortal()` for plugin resolution where needed.

Do not add JitPack, JCenter, random Maven repositories, custom binary repositories, or arbitrary plugin sources unless the product explicitly requires them and the reason is documented.

---

# 7. Mandatory local Windows environment

This workstation is intentionally fixed.

Android project root convention:

```text
D:\ORDERED_CODE\PHONE\APPS\<repo>
```

JDK/JBR:

```text
D:\TOOLS\andrstdio\jbr
```

Android SDK:

```text
%LOCALAPPDATA%\Android\Sdk
```

Project BAT files MAY hardcode the JDK path above.

Do NOT hardcode the full project directory. Use the BAT file's own directory with:

```bat
cd /d "%~dp0"
```

---

# 8. build-debug.bat — mandatory fail-closed preflight

Every Android app repository MUST contain `build-debug.bat`.

Before it calls `gradlew.bat`, it MUST verify all of the following:

1. `gradlew.bat` exists;
2. `gradle\wrapper\gradle-wrapper.jar` exists;
3. `gradle\wrapper\gradle-wrapper.properties` exists;
4. `gradle\verification-metadata.xml` exists;
5. `distributionUrl` exactly matches the intended official Gradle distribution;
6. `distributionSha256Sum` exactly matches the intended official distribution SHA-256;
7. actual SHA-256 of `gradle-wrapper.jar` exactly matches the trusted expected wrapper-JAR SHA;
8. configured JDK exists;
9. Android SDK exists.

If ANY required check fails, the BAT MUST exit non-zero **before running Gradle**.

After preflight it MUST run tests and assemble using strict dependency verification, for a standard `:app` project:

```bat
call gradlew.bat --dependency-verification strict :app:testDebugUnitTest :app:assembleDebug
```

Adjust module/task names only when the repository genuinely uses different modules.

The BAT MUST NOT:

- run `git pull`;
- auto-regenerate dependency verification metadata;
- disable verification after a failure;
- download a replacement wrapper from an arbitrary source.

---

# 9. install/run helper

If device installation is useful, the repository MAY contain `install-debug.bat` or `run-phone.bat`.

It SHOULD call `build-debug.bat` first instead of duplicating/weakening security checks.

Then it may:

1. confirm an authorized ADB device exists;
2. install the known debug APK with `adb install -r`;
3. optionally force-stop and launch the known application/activity.

Do not install an APK if the secure build step failed.

---

# 10. Gradle/plugin/build-script safety

Treat these as executable code, not passive configuration:

- `settings.gradle`;
- `settings.gradle.kts`;
- `build.gradle`;
- `build.gradle.kts`;
- included build logic;
- convention plugins;
- Gradle init scripts;
- `.gradle.kts` files;
- BAT/CMD/PS1 scripts.

Do not add build logic that:

- launches arbitrary OS commands without a clear build need;
- downloads/runs executables;
- reads unrelated user files;
- uploads local files;
- exfiltrates environment variables;
- disables verification;
- adds unknown repositories behind the user's back.

A build script is capable of executing code on the workstation. Review it accordingly.

---

# 11. GitHub workflow and source control

The AI agent is expected to modify the GitHub repository and leave a reviewable history.

Commit:

- application source;
- Gradle build scripts;
- full Gradle Wrapper;
- wrapper checksum configuration;
- dependency verification metadata;
- local BAT helpers;
- tests;
- CI configuration when used.

Do not commit:

- `.gradle/`;
- `build/`;
- APK outputs;
- Android Studio local state;
- `local.properties`;
- secrets;
- signing keys/keystores.

Use `git pull --ff-only` as the normal user-side update command so unexpected merge commits are not created automatically.

Public GitHub visibility does not grant arbitrary users write access. Still, any account/app/token with repository write permission is part of the trust boundary.

---

# 12. CI security baseline

If GitHub Actions CI exists, it MUST at minimum:

- use read-only repository permissions unless more is truly required;
- verify `gradle-wrapper.properties` exists;
- verify the expected `distributionSha256Sum`;
- verify `verification-metadata.xml` exists;
- verify the wrapper JAR SHA-256;
- run unit tests;
- assemble the debug APK on the supported CI OSes.

For stronger supply-chain protection, pin reusable GitHub Actions to reviewed immutable commit SHAs rather than floating branches/tags.

CI MUST NOT silently regenerate verification metadata.

---

# 13. Compose / UX baseline

Android UI should feel like Android, not a website squeezed into a phone.

Mandatory defaults:

- Material 3 structural conventions;
- edge-to-edge handled correctly;
- system bars/insets handled correctly;
- Android Back/predictive Back respected;
- minimum practical touch targets;
- content descriptions/semantics where needed;
- dark theme support;
- large text/font-scale sanity;
- adaptive layouts where relevant;
- lazy containers for long lists;
- no heavy IO/decoding on main thread.

Avoid stereotypical AI UI:

- arbitrary purple/blue gradients;
- excessive glassmorphism;
- card-inside-card nesting;
- meaningless pills;
- huge empty areas with tiny text;
- fake dashboard chrome;
- iOS controls copied onto Android.

---

# 14. Verification before completion

Before claiming work is complete, the agent MUST check what its environment allows.

At minimum verify:

- imports/package names;
- no obvious dead files;
- no handwritten source file above 377 lines;
- no accidental secrets;
- wrapper files present;
- distribution checksum present and correct;
- wrapper JAR checksum known and enforced by local preflight;
- dependency verification metadata present;
- build helper fail-closed behavior;
- unit tests;
- debug assemble.

When an Android device/emulator is available, also verify:

- app launches;
- primary navigation;
- Back behavior;
- permission-denial path;
- empty/error/loading states where relevant;
- keyboard/insets;
- dark theme;
- large font scale.

Never report a runtime check that did not happen.

---

# 15. Definition of READY FOR USER PULL

A GitHub project is **READY FOR USER PULL** only when the intended normal workflow is:

```powershell
cd D:\ORDERED_CODE\PHONE\APPS\<repo>
git pull --ff-only
.\build-debug.bat
```

and no manual Gradle repair/security setup is expected for that ordinary build.

The build BAT must either:

- produce a successfully tested debug APK; or
- stop with a clear error because a security/toolchain requirement is not satisfied.

It must never silently bypass a failed security check.

---

# 16. Existing projects

Do not rewrite working architecture without cause.

When adopting this standard into an existing repository:

1. inspect current build scripts/dependencies;
2. preserve working product behavior;
3. add/repair the full wrapper;
4. add official distribution SHA-256;
5. verify wrapper JAR SHA-256;
6. add/update dependency verification metadata;
7. add/update fail-closed `build-debug.bat`;
8. run tests/build where possible;
9. commit the migration coherently.

---

# 17. Supporting references

The following files remain useful for deeper implementation guidance but are **not required as separate entry points**:

- `rules/CODE_QUALITY.md`
- `rules/ARCHITECTURE.md`
- `rules/ANDROID.md`
- `rules/COMPOSE.md`
- `rules/UI_UX.md`
- `rules/GRADLE.md`
- `rules/LOCAL_WINDOWS.md`
- `rules/VERIFICATION.md`

When they conflict with this file, **SKILL.md wins**.
