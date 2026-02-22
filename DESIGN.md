# Game Design Document

## Overview
Space Shooter is a lightweight 2D mobile arcade game where players defend against incoming enemy spacecraft using timed shots and movement.

## Game Concept

### Genre
Action / Arcade Shooter

### Target Audience
Casual mobile gamers, all ages

### Platform
Android Mobile (iOS compatible)

### Target Performance
- 60 FPS on mid-range devices
- 45+ FPS on low-end devices
- File size < 50MB

---

## Core Gameplay

### Objective
Survive as long as possible by destroying enemies before they reach you.

### Victory Condition
No formal win state - game continues indefinitely with increasing difficulty (optional enhancement).

### Failure Condition
Health reaches 0 HP.

### Session Length
1-10 minutes per game session

---

## Game Mechanics

### Player
- **Character:** Cyan triangle spaceship
- **Health:** 100 HP
- **Position:** Bottom center of screen
- **Controls:** Drag to move, tap to shoot

**Weapon:**
- Fires small yellow bullets upward
- Cooldown: 0.2 seconds between shots
- Speed: 400 pixels/second
- Damage: 1 shot = 1 enemy kill
- Maximum bullets in flight: 50 (object pool)

**Movement:**
- Speed: 300 pixels/second
- Constrained to screen width
- Smooth drag-based input

### Enemies
- **Appearance:** Red rotating squares with eyes
- **Speed:** 100 pixels/second (downward)
- **Health:** 1 HP (one-shot kills)
- **Spawn Rate:** Every 1.5 seconds
- **Max Active:** 10 enemies
- **Despawn:** Automatically removed when off-screen

**Behavior:**
- Descend steadily
- Rotate for visual effect
- No AI (no targeting)
- Random spawn positions

**Collision:**
- Player takes 25 HP damage on collision
- Enemy is destroyed on collision with player
- Enemy is destroyed on bullet collision

### Bullets
- **Appearance:** Small yellow glowing circles
- **Speed:** 400 pixels/second (upward)
- **Size:** 5×15 pixels
- **Disappear:** When off-screen (top)
- **Reuse:** Object pooling system

### Scoring
```
Enemy Destroyed: +10 points
Accuracy: N/A (no penalty for missing)
Bonuses: None (potential future feature)
```

---

## Game States

### START
- HUD displays
- Player at center bottom
- Ready for input

### PLAYING
- Enemies spawn
- Player can move and shoot
- Score updates in real-time
- Health displayed with bar

### GAME_OVER
- All movement stops
- Dark overlay appears
- Final score displayed
- "TAP TO RESTART" instruction

### PAUSE
- Not implemented (future feature)

---

## User Interface

### HUD Elements

**Score Display**
- Location: Top-left
- Font: Bold, 28px
- Color: White
- Updates: Real-time

**Health Bar**
- Location: Top-left (below score)
- Size: 150×20 pixels
- Color: Green (healthy) → Red (low)
- Shows: Current HP / Max HP

**Health Text**
- Location: Top-right
- Font: Bold, 24px
- Color: Green/Red (changes with health)
- Format: "HP: 100"

**Game Over Screen**
- Dark semi-transparent overlay
- "GAME OVER" title (56px, white)
- Final score display (32px, yellow)
- "TAP TO RESTART" instruction (28px, cyan)

---

## Input System

### Touch Controls

| Input | Action | Response |
|-------|--------|----------|
| Drag Left/Right | Move player | 300 px/s movement |
| Tap | Shoot bullet | Fire with 0.2s cooldown |
| Tap (Paused) | Unpause | Resume game |
| Tap (Game Over) | Restart | Reset game state |

### Input Handling
- Continuous drag updates
- Tap detection with threshold
- Drag sensitivity: 10+ pixels

---

## Technical Specifications

### Graphics
- **Rendering:** Canvas 2D (flat shapes)
- **No 3D Models:** Uses simple geometric shapes
- **Color Palette:** Cyan, Red, Yellow, White
- **Anti-aliasing:** Default Canvas rendering

### Audio
- **Background Music:** Looping, 0.3 volume
- **Shoot Sound:** 0.7 volume, ~0.1s duration
- **Hit Sound:** 0.7 volume, impact effect
- **Volume Control:** Unified manager with mute

### Physics
- **Gravity:** None
- **Collision:** AABB (Axis-Aligned Bounding Box)
- **Velocity:** Linear, no acceleration
- **Constraints:** Screen bounds for player only

