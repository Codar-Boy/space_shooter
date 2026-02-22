#!/bin/bash

# Space Shooter - Setup Script
# This script prepares your Flutter environment and dependencies

echo "================================"
echo "Space Shooter - Setup Script"
echo "================================"
echo ""

# Check Flutter installation
echo "Checking Flutter installation..."
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter not found. Please install Flutter first."
    echo "Visit: https://flutter.dev/docs/get-started/install"
    exit 1
fi

echo "✅ Flutter found: $(flutter --version)"
echo ""

# Check if in correct directory
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ pubspec.yaml not found. Please run this script from the project root."
    exit 1
fi

echo "📦 Getting dependencies..."
flutter pub get

if [ $? -eq 0 ]; then
    echo "✅ Dependencies installed successfully"
else
    echo "❌ Failed to get dependencies"
    exit 1
fi

echo ""
echo "🔍 Running code analysis..."
flutter analyze

echo ""
echo "================================"
echo "✅ Setup Complete!"
echo "================================"
echo ""
echo "To run the game:"
echo "  flutter run              (debug mode)"
echo "  flutter run --release    (optimized)"
echo ""
echo "To build for release:"
echo "  flutter build apk --release"
echo ""
echo "For more info, see QUICK_START.md or README.md"
