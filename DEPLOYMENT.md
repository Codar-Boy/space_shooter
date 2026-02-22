# Deployment & Release Guide

Complete guide for building and deploying Space Shooter to production.

---

## 📦 Build Types

### Debug Build (Development Only)
```bash
flutter run
```
- Larger file size (~100+ MB)
- Slower performance
- Includes debug symbols
- Good for: Testing and development
- **Do NOT distribute**

### Release Build (Production)
```bash
flutter run --release
# OR
flutter build apk --release
```
- Optimized code
- ~40 MB APK file
- Full performance (60 FPS)
- Removed debug symbols
- Good for: Production deployment

### Release Bundle (Google Play Store)
```bash
flutter build appbundle --release
```
- Smaller download (~15-20 MB)
- Splits by device type
-**Required** for Google Play Store
- Good for: Professional distribution

---

## 🚀 Step-by-Step Deployment

### Phase 1: Pre-Release Preparation

#### 1.1 Update Version Numbers

Edit `pubspec.yaml`:
```yaml
version: 1.0.0+1
```

Change from:
- `1.0.0+1` = Initial release
- `1.0.1+2` = Bug fixes
- `1.1.0+3` = New features
- `2.0.0+4` = Major changes

#### 1.2 Check Device Configuration

```bash
flutter doctor
```

Ensure these show ✓:
- ✓ Flutter (version 3.x+)
- ✓ Dart (included with Flutter)
- ✓ Android SDK (level 21+)
- ✓ Android Studio (optional but recommended)

#### 1.3 Run All Tests

```bash
# Analyze code
flutter analyze

# Run the game in release mode
flutter run --release

# Test on multiple devices if possible
flutter devices
```

#### 1.4 Complete Testing Checklist

Follow the checklist in [TESTING.md](TESTING.md):
- ✓ All gameplay features working
- ✓ No crashes
- ✓ Performance acceptable (60 FPS)
- ✓ Audio working (if included)
- ✓ UI displays correctly

### Phase 2: Build Generation

#### 2.1 Clean Build Environment

```bash
flutter clean
flutter pub get
```

This removes old build artifacts.

#### 2.2 Generate Release APK

**Single APK (for all devices):**
```bash
flutter build apk --release
```

**Output:** `build/app/outputs/flutter-apk/app-release.apk`
**Size:** ~40 MB
**Time:** 2-5 minutes

**Split APKs by device (smaller downloads):**
```bash
flutter build apk --split-per-abi --release
```

**Outputs:**
- `app-armeabi-v7a-release.apk` (~25 MB) - 32-bit phones
- `app-arm64-v8a-release.apk` (~30 MB) - 64-bit phones
- `app-x86_64-release.apk` (~30 MB) - Emulators

#### 2.3 Generate Google Play Bundle

**For Google Play Store distribution:**
```bash
flutter build appbundle --release
```

**Output:** `build/app/outputs/bundle/release/app.aab`
**Size:** ~15-20 MB
**Best for:** Professional app store distribution

### Phase 3: Testing Release Build

#### 3.1 Install on Physical Device

```bash
# Install APK on connected device
adb install build/app/outputs/flutter-apk/app-release.apk

# Or use Flutter directly
flutter run --release -d <device-id>
```

Check:
- [ ] App installs successfully
- [ ] Game runs smoothly
- [ ] 60 FPS maintained
- [ ] No crashes
- [ ] Audio works (if present)
- [ ] Controls responsive

#### 3.2 Verify APK

```bash
# Check APK details
aapt dump badging build/app/outputs/flutter-apk/app-release.apk

# Check file size
ls -lh build/app/outputs/flutter-apk/app-release.apk
```

---

## 🏪 Google Play Store Release

### Prerequisites

1. **Google Play Developer Account**
   - Sign up: https://play.google.com/console
   - Cost: One-time $25 USD
   - Takes: ~24-48 hours to activate

2. **App Bundle (AAB file)**
   - Generated via: `flutter build appbundle --release`
   - Location: `build/app/outputs/bundle/release/app.aab`

3. **App Information**
   - App name: "Space Shooter"
   - Description: (write your own)
   - Category: Games → Action
   - Rating: (fill in content rating)

4. **Screenshots**
   - Minimum: 2 screenshots
   - Size: 1080×1920 pixels
   - Format: PNG or JPG
   - Show: Gameplay, score screen

