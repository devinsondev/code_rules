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

Because these repositories are expected to be built on this one workstation, project-local helper BAT files may safely hardcode the JDK path above.

Do not hardcode the full repository path. The BAT file should execute relative to its own repository directory so any repo under `D:\ORDERED_CODE\PHONE\APPS` works.

## Standard project helper

Every Android application repository should preferably contain:

```text
gradlew
gradlew.bat
gradle\wrapper\...
build-debug.bat
```

Recommended `build-debug.bat`:

```bat
@echo off
setlocal

cd /d "%~dp0"

set "JAVA_HOME=D:\TOOLS\andrstdio\jbr"
set "ANDROID_HOME=%LOCALAPPDATA%\Android\Sdk"
set "PATH=%JAVA_HOME%\bin;%ANDROID_HOME%\platform-tools;%ANDROID_HOME%\cmdline-tools\latest\bin;%PATH%"

call gradlew.bat :app:assembleDebug
if errorlevel 1 (
    echo.
    echo BUILD FAILED
    exit /b 1
)

echo.
echo BUILD SUCCESSFUL
echo APK: %CD%\app\build\outputs\apk\debug\app-debug.apk
exit /b 0
```

Why `cd /d "%~dp0"`:
- the script always builds the repository it belongs to;
- it works even if PowerShell/CMD was opened elsewhere;
- it handles the `D:` drive correctly.

If the Android module is not named `app`, adjust the Gradle task and output path for that repository.

## Optional build-and-install helper

For projects where installing to a connected device is useful, `install-debug.bat` may use:

```bat
@echo off
setlocal

cd /d "%~dp0"

set "JAVA_HOME=D:\TOOLS\andrstdio\jbr"
set "ANDROID_HOME=%LOCALAPPDATA%\Android\Sdk"
set "PATH=%JAVA_HOME%\bin;%ANDROID_HOME%\platform-tools;%ANDROID_HOME%\cmdline-tools\latest\bin;%PATH%"

call gradlew.bat :app:assembleDebug
if errorlevel 1 exit /b 1

adb install -r "app\build\outputs\apk\debug\app-debug.apk"
if errorlevel 1 exit /b 1

echo.
echo BUILD + INSTALL SUCCESSFUL
```

## Expected workflow

From PowerShell:

```powershell
cd D:\ORDERED_CODE\PHONE\APPS\<repo>
git pull
.\build-debug.bat
```

The helper BAT is source code and should be committed to the app repository.

Generated APKs and `build/` directories should remain ignored by Git.
