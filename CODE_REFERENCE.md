# Code Reference Guide

## Project Organization

```
lib/
├── main.dart              # App entry point, widget tree
├── game/
│   └── game.dart          # Main game logic, state management
├── components/
│   ├── player.dart        # Player entity
│   ├── enemy.dart         # Enemy entity
│   ├── bullet.dart        # Bullet entity + object pool
│   └── collision_detector.dart  # Collision utilities
├── ui/
│   └── hud.dart           # HUD rendering and game over screen
└── utils/
    └── audio_manager.dart # Audio playback controller
```

---

## Core Classes

### main.dart

**MyApp (StatelessWidget)**
- Root widget of the application
- Sets up Material theme
- Navigates to GameScreen

**GameScreen (StatefulWidget)**
- Creates SpaceShooterGame instance
- Wraps game in GameWidget
- Manages Flutter widget lifecycle

---

### game/game.dart

**SpaceShooterGame (FlameGame + HasCollisionDetection)**

Main game controller. Manages:
- Game state (score, health, isGameOver)
- Entity management (players, enemies, bullets)
- Collision detection
- Enemy spawning
- Game loop updates

**Key Properties:**
```dart
int score = 0                    // Current score
int health = 100                 // Player health
bool isGameOver = false          // Game state
int enemyCount = 0               // Active enemy count
final int maxEnemies = 10        // Max simultaneous enemies
final List<Enemy> enemies = []   // Active enemies
final List<Bullet> bullets = []  // Active bullets
final BulletPool bulletPool      // Bullet reuse pool
```

**Key Methods:**
```dart
void update(double dt)           // Main game loop
void _spawnEnemy()               // Create random enemy
void fireBullet(Vector2 pos)     // Player shoots
void _checkCollisions()          // Collision detection
void onTapDown(TapDownEvent e)   // Tap handling
void onDragUpdate(DragUpdateEvent e)  // Drag handling
void restartGame()               // Reset game state
```

**Random Class:**
Simple seeded random number generator. No external dependency needed.
```dart
double nextDouble()              // Returns 0.0-1.0
int nextInt(int max)             // Returns 0 to max
```

---

### components/player.dart

**Player (PositionComponent + CollisionCallbacks)**

Represents the player spaceship.

**Properties:**
```dart
Vector2 position                 // Current position
Vector2 size                     // Player dimensions (30×40)
double moveSpeed = 300           // Movement speed (px/sec)
double moveDirection = 0         // -1, 0, or 1
double shootCooldown = 0.2       // Seconds between shots
double timeSinceLastShot = 0     // Shoot timer
```

**Methods:**
```dart
void update(double dt)           // Update position, timers
void handleDrag(double dx)       // Set movement dir from input
void stopMovement()              // Reset movement direction
void shoot()                     // Fire bullet (if cooldown ready)
void render(Canvas canvas)       // Draw as triangle
Rect toRect()                    // Get collision rectangle
```

**Rendering:**
Draws as cyan triangle (spaceship shape) with white cockpit dot.

---

### components/enemy.dart

**Enemy (PositionComponent + CollisionCallbacks)**

Represents enemy spacecraft.

**Properties:**
```dart
Vector2 position                 // Current position
Vector2 size                     // 30×30 pixels
bool isActive = true             // Can be hit
double moveSpeed = 100           // Descent speed (px/sec)
double rotation = 0              // Rotation angle for effect
```

**Methods:**
```dart
void update(double dt)           // Move down, rotate
void render(Canvas canvas)       // Draw rotating square + eyes
Rect toRect()                    // Get collision rectangle
void deactivate()                // Mark as inactive
```

**Rendering:**
Draws as red rotating square with white "eyes".

---

### components/bullet.dart

**Bullet (PositionComponent + CollisionCallbacks)**

Represents a player projectile.

**Properties:**
```dart
Vector2 position                 // Current position
Vector2 size                     // 5×15 pixels
bool isActive = true             // Can collide
double moveSpeed = 400           // Upward speed (px/sec)
```

**Methods:**
```dart
void update(double dt)           // Move up
void render(Canvas canvas)       // Draw glowing circle
void reset(Vector2 pos)          // Reinitialize from pool
void deactivate()                // Mark inactive (for pool)
Rect toRect()                    // Get collision rectangle
```

**Rendering:**
Draws as yellow circle with glow effect (semi-transparent outer ring).

---

**BulletPool (Object Pool)**

Manages bullet reuse to avoid garbage collection.

**Properties:**
```dart
int capacity                     // Max bullets in pool (default 50)
List<Bullet> _available          // Ready-to-use bullets
List<Bullet> _inUse              // Currently active bullets
```

**Methods:**
```dart
Bullet acquire()                 // Get bullet from pool
void release(Bullet b)           // Return bullet to pool
void clear()                     // Empty pool
Map<String, int> getStats()      // Debug info
```

**How It Works:**
1. Pre-allocates bullets on startup
2. `acquire()` returns a bullet from the available list
3. Game uses the bullet
4. Game calls `release()` to return bullet
5. Bullet is reset and returned to available list
6. **Benefit:** No new object allocations → no garbage collection pauses