5. **Icon Assets**
   - Icon: 512×512 PNG
   - Feature graphic: 1024×500 PNG
   - Banner: 1280×720 PNG

### Step-by-Step Release

#### Step 1: Create App in Play Console

1. Go to: https://play.google.com/console/
2. Click "Create app"
3. Fill in:
   - App name: "Space Shooter"
   - Default language: English
   - App type: Games
   - Category: Action
4. Accept policies
5. Click "Create"

#### Step 2: Set Up App Content

1. Go to "App content" section
2. Content rating questionnaire:
   - Violence: Select appropriate level
   - Other content: Select if applicable
   - Save to get rating
3. Target audience: Select age range
4. Content privacy policy: Add URL (if you have one)

#### Step 3: Build & Upload Release

1. Go to "Release Manager" → "Production"
2. Click "Create release"
3. Upload AAB file:
   - `build/app/outputs/bundle/release/app.aab`
4. Review and save

#### Step 4: Store Listing

1. Go to "Store listing"
2. Add screenshots:
   - Click "+ Add screenshot"
   - Upload 2-5 gameplay screenshots
3. Add descriptions:
   - Short description: 50 characters max
   - Full description: 4000 characters max
   - What's new: Describe updates
4. Add graphics:
   - Feature image
   - Icon
   - Banner

**Example Description:**
```
Space Shooter is an action-packed arcade game where you 
control a spaceship and defend against incoming enemies. 
Tap to shoot, drag to move, and see how long you can survive!

Features:
- Smooth 60 FPS gameplay
- Engaging mechanics
- Leaderboard tracking
- Optimized for battery life

Destroy enemies, rack up points, and become the ultimate 
space defender. Download now!
```

#### Step 5: Set Pricing & Distribution

1. Go to "Pricing & distribution"
2. Select countries/regions
3. Set price:
   - Free or paid
   - If free: You don't earn money (no ads)
   - If paid: Set price in USD
4. Content restrictions (if any)

#### Step 6: Finalize Release

1. Review all information
2. Click "Save"
3. Click "Review release"
4. Once approved, click "Go to production"
5. **Release goes live in 2-4 hours**

---

## 📈 Post-Release

### Monitor Performance

**In Google Play Console:**
1. **Dashboard** - Overview of metrics
2. **Statistics** - Downloads, ratings, crashes
3. **Ratings** - User reviews and ratings
4. **Analytics** - User behavior, retention
5. **Crashes** - Technical issues reported

### Respond to Reviews

Click on review to respond:
```
Thank you for playing Space Shooter! We're glad you enjoyed it.
We're constantly improving the game. Please let us know if you
have any suggestions for future updates!
```

### Update App

To release new version:
1. Update version in `pubspec.yaml` (e.g., 1.0.1)
2. Build new AAB: `flutter build appbundle --release`
3. Go to Play Console → Release Manager → Production
4. Click "Create release"
5. Upload new AAB
6. Update "What's new" description
7. Review and release

Example update description:
```
Version 1.0.1 Update:
- Fixed collision detection accuracy
- Improved performance on low-end devices
- Added option to disable music
- Bug fixes and stability improvements
```

---

## 📱 Alternative Distribution Methods

### Method 1: Direct APK Distribution
```bash
flutter build apk --release
# Share app-release.apk via:
# - Email
# - Cloud storage (Google Drive)
# - Direct download link
# - QR code
```

**Pros:**
- No approval process
- Instant update
- Full control

**Cons:**
- Higher security risk for users
- No update notifications
- Users must enable "Unknown sources"

### Method 2: GitHub Releases
```bash
# Create GitHub repository
# Upload APK as release artifact
# Users download directly
```

**Pros:**
- Free, open source friendly
- Version history visible
- Easy changelog tracking

**Cons:**
- No update notifications
- Less discoverable
- Requires GitHub account

### Method 3: AppStore (Amazon)
Similar to Google Play but smaller user base.

### Method 4: F-Droid (Open Source)
If you open-source the game:
- Free, open-source app store
- No account/payment needed
- Android-focused

---

## 🔐 Security Checklist

Before releasing publicly:

- [ ] No hardcoded secrets/passwords
- [ ] No debug logging to production
- [ ] No crash dumps sent without permission
- [ ] Privacy policy created (if needed)
- [ ] No personal data collected
- [ ] No tracking without consent
- [ ] App signed with proper certificate

