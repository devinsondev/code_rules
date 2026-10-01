# Gradle and Windows build rules

## 1. Always prefer the project wrapper

On Windows, if `gradlew.bat` exists in the project root, use it.

Do not require or install a global Gradle when the project wrapper exists.

For this workstation's fixed local paths and helper BAT convention, also read `LOCAL_WINDOWS.md`.

## 2. Wrapper belongs to the project

A complete Gradle Wrapper normally includes:

```text
gradlew
gradlew.bat
gradle/
  wrapper/
    gradle-wrapper.jar
    gradle-wrapper.properties
```

Commit these files to the application's repository.

## 3. Gradle distribution checksum is mandatory

Every committed `gradle-wrapper.properties` must contain:

```properties
distributionSha256Sum=<official SHA-256 for the exact Gradle distribution ZIP>
```

The value must come from Gradle's official release checksum reference.

Helper BAT files should refuse to build if `distributionSha256Sum` is missing.

When generating/upgrading a wrapper, prefer:

```powershell
.\gradlew.bat wrapper --gradle-version <version> --distribution-type bin --gradle-distribution-sha256-sum <official-sha256>
```

## 4. Validate wrapper changes

Treat changes to these files as security-sensitive:

- `gradlew`
- `gradlew.bat`
- `gradle/wrapper/gradle-wrapper.jar`
- `gradle/wrapper/gradle-wrapper.properties`

When the wrapper is generated or upgraded, verify the wrapper JAR checksum against Gradle's official checksum list before trusting the change.

## 5. Dependency verification

For a new project, after establishing a known-good dependency set, generate and commit Gradle verification metadata:

```powershell
.\gradlew.bat --write-verification-metadata sha256
```

This creates `gradle/verification-metadata.xml`.

Important: generation is trust-on-first-use. Do not regenerate this file automatically on every build. Review dependency changes and commit metadata updates intentionally.

For stronger setups, add PGP signature verification where practical.

## 6. Java and Android SDK

Before diagnosing Gradle as broken, check Java and Android SDK environment variables.

Single-workstation repositories may use the fixed paths from `LOCAL_WINDOWS.md` inside helper BAT files.

Do not hardcode full repository paths; scripts should use their own directory.

## 7. First wrapper run

The first invocation may download the exact Gradle distribution declared by `gradle-wrapper.properties`.

Use the standard Gradle distribution host:

```text
https://services.gradle.org/distributions/
```

With `distributionSha256Sum` configured, Gradle must reject a downloaded ZIP whose SHA-256 does not match.

## 8. Missing wrapper

If a project has no wrapper:

1. determine the compatible Gradle version;
2. obtain the official SHA-256 for that exact distribution;
3. generate the wrapper with that checksum;
4. verify the wrapper JAR;
5. commit the complete wrapper;
6. use `.\gradlew.bat` thereafter.

## 9. Build result

`gradlew.bat --version` only proves the wrapper launches.

For a standard Android app:

```powershell
.\gradlew.bat :app:assembleDebug
```

Only treat the APK as built after the assemble task succeeds.

## 10. Source control

Commit:
- wrapper files;
- wrapper checksum configuration;
- dependency verification metadata;
- helper BAT files.

Do not commit Gradle caches, APK outputs, secrets, keystores, or generated build directories.