---

### components/collision_detector.dart

**CollisionDetector (Static Utility Class)**

Provides collision detection functions.

**Static Methods:**
```dart
// Rectangle collision (AABB)
static bool checkRectCollision(Rect a, Rect b)

// Point-in-rectangle check
static bool checkPointInRect(Offset p, Rect r)

// Distance calculation
static double getDistance(Offset p1, Offset p2)

// Circle collision
static bool checkCircleCollision(Offset c1, double r1, 
                                 Offset c2, double r2)

// Collision depth (overlap amount)
static double getOverlapDepth(Rect a, Rect b)

// Collision response vector
static Offset getCollisionPenetration(Rect a, Rect b)
```

**Note:** Currently only `checkRectCollision` is used in the game, but other functions are available for future enhancements.

---

### ui/hud.dart

**HUD (Component)**

Displays game information and overlays.

**Properties:**
```dart
bool showGameOverScreen = false   // Show game over overlay
late TextPaint scoreTextPaint     // Score text renderer
late TextPaint healthTextPaint    // Health text renderer
late TextPaint gameOverTextPaint  // Game over text renderer
late TextPaint restartTextPaint   // Restart instruction text
```

**Methods:**
```dart
void update(double dt)           // Update text content
void render(Canvas canvas)       // Draw HUD and overlays
void _drawHealthBar(Canvas c)    // Render health bar
void _drawGameOverScreen(Canvas c) // Render game over screen
void showGameOver()              // Enable game over display
void hideGameOver()              // Disable game over display
```

**Rendering Layout:**
```
┌──────────────────────────┐
│ Score: 100   HP: 100     │
│ [████████░░] Health Bar  │
│                          │
│  (Game area)             │
│                          │
└──────────────────────────┘

Game Over Overlay (if active):
┌──────────────────────────┐
│   (Dark overlay 70%)     │
│     GAME OVER            │
│   Final Score: 100       │
│   TAP TO RESTART         │
└──────────────────────────┘
```

---

### utils/audio_manager.dart

**AudioManager (Singleton-like)**

Manages sound and music playback.

**Properties:**
```dart
bool isMuted = false             // Mute toggle
double musicVolume = 0.3         // Background music volume
double sfxVolume = 0.7           // Sound effects volume
```

**Methods:**
```dart
Future<void> init()              // Initialize players
Future<void> playBackgroundMusic() // Start looping music
Future<void> playShootSound()    // Play fire sound
Future<void> playHitSound()      // Play collision sound
Future<void> stopBackgroundMusic() // Stop music
void toggleMute()                // Mute/unmute
Future<void> setMusicVolume(double v) // Set music level
Future<void> setSfxVolume(double v)   // Set SFX level
void dispose()                   // Cleanup resources
```

**Audio Files Required:**
- `assets/audio/background_music.mp3` (looping ambient)
- `assets/audio/shoot.mp3` (0.05-0.2s shooting sound)
- `assets/audio/hit.mp3` (0.1-0.3s impact sound)

**Note:** Game gracefully handles missing audio files (just no sound).

---

## Game Flow Diagram

```
Start App
   ↓
MyApp.build()
   ↓
GameScreen.build()
   ↓
GameWidget(game: SpaceShooterGame)
   ↓
SpaceShooterGame.onLoad()
   ├─ Create Player
   ├─ Create HUD
   ├─ Initialize AudioManager
   └─ Load assets (audio)
   ↓
SpaceShooterGame.update(dt) [60 times/sec]
   ├─ Spawn enemies (1.5s interval)
   ├─ Update player position
   ├─ Update enemy positions
   ├─ Update bullet positions
   ├─ Check collisions
   ├─ Update score/health
   └─ Check game over
   ↓
SpaceShooterGame.render()
   ├─ Player.render() → draw triangle
   ├─ Enemy[].render() → draw squares
   ├─ Bullet[].render() → draw circles
   └─ HUD.render() → draw hud + overlay
   ↓
Input Events
   ├─ onTapDown() → player.shoot()
   ├─ onDragUpdate() → player.handleDrag()
   └─ onDragEnd() → player.stopMovement()
   ↓
Game Over?
   ├─ Yes → HUD.showGameOver() → onTapDown() → restartGame()
   └─ No → Continue loop
```

---

## Data Structures

### Game State
```dart
score: int                       // Cumulative kills × 10
health: int (0-100)              // Current HP
isGameOver: bool                 // Game state
enemyCount: int (0-10)           // Active enemies
enemySpawnTimer: double          // Time since last spawn
timeSinceLastShot: double        // Player cooldown timer
```

### Collision Rect (All entities)
```dart
Rect {
  Offset topLeft              // Upper-left corner position
  double width                // Entity width
  double height               // Entity height
}

// Used with Rect.overlaps(other) for collision detection
```

### Vector2 (Flame)
```dart
Vector2 {
  double x, y                 // 2D position
  
  // Common operations:
  vector.clamp(min, max)      // Constrain value
  vector.distance             // Calculate magnitude
}
```

---

## Key Algorithms

