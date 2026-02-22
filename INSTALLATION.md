# Installation & Configuration Guide

## System Requirements

Before you start, ensure you have:
- **Flutter SDK** (version 3.0.0 or later)
- **Android SDK** (for Android development)
- **Dart SDK** (usually included with Flutter)
- **Git** (optional, for version control)

## Step 1: Install Flutter

### Windows
1. Download Flutter SDK from: https://flutter.dev/docs/get-started/install/windows
2. Extract to a location (e.g., `C:\flutter`)
3. Add Flutter to your PATH:
   - Open System Properties → Environment Variables
   - Add `C:\flutter\bin` to PATH
4. Verify installation:
   ```bash
   flutter --version
   ```

### macOS
```bash
brew install flutter
flutter --version
```

### Linux
1. Download from: https://flutter.dev/docs/get-started/install/linux
2. Extract and add to PATH
3. Verify: `flutter --version`

## Step 2: Setup Project

### Clone/Download Project
```bash
cd space_shooter
```

### Run Setup Script
**Windows:**
```bash
setup.bat
```

**macOS/Linux:**
```bash
chmod +x setup.sh
./setup.sh
```

### Or Manual Setup
```bash
flutter pub get
flutter analyze
```

## Step 3: Configure Android

### Check Android Setup
```bash
flutter doctor
```

Look for:
- ✅ Android SDK
- ✅ Android Studio
- ✅ Connected device or emulator

### Create/Run Android Emulator

**Using Android Studio:**
1. Open Android Studio
2. Tools → AVD Manager
3. Create Virtual Device (Pixel 4 or similar)
4. Start emulator

**Using Command Line:**
```bash
emulator -list-avds                    # List available emulators
emulator -avd Pixel_4_API_30 -netdelay none -netspeed full
```

### Connect Physical Device
1. Enable Developer Mode on phone:
   - Settings → About Phone → Tap Build Number 7 times
   - Settings → Developer Options → USB Debugging (ON)
2. Connect via USB
3. Trust the computer when prompted
4. Verify: `flutter devices`

## Step 4: Add Audio Assets (Optional)

### Create Audio Directory
```bash
mkdir -p assets/audio
```
(Already created in the project)

### Add Your Audio Files
Place these MP3 files in `assets/audio/`:
- `background_music.mp3` (any length, will loop)
- `shoot.mp3` (short shooting sound)
- `hit.mp3` (short collision sound)

### Where to Find Audio
- **Free Sources:**
  - https://freesound.org
  - https://zapsplat.com
  - https://pixabay.com/sound
  - https://freepd.com

- **Create Your Own:**
  - Audacity (free audio editor)
  - GarageBand (macOS)
  - FL Studio (professional)

### If You Skip This
Don't worry! The game works perfectly without audio. It gracefully handles missing files.

## Step 5: Run the Game

### Debug Mode (First Run)
```bash
flutter run
```

### Select Device
If multiple devices available:
```bash
flutter run -d <device-id>
```

### Release Mode (Best Performance)
```bash
flutter run --release
```

### Specific Options
```bash
# Run with verbose output
flutter run -v

# Run with profiling
flutter run --profile

# Enable Impeller renderer (faster graphics)
flutter run --enable-impeller
```

## Step 6: Troubleshooting

### Issue: "flutter command not found"
**Solution:** Check PATH configuration
```bash
# Check Flutter location
which flutter    # macOS/Linux
where flutter    # Windows

# Add to PATH if needed
echo $PATH       # Check current PATH
```

### Issue: "No Android SDK found"
**Solution:** 
```bash
flutter config --android-sdk /path/to/android/sdk
# or
flutter doctor --android-licenses
flutter doctor -v
```

### Issue: "Gradle build failed"
**Solution:**
```bash
flutter clean
flutter pub get
flutter run
```

### Issue: "Error: The application could not start"
**Solution:**
```bash
# Try in debug mode first
flutter run

# Then try release mode
flutter run --release
```

### Issue: Android emulator won't start
**Solution:**
1. Check emulator compatibility: `emulator -list-avds`
2. Try older API level (API 29 or 30)
3. Restart Android Studio
4. Delete emulator and create new one

### Issue: Dependencies compilation error
**Solution:**
```bash
flutter clean
rm -rf pubspec.lock    # macOS/Linux
del pubspec.lock       # Windows
flutter pub get
```

## Configuration Files Explained

### pubspec.yaml
- **name:** Project name
- **version:** App version
- **dependencies:** Required packages (Flame, audioplayers, etc.)
- **assets:** Image and audio file locations

### analysis_options.yaml
- Code quality rules
- Lint configuration
- Keeps code consistent

### AndroidManifest.xml
- App permissions (internet, etc.)
- Activity configuration
- App metadata

## Performance Tuning

### Enable Performance Monitoring
```bash
flutter run --profile
```
This shows FPS counter in the app

### Optimize Build Size
```bash
flutter build apk --split-per-abi --release
```

### Check Permissions
Ensure audio and storage permissions if needed:
- Android 6.0+ requires runtime permissions
- Check AudioManager in `lib/utils/audio_manager.dart`

## Environment Variables

Optional - Set for custom configurations:

```bash
# macOS/Linux
export JAVA_HOME=/path/to/jdk
export ANDROID_SDK_ROOT=/path/to/android/sdk

# Windows (PowerShell)
$env:JAVA_HOME = "C:\Program Files\Java\jdk"
$env:ANDROID_SDK_ROOT = "C:\Android\sdk"
```

## IDE Setup

### VS Code
```bash
code space_shooter
```

**Extensions to Install:**
- Flutter
- Dart
- Awesome Flutter Snippets

### Android Studio
```bash
android-studio space_shooter
```

**Configure:**
- File → Settings → Languages & Frameworks → Flutter
- Point to Flutter SDK location

## Device Configuration

### Recommended for Testing
- **Minimum:** Android 5.0 (API 21)
- **Recommended:** Android 8.0+ (API 26+)
- **RAM:** 2GB or more
- **Storage:** 50MB free space

### Optimal Testing Devices
- Pixel 4 (emulator)
- Nexus 5X (emulator)
- Real device with Android 8+

## Build Sizes

Typical build sizes:
- Debug APK: 80-150 MB
- Release APK: 20-40 MB
- App Bundle (AAB): 15-20 MB

## Next: Run the Game! 🎮

```bash
# Quick start
flutter run --release

# Or use the quick start guide
cat QUICK_START.md
```

## Still Having Issues?

1. **Check Flutter doctor:**
   ```bash
   flutter doctor -v
   ```

2. **See full logs:**
   ```bash
   flutter logs
   ```

3. **Visit:**
   - Flutter Docs: https://flutter.dev
   - Flame Docs: https://flame-engine.org
   - Stack Overflow: Tag with `flutter`

---

**You're all set! Ready to play? Run: `flutter run --release`**
