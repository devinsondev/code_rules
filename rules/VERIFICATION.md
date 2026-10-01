# Verification

Do not claim production-ready completion without checking what can be checked in the available environment.

For Gradle/Windows wrapper setup, follow `GRADLE.md`.

## 1. Code checks

Before finishing:
- imports resolve;
- package/module names are correct;
- no dead files from refactors;
- no obvious unused dependencies;
- no handwritten source file > 377 lines;
- no TODO/FIXME placeholders unless explicitly accepted;
- platform-specific APIs stay in platform-specific code.

## 2. Build

For Android on Windows, if the wrapper exists, use it rather than a global Gradle installation:

```powershell
.\gradlew.bat :app:assembleDebug
```

Use the actual module task if the project differs, e.g.:

```powershell
.\gradlew.bat :composeApp:assembleDebug
```

For KMP/Desktop also compile/package the relevant desktop target when it is part of the requested deliverable.

`gradlew.bat --version` is only a wrapper/toolchain check; it does not build the APK.

## 3. Tests

Run relevant unit tests when available.

Prioritize tests for:
- domain rules;
- parsers/formatters;
- reducers/state transitions;
- repositories with meaningful logic;
- regressions being fixed.

Do not write meaningless tests only to increase count.

## 4. Android runtime pass

When adb/emulator/device is available, check:
- app launches;
- primary navigation works;
- Back works;
- keyboard does not cover inputs/actions;
- light/dark;
- large font scale;
- empty/error/loading states;
- permission denial path where relevant.

## 5. Visual checks

Inspect for:
- clipped text;
- unsafe insets;
- broken scrolling;
- tiny hit targets;
- inconsistent spacing;
- accidental raw colors;
- over-nested cards;
- off-platform controls;
- layout breakage on different window sizes.

## 6. Performance sanity

Watch for:
- heavy work on main thread;
- non-lazy long lists;
- repeated expensive composition work;
- decoding full-size images for tiny thumbnails;
- uncontrolled coroutine scopes;
- unnecessary startup work.

Optimize measured/obvious problems, not hypothetical nanoseconds.

## 7. Completion report

When reporting completion, state:
- what changed;
- what build/test commands succeeded;
- what could not be verified;
- any remaining known limitation.

Never imply an APK was built just because Gradle launched successfully.
Never imply a device/runtime check happened if only static code was reviewed.