### Collision Detection (AABB)
```dart
// In game.dart _checkCollisions()
for (bullet in bullets) {
  for (enemy in enemies) {
    if (bullet.toRect().overlaps(enemy.toRect())) {
      _onBulletEnemyCollision(bullet, enemy)
    }
  }
}
```
**Complexity:** O(n*m) where n=bullets, m=enemies
**Acceptable** due to small entity counts (max 50 bullets, 10 enemies)

### Enemy Spawning
```dart
// In game.dart update()
enemySpawnTimer += dt
if (enemySpawnTimer >= enemySpawnInterval && 
    enemyCount < maxEnemies) {
  _spawnEnemy()
  enemySpawnTimer = 0
}
```
**Result:** New enemy spawns every 1.5 seconds, up to 10

### Player Movement
```dart
// In player.dart update()
position.x += moveDirection * moveSpeed * dt
position.x = position.x.clamp(size.x/2, 
                              gameRef.size.x - size.x/2)
```
**Result:** Smooth movement at 300 px/sec, constrained to screen

### Bullet Pooling
```dart
// Fire bullet
bullet = bulletPool.acquire()
bullet.reset(playerPos)
add(bullet)
bullets.add(bullet)

// Bullet off-screen
if (bullet.position.y < -10) {
  bullets.remove(bullet)
  bulletPool.release(bullet)
}
```
**Result:** No allocation/deallocation → no GC pauses

---

## Customization Points

### Difficulty (in game.dart)
```dart
final double enemySpawnInterval = 1.5  // Seconds between spawns
final int maxEnemies = 10              // Max simultaneous enemies
```

### Speeds (component files)
```dart
// player.dart
double moveSpeed = 300

// enemy.dart
double moveSpeed = 100

// bullet.dart
double moveSpeed = 400
```

### Weapon
```dart
// player.dart
double shootCooldown = 0.2  // Seconds between shots
```

### Health
```dart
// game.dart
int health = 100            // Starting health
// Damage in _onEnemyPlayerCollision():
health -= 25               // Damage per hit
```

### Colors
```dart
// player.dart
Colors.cyan                 // Player color

// enemy.dart
Colors.red                  // Enemy color

// bullet.dart
Colors.yellow               // Bullet color
```

---

## Performance Considerations

### Memory
- **Player:** 1 instance (40 bytes)
- **Enemies:** Up to 10 (30 bytes each) = 300 bytes
- **Bullets:** Up to 50 in pool (50 bytes each) = 2.5 KB
- **Total:** ~3 KB dynamic entities

### CPU
- **Collision checks:** 50 × 10 = 500 per frame (negligible)
- **Rendering:** 60 canvas draws per frame (efficient)
- **No physics:** Direct transform updates

### Optimization Techniques Used
1. **Object Pooling** - Reuse bullets, avoid GC
2. **Entity Limits** - Max 10 enemies, prevents lag
3. **Simple Graphics** - Canvas 2D, no shaders
4. **Efficient Collision** - AABB, not physics-based
5. **Fixed Update Rate** - 60 FPS target

---

## Extension Points for Future Development

### Add New Enemy Types
1. Create `class FastEnemy extends Enemy`
2. Override `moveSpeed`, `render()`, `health`
3. Add to enemies list in different spawner method

### Add Power-ups
1. Create `class PowerUp extends PositionComponent`
2. Detect collision in _checkCollisions()
3. Apply effect (shield, rapid fire, slow time)

### Add Particles
1. Create `class Particle extends PositionComponent`
2. Emit on bullet-enemy collision
3. Auto-remove when animation complete

### Add 3D Models
1. Import `flutter_cube` model loader
2. Create `class CubeEnemy(Object3D)`
3. Use flutter_cube rendering in game

---

## Debugging Tips

### Check Entity Counts
```dart
print('Enemies: ${gameRef.enemyCount}');
print('Bullets: ${gameRef.bullets.length}');
print('Pool stats: ${gameRef.bulletPool.getStats()}');
```

### Monitor Performance
```bash
flutter run --profile
# Check DevTools for FPS, memory, CPU
```

### View Logs
```bash
flutter logs
# Check for audio errors, collision info, etc.
```

### Pause and Inspect
```dart
// In game.dart update():
if (gameRef.enemies.isEmpty) {
  print('All enemies cleared');
}
```

---

## Common Errors & Solutions

### "Vector2 not found"
**Solution:** Add import:
```dart
import 'package:vector_math/vector_math_64.dart' show Vector2;
```

### "Game not responding"
**Cause:** Infinite loop in update()
**Solution:** Add `isGameOver` check to stop updates

### "Audio file not found"
**Cause:** Missing MP3 in assets/audio/
**Solution:** Add files or game continues without audio

### "Touch input not working"
**Cause:** Missing event handlers
**Solution:** Ensure `onTapDown()` and `onDragUpdate()` are implemented

### "Low FPS"
**Cause:** Too many entities or complex rendering
**Solution:** Reduce `maxEnemies`, run `--release` mode

---

This guide should help you understand and modify the codebase. Happy coding! 🎮
