@echo off
setlocal

cd /d "%~dp0"

set "JAVA_HOME=D:\TOOLS\andrstdio\jbr"
set "ANDROID_HOME=%LOCALAPPDATA%\Android\Sdk"
set "PATH=%JAVA_HOME%\bin;%ANDROID_HOME%\platform-tools;%ANDROID_HOME%\cmdline-tools\latest\bin;%PATH%"

set "WRAPPER_PROPS=gradle\wrapper\gradle-wrapper.properties"
if not exist "%WRAPPER_PROPS%" (
    echo ERROR: Missing %WRAPPER_PROPS%
    exit /b 1
)

findstr /b /c:"distributionSha256Sum=" "%WRAPPER_PROPS%" >nul
if errorlevel 1 (
    echo ERROR: Gradle wrapper has no distributionSha256Sum.
    exit /b 1
)

call gradlew.bat :app:assembleDebug
if errorlevel 1 exit /b 1

adb install -r "app\build\outputs\apk\debug\app-debug.apk"
if errorlevel 1 exit /b 1

echo.
echo BUILD + INSTALL SUCCESSFUL
exit /b 0
