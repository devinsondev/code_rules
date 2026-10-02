@echo off
setlocal EnableExtensions

cd /d "%~dp0"

call build-debug.bat
if errorlevel 1 exit /b 1

set "ANDROID_HOME=%LOCALAPPDATA%\Android\Sdk"
set "PATH=%ANDROID_HOME%\platform-tools;%PATH%"
set "APK=app\build\outputs\apk\debug\app-debug.apk"

if not exist "%APK%" (
    echo ERROR: APK not found at %APK%
    exit /b 1
)

adb get-state >nul 2>&1
if errorlevel 1 (
    echo ERROR: No authorized Android device is available through ADB.
    echo Check: adb devices
    exit /b 1
)

adb install -r "%APK%"
if errorlevel 1 exit /b 1

echo.
echo BUILD + INSTALL SUCCESSFUL
exit /b 0
