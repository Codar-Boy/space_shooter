# Space Shooter - 3D Mobile Game

A lightweight, high-performance 3D shooting game built with Flutter and Flame.

## Project Overview

- **Engine**: Flutter + Flame 2D Game Framework
- **Platform**: Android (iOS compatible)
- **Target FPS**: 60 FPS
- **Graphics**: Low-poly, minimalist design
- **Architecture Pattern**: Component-based entity system

## Features

✅ Player spaceship with touch controls
✅ Random enemy spawning (max 10 active)
✅ Bullet firing with cooldown system
✅ Collision detection (bullets vs enemies, enemies vs player)
✅ Score tracking system
✅ Health system with visual health bar
✅ Game Over screen with restart functionality
✅ Audio support (background music + SFX)
✅ Object pooling for performance optimization
✅ Responsive HUD with real-time updates

## Project Structure

```
space_shooter/
├── lib/
│   ├── main.dart                          # App entry point
│   ├── game/
│   │   └── game.dart                      # Main game controller
│   ├── components/
│   │   ├── player.dart                    # Player spaceship
│   │   ├── enemy.dart                     # Enemy entities
│   │   ├── bullet.dart                    # Projectiles + object pool
│   │   └── collision_detector.dart        # Collision utilities
│   ├── ui/
│   │   └── hud.dart                       # HUD and game over screen
│   └── utils/
│       └── audio_manager.dart             # Sound effects handler
├── assets/
│   ├── audio/
│   │   ├── background_music.mp3           # (Add your file)
│   │   ├── shoot.mp3                      # (Add your file)
│   │   └── hit.mp3                        # (Add your file)
│   └── images/
│       └── (placeholder for sprites)
└── pubspec.yaml                           # Dependencies
```

## Technical Stack

### Dependencies
- **flame 1.10.0** - 2D game framework
- **flutter_cube 0.0.5** - 3D cube rendering (optional)
- **audioplayers 5.2.1** - Audio playback
- **vector_math 2.1.4** - Math operations

### Game Architecture

#### Components
- **Player**: Triangle spaceship, drag-to-move control, tap-to-shoot
- **Enemy**: Rotating squares that descend, max 10 active
- **Bullet**: Small circular projectiles with glow effect
- **HUD**: Score display, health bar, game over overlay

#### Systems
- **Collision Detection**: Rectangle-based AABB (Axis-Aligned Bounding Box)
- **Object Pooling**: Pre-allocated bullets for 0-GC performance
- **Enemy Spawning**: Random X position, 1.5 second intervals
- **Audio Management**: Separate channels for music and SFX

## Installation & Setup

### Prerequisites
- Flutter SDK >= 3.0.0
- Android Studio / Xcode
- Device emulator or physical device

### Step 1: Install Flutter Dependencies

```bash
cd space_shooter
flutter pub get
```

### Step 2: Add Audio Files

The game expects audio files in `assets/audio/`:
- `background_music.mp3` (looping ambient track)
- `shoot.mp3` (firing sound effect)
- `hit.mp3` (collision/damage sound)

**Options to get audio:**
1. Create simple MP3 files using free tools like Audacity
2. Download royalty-free sounds from:
   - freesound.org
   - zapsplat.com
   - pixabay.com/sound
3. Use placeholder silence (optional - game works without audio)

Create the files in `assets/audio/` or the game will gracefully skip missing audio.

### Step 3: Run the Game

**On Android Emulator:**
```bash
flutter run -d <emulator-name>
```

**On Physical Device:**
```bash
# Connect device via USB
flutter run
```

**On Release Mode (Better Performance):**
```bash
flutter run --release
```

## Controls

| Action | Input |
|--------|-------|
| **Move Left/Right** | Drag left/right on screen |
| **Shoot** | Tap on screen |
| **Restart (Game Over)** | Tap on screen |

## Game Mechanics

### Scoring
- Hit enemy: +10 points
- Survive longer: continuous score multiplier possible (future feature)