### Generate Signing Key (One time)

```bash
# Generate key
keytool -genkey -v -keystore ~/android_key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias my_key

# Creates: ~/android_key.jks (keep safe!)
```

This is already configured in your Flutter app by default.

---

## 📊 Performance Specification

Verify before release:

| Metric | Target | Status |
|--------|--------|--------|
| APK Size | <50 MB | ✓ ~40 MB |
| Launch Time | <3 sec | ✓ |
| FPS | 60 average | ✓ |
| Memory | <100 MB | ✓ |
| Crashes | <1% | ✓ (test) |
| Battery | Minimal drain | ✓ |

---

## 🐛 Common Release Issues

### Issue: App too large (>50 MB)
**Solution 1:** Remove or compress audio files
```bash
# Check file sizes
du -sh build/app/outputs/flutter-apk/app-release.apk
```

**Solution 2:** Enable code obfuscation
```bash
flutter build apk --obfuscate --split-debug-info=build/debug-info/
```

**Solution 3:** Remove unused dependencies from pubspec.yaml

### Issue: "Signature does not match"
**Solution:**
```bash
flutter clean
flutter pub get
flutter build apk --release
```

### Issue: "App crashes on startup"
**Solution:**
1. Test thoroughly before release
2. Check logs: `adb logcat`
3. Test on multiple Android versions

### Issue: "Low ratings due to performance"
**Solution:**
1. Run in release mode (not debug)
2. Limit max enemies if needed
3. Test on actual devices, not just emulator

---

## 📋 Release Checklist

Before hitting "Publish":

**Code Quality**
- [ ] `flutter analyze` shows 0 issues
- [ ] No compiler warnings
- [ ] Code formatted consistently
- [ ] All imports valid

**Testing**
- [ ] Game runs smoothly (60 FPS)
- [ ] No crashes after 10+ min play
- [ ] All controls working
- [ ] Audio plays (if included)
- [ ] Game over detection working
- [ ] Restart functionality works

**Deployment**
- [ ] Version updated in pubspec.yaml
- [ ] APK/Bundle built successfully
- [ ] File size acceptable (<50 MB)
- [ ] Tested on real device
- [ ] Signing key in place

**Play Store (if publishing)**
- [ ] Play Console account ready
- [ ] Screenshots prepared (2-5)
- [ ] Description written
- [ ] App icon ready (512×512)
- [ ] Content rating completed
- [ ] Privacy policy set
- [ ] Pricing configured

**Documentation**
- [ ] README.md up to date
- [ ] Changelog documented
- [ ] Installation guide accurate
- [ ] Known issues listed

---

## 🎉 After Release

### Day 1-7
- Monitor crash reports
- Respond to early reviews
- Fix critical bugs immediately

### Week 1-4
- Gather user feedback
- Plan improvements
- Test on new devices
- Optimize based on analytics

### Month 1+
- Plan new features
- Monitor retention metrics
- Engage with community
- Regular maintenance updates

---

## Example Release Timeline

```
Monday:    Code complete, version 1.0.0
Tuesday:   Complete testing checklist
Wednesday: Build APK/AAB bundles
Thursday:  Create Play Console listing
Friday:    Submit to Play Store
Monday:    App goes live 🚀
```

---

## Support Links

- **Google Play Console:** https://play.google.com/console
- **Flutter Build Docs:** https://flutter.dev/docs/deployment/android
- **AAB Format:** https://developer.android.com/guide/app-bundle
- **Android Signing:** https://developer.android.com/studio/publish/app-signing

---

## Command Reference

```bash
# Quick build
flutter build apk --release

# Split APK by architecture
flutter build apk --split-per-abi --release

# Google Play Bundle
flutter build appbundle --release

# Check code quality
flutter analyze

# Install on device
adb install build/app/outputs/flutter-apk/app-release.apk

# View device logs
adb logcat | grep flutter

# List connected devices
flutter devices
```

---

## Final Notes

- Use Google Play Store for **widest reach**
- Updates go live in **2-4 hours**
- First release takes **longest** (review process)
- Future updates are **much faster**
- Always **test before releasing**
- Keep user **feedback in mind**

---

**Ready to release? Follow the checklist above and you're good to go!** 🚀

For more info: See [README.md](README.md) and [QUICK_START.md](QUICK_START.md)
