# Local Windows workstation

These rules describe the intended single-machine Android build environment.

## Fixed paths

Android projects are cloned under:

```text
D:\ORDERED_CODE\PHONE\APPS\<repo>
```

Android Studio bundled JDK:

```text
D:\TOOLS\andrstdio\jbr
```

Android SDK:

```text
%LOCALAPPDATA%\Android\Sdk
```

Project-local helper BAT files may hardcode the JDK path above.

Do not hardcode the full repository path. Use the BAT file's own directory.

## Standard project helper

Every Android application repository should preferably contain:

```text
gradlew
gradlew.bat
gradle\wrapper\...
gradle\verification-metadata.xml
build-debug.bat
```

Before building, the helper BAT must verify that `gradle\wrapper\gradle-wrapper.properties` exists and contains `distributionSha256Sum`.

The wrapper SHA must come from the official Gradle checksum reference.

For dependency verification, generate `gradle\verification-metadata.xml` once from a known-good dependency set, review it, commit it, and do not regenerate it during normal builds.

## Expected workflow

```powershell
cd D:\ORDERED_CODE\PHONE\APPS\<repo>
git pull
.\build-debug.bat
```

Generated APKs and `build/` directories remain ignored by Git.