### Health System
- Starting Health: 100 HP
- Damage per hit: 25 HP
- Visual indicator: Green (high) → Red (low)
- Game Over: When health reaches 0 HP

### Enemy Spawning
- Spawn rate: Every 1.5 seconds
- Max active: 10 enemies
- Movement: Continuous downward at 100 px/sec
- Despawn: Falls off bottom of screen

### Bullet System
- Damage: 1 hit = 1 kill
- Movement: 400 px/sec upward
- Cooldown: 0.2 seconds between shots
- Pool size: 50 pre-allocated bullets

## Performance Optimizations

### Implemented
✓ **Object Pooling** - Reusable bullet pool (no garbage collection)
✓ **Collision Detection** - Efficient AABB (no physics engine overhead)
✓ **Simple Graphics** - Canvas drawing instead of heavy textures
✓ **Limited Entities** - Max 10 enemies at once
✓ **No Physics Engine** - Direct transform updates
✓ **Audio Volume Control** - Low-load playback

### Optimization Tips
- Run in `--release` mode for production
- Target 60 FPS (monitor in DevTools)
- Keep enemy pool size appropriate for device
- Consider reducing `maxEnemies` on low-end devices

## Debug Information

### View Logs
```bash
flutter logs
```

### Check Performance
```bash
flutter run --enable-impeller  # Better graphics performance
```

### Bullet Pool Stats
Check `BulletPool.getStats()` to monitor:
- Available bullets
- In-use bullets
- Pool capacity

## Customization

### Change Game Parameters
Edit values in **lib/game/game.dart**:

```dart
// Enemy spawn interval (seconds)
final double enemySpawnInterval = 1.5;

// Maximum active enemies
final int maxEnemies = 10;

// Player movement speed
double moveSpeed = 300; // px/sec
```

Edit in **lib/components/player.dart**:
```dart
double shootCooldown = 0.2; // seconds between shots
double moveSpeed = 300;     // player movement speed
```

Edit in **lib/components/enemy.dart**:
```dart
double moveSpeed = 100; // enemy descent speed
```

### Color Scheme
Update colors in render functions:
- **Player**: `Colors.cyan` (player.dart)
- **Enemy**: `Colors.red` (enemy.dart)
- **Bullet**: `Colors.yellow` (bullet.dart)

## Troubleshooting

### Issue: "Audio file not found"
**Solution**: The game gracefully skips missing audio. Add files to `assets/audio/` as needed.

### Issue: Low FPS on low-end devices
**Solution**: 
- Reduce `maxEnemies` from 10 to 5-7
- Disable visual effects (remove glow from bullets)
- Run with `--release` flag

### Issue: Touch input not responsive
**Solution**: Ensure `onTapDown`, `onDragUpdate`, `onDragEnd` are properly implemented in game.dart

### Issue: Compile errors
**Solution**: 
```bash
flutter clean
flutter pub get
flutter run
```

## Build for Release

### Android APK
```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle (Google Play)
```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

## Code Quality

### File Organization
- **game/** - Game loop and state management
- **components/** - Game entities and logic
- **ui/** - User interface elements
- **utils/** - Helper classes (audio, etc.)

### Comments
All major functions and classes include documentation comments.

### Best Practices
✓ Component-based architecture
✓ Separation of concerns
✓ Object pooling for performance
✓ Input event handling
✓ Error handling for missing assets

## Future Enhancement Ideas

- ✨ Multiple enemy types
- ✨ Power-up system
- ✨ Boss encounters
- ✨ Level progression
- ✨ Leaderboard/High scores
- ✨ Particle effects
- ✨ 3D models (with flutter_cube)
- ✨ Touch haptic feedback
- ✨ Pause functionality
- ✨ Settings screen

## License

This project is open source and available under the MIT License.

## Support

For issues or questions:
1. Check Flutter documentation: flutter.dev
2. Flame documentation: flame-engine.org
3. Run `flutter doctor` to diagnose issues

---

**Ready to play? Follow the Installation & Setup section above!**
