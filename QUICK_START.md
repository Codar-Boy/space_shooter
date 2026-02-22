# Quick Start Guide - Space Shooter

## ⚡ TL;DR - Get Up and Running in 5 Minutes

### 1. Install Dependencies (30 seconds)
```bash
cd space_shooter
flutter pub get
```

### 2. Add Audio Files (Optional - 2 minutes)
If you want sound effects:
- Create `assets/audio/` directory (already done)
- Add 3 MP3 files (or skip if you don't need audio):
  - `background_music.mp3` (any length, will loop)
  - `shoot.mp3` (short firing sound)
  - `hit.mp3` (short impact sound)

**No audio files?** - Game works perfectly fine without them!

### 3. Run the Game (2 minutes)
```bash
# On Android emulator
flutter run

# On physical device (connect via USB first)
flutter run

# For best performance (release mode)
flutter run --release
```

Done! 🎮

---

## 🎮 How to Play

| Action | Control |
|--------|---------|
| **Move** | Drag your finger left or right |
| **Shoot** | Tap the screen anywhere |
| **Restart** | Tap when game ends |

---

## 📊 Game Stats at a Glance

| Metric | Value |
|--------|-------|
| Target FPS | 60 |
| Min Health | 100 HP |
| Damage/Hit | 25 HP |
| Max Enemies | 10 |
| Bullet Cooldown | 0.2 sec |
| Enemy Spawn Rate | 1.5 sec |
| Bullet Speed | 400 px/s |
| Enemy Speed | 100 px/s |
| Player Speed | 300 px/s |

---

## 🤔 Common Questions

### Q: The app crashes on startup
**A:** Run `flutter clean` then `flutter pub get` and try again
```bash
flutter clean
flutter pub get
flutter run
```

### Q: I see "Audio file not found" messages
**A:** That's normal! The game works fine without audio. Add MP3 files to `assets/audio/` if you want sounds.

### Q: Performance is sluggish
**A:** Run in release mode:
```bash
flutter run --release
```

### Q: Low FPS on old device
**A:** Edit `lib/game/game.dart` and change:
```dart
final int maxEnemies = 10;  // Reduce to 5 or 7
```

### Q: How do I build for Google Play?
**A:** 
```bash
flutter build appbundle --release
```
(File will be in `build/app/outputs/bundle/release/`)

---

## 🛠️ Project Structure

```
space_shooter/
├── lib/
│   ├── main.dart           ← App entry point
│   ├── game/
│   │   └── game.dart       ← Game logic
│   ├── components/         ← Player, Enemy, Bullet classes
│   ├── ui/                 ← HUD and UI
│   └── utils/              ← Audio manager
├── assets/
│   ├── audio/              ← Add your MP3 files here
│   └── images/             ← Sprite folder (for future use)
├── pubspec.yaml            ← Dependencies
└── README.md               ← Full documentation
```

---

## 🚀 Performance Tips

✅ **Always use `--release` mode** for real devices
```bash
flutter run --release
```

✅ **Monitor FPS** in DevTools:
```bash
flutter run --profile
```

✅ **Object pooling is enabled** - bullets are reused, not created fresh

✅ **Simple 2D graphics** - efficient canvas drawing, no heavy textures

✅ **Limited enemies** - max 10 at once (configurable)

---

## 📱 Device Requirements

| Requirement | Minimum |
|-------------|---------|
| Android Version | 5.0 (API 21) |
| RAM | 256 MB |
| Storage | ~50 MB |
| FPS Target | 60 |

---

## 🎨 Customization

### Change Colors
Edit render functions in component files:
- Player color: `lib/components/player.dart` → `Colors.cyan`
- Enemy color: `lib/components/enemy.dart` → `Colors.red`
- Bullet color: `lib/components/bullet.dart` → `Colors.yellow`

### Adjust Difficulty
Edit `lib/game/game.dart`:
```dart
// Spawn enemies faster (less = faster)
final double enemySpawnInterval = 1.5;

// More enemies active
final int maxEnemies = 10;
```

### Speed Tweaks
Edit component files:
```dart
// Player movement speed (px/sec)
double moveSpeed = 300;

// Enemy descent speed
double moveSpeed = 100;

// Bullet speed
double moveSpeed = 400;

// Weapon cooldown (lower = faster shooting)
double shootCooldown = 0.2;
```

---

## 🐛 Debugging

### View Console Logs
```bash
flutter logs
```

### Check State
Look for debug prints in:
- Collision detection
- Bullet pool stats
- Enemy spawn events

### Performance Profiler
```bash
flutter run --profile
```

---

## 📦 Building for Release

### Android APK (for direct installation)
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle (for Google Play)
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app.aab`

---

## 🤓 Cool Features Already Built-in

✨ **Object Pooling** - Zero garbage collection during gameplay
✨ **Collision Detection** - Efficient AABB system
✨ **Input Handling** - Tap to shoot, drag to move
✨ **Score System** - +10 per enemy
✨ **Health Bar** - Visual HP indicator
✨ **Game Over Screen** - Restart with one tap
✨ **Audio Support** - Background music + SFX
✨ **Well-Organized Code** - Easy to modify and extend

---

## ✅ What's Working

- ✅ Player movement (drag left/right)
- ✅ Player shooting (tap to fire)
- ✅ Enemy spawning (random positions, every 1.5 sec)
- ✅ Bullet-enemy collision (one shot = one kill)
- ✅ Enemy-player collision (takes damage)
- ✅ Score tracking
- ✅ Health system
- ✅ Game Over detection
- ✅ Restart functionality
- ✅ HUD with score and health bar
- ✅ Audio manager (gracefully handles missing files)
- ✅ Optimized for 60 FPS

---

## 🎯 Next Steps

1. **Run the game**: `flutter run --release`
2. **Add audio** (optional): Put MP3 files in `assets/audio/`
3. **Customize**: Change colors, speeds, difficulty
4. **Build**: `flutter build apk --release`

---

**Enjoy the game! 🚀**

For detailed documentation, see [README.md](README.md)
