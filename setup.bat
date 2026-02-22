@echo off
REM Space Shooter - Windows Setup Script
REM This script prepares your Flutter environment and dependencies

echo ================================
echo Space Shooter - Setup Script
echo ================================
echo.

REM Check Flutter installation
echo Checking Flutter installation...
where /q flutter
if %errorlevel% neq 0 (
    echo ❌ Flutter not found. Please install Flutter first.
    echo Visit: https://flutter.dev/docs/get-started/install
    pause
    exit /b 1
)

echo ✅ Flutter found
flutter --version
echo.

REM Check if in correct directory
if not exist "pubspec.yaml" (
    echo ❌ pubspec.yaml not found. Please run this script from the project root.
    pause
    exit /b 1
)

echo 📦 Getting dependencies...
call flutter pub get

if %errorlevel% equ 0 (
    echo ✅ Dependencies installed successfully
) else (
    echo ❌ Failed to get dependencies
    pause
    exit /b 1
)

echo.
echo 🔍 Running code analysis...
call flutter analyze

echo.
echo ================================
echo ✅ Setup Complete!
echo ================================
echo.
echo To run the game:
echo   flutter run              (debug mode)
echo   flutter run --release    (optimized)
echo.
echo To build for release:
echo   flutter build apk --release
echo.
echo For more info, see QUICK_START.md or README.md
echo.
pause