### Performance
- **Collision Detection:** O(n*m) checks (acceptable for entity count)
- **Rendering:** Single pass, batched draw calls
- **Memory:** Object pooling prevents GC hitches
- **FPS Target:** 60 FPS constant

---

## Game Balance

### Difficulty Curve
- **Initial:** 1 enemy every 1.5s (manageable)
- **Mid-game:** Player adjusts aim and positioning
- **End-game:** Screen may fill with enemies (10 max)
- **Challenge:** Accuracy and reaction time

### Tuning Parameters
```dart
// Player
moveSpeed: 300 px/sec
shootCooldown: 0.2 sec

// Enemy
enemySpeed: 100 px/sec
enemySpawnInterval: 1.5 sec
maxEnemies: 10

// Bullet
bulletSpeed: 400 px/sec

// Health
startingHealth: 100 HP
damagePerHit: 25 HP
```

### Balancing Decisions
- **Score:** +10 per enemy (simple, addictive)
- **Health:** 100 HP allows 4 hits (forgiving)
- **Cooldown:** 0.2s allows rapid fire
- **Enemy Spawn:** 1.5s ramp-up is gradual
- **Max Enemies:** 10 prevents lag

---

## Asset Requirements

### Audio Files
1. **background_music.mp3**
   - Length: 30-120 seconds
   - Loop: Yes
   - Style: Ambient, electronic, arcade

2. **shoot.mp3**
   - Duration: 0.05-0.2 seconds
   - Volume: Bright, punchy
   - Style: Laser-like

3. **hit.mp3**
   - Duration: 0.1-0.3 seconds
   - Volume: Satisfying, impact
   - Style: Electronic explosion/beep

### Visual Assets
- Currently: No external sprites (all drawn in code)
- Future: Low-poly 3D models (flutter_cube ready)

---

## Software Architecture

### Component System
```
Game (FlameGame)
├── Player (PositionComponent)
├── Enemy[] (PositionComponent)
├── Bullet[] (PositionComponent)
└── HUD (Component)
```

### Object Pooling
```
BulletPool
├── Available: []
└── In-use: []
```

### Collision Detection
```
AABB Checker
├── Bullet vs Enemy
└── Enemy vs Player
```

---

## Performance Optimization

### Implemented
- ✅ Object pooling (bullets)
- ✅ Efficient collision detection (AABB)
- ✅ Limited entities (max 10 enemies)
- ✅ Simple 2D graphics
- ✅ Canvas drawing (no heavy frameworks)

### Potential Improvements
- Spatial partitioning (quad-tree) for large enemy counts
- Sprite atlasing if textures added
- Particle effects system
- Touch feedback (haptics)
- Dynamic difficulty scaling

---

## Monetization (Optional)
Not implemented, but considerations:
- Ad placement: Between games
- In-app purchases: Cosmetics, skins
- Premium: Ad-free version

---

## Future Enhancements

### Gameplay
- Multiple enemy types
- Boss encounters
- Power-ups
- Wave system
- Difficulty levels

### Graphics
- Particle effects
- Enemy explosions
- Player trail effects
- Shader effects

### Audio
- Sound variations
- Music intensity scaling
- Procedural sfx

### Social
- Leaderboards
- Achievements
- Replay sharing
- Multiplayer (future)

---

## Test Scenarios

### Gameplay
- [ ] Player moves left/right smoothly
- [ ] Bullets fire with correct cooldown
- [ ] Enemies spawn at random X positions
- [ ] Bullets destroy enemies
- [ ] Enemies damage player
- [ ] Score increases on kills
- [ ] Health decreases on enemy hit
- [ ] Game over at 0 HP
- [ ] Restart works correctly

### Performance
- [ ] Maintains 60 FPS
- [ ] No jank on enemy spawn
- [ ] Smooth scrolling
- [ ] No GC hitches
- [ ] Low memory usage

### Edge Cases
- [ ] Multiple enemies on screen
- [ ] Rapid firing
- [ ] Enemies off-screen
- [ ] Bullets off-screen
- [ ] Game over and restart loop

---

## Success Metrics
- Launch day: Functional game
- User retention: >30% day-1 return
- Performance: 60 FPS average
- Bug rate: <1% crash rate

---

This document serves as the blueprint for current and future development.
