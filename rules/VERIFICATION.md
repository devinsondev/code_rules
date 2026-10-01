# Verification

Do not claim production-ready completion without checking what can be checked in the available environment.

For Gradle/Windows setup, follow `GRADLE.md`.

## 1. Build security preflight

Before running the build:
- `gradle-wrapper.properties` exists;
- `distributionSha256Sum` is present;
- wrapper changes were reviewed/verified when upgraded;
- `gradle/verification-metadata.xml` is present for projects that have completed dependency-verification setup;
- verification metadata is not regenerated automatically during ordinary builds.

## 2. Code checks

Before finishing:
- imports resolve;
- package/module names are correct;
- no dead files from refactors;
- no obvious unused dependencies;
- no handwritten source file > 377 lines;
- no TODO/FIXME placeholders unless explicitly accepted;
- platform-specific APIs stay in platform-specific code.

## 3. Build

On Windows, use the project wrapper:

```powershell
.\gradlew.bat :app:assembleDebug
```

Use the actual module task if the project differs.

`gradlew.bat --version` is only a toolchain check; it does not build the APK.

## 4. Tests

Run relevant unit tests when available. Prioritize domain rules, state transitions and regressions.

## 5. Android runtime pass

When adb/emulator/device is available, check:
- app launches;
- navigation and Back work;
- keyboard/insets;
- light/dark;
- large font scale;
- empty/error/loading states;
- permission denial paths where relevant.

## 6. Completion report

State what changed, what build/tests succeeded, what could not be verified, and known limitations.

Never imply an APK was built just because Gradle launched successfully.
