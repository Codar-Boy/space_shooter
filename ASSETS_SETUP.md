# Asset Setup Guide

Complete guide for adding audio and visual assets to Space Shooter.

---

## 📁 Asset Folders

The project has two asset directories:

```
assets/
├── audio/          ← Audio files go here
└── images/         ← Sprites and graphics go here (for future use)
```

Both folders are already configured in `pubspec.yaml`.

---

## 🎵 Audio Assets

### Required Audio Files

The game expects **3 MP3 audio files** in `assets/audio/`:

#### 1. background_music.mp3
- **Purpose:** Looping background music
- **Duration:** 30-120 seconds
- **When Plays:** At game startup, loops until game over
- **Volume:** Set to 30% (configurable in AudioManager)
- **Style:** Ambient, electronic, arcade-style recommended

#### 2. shoot.mp3
- **Purpose:** Firing sound effect
- **Duration:** 0.05-0.2 seconds
- **When Plays:** Every time player shoots
- **Volume:** Set to 70% (loud and punchy)
- **Style:** Laser beam, bright beep, or chiptune recommended

#### 3. hit.mp3
- **Purpose:** Collision/damage sound effect
- **Duration:** 0.1-0.3 seconds
- **When Plays:** When bullet hits enemy, when enemy hits player
- **Volume:** Set to 70%
- **Style:** Electronic explosion, impact beep, or crash recommended

### Audio File Specifications

| Property | Requirement |
|----------|------------|
| **Format** | MP3 (AAC also works) |
| **Stereo** | Mono or Stereo (mono is smaller) |
| **Bitrate** | 128 kbps minimum, 192 kbps recommended |
| **Sample Rate** | 44100 Hz (44.1 kHz) standard |
| **Size per file** | <1 MB (1-4 minute total audio) |

### How to Get Audio Files

#### Option 1: Download Royalty-Free Audio ⭐ Recommended
**Easiest method - no account needed:**

1. **Freesound.org**
   - Visit: https://freesound.org/search/
   - Search: "arcade shooting sound", "ambient electronic", "laser"
   - Download: Look for "Creative Commons" licensed files
   - Format: Download as MP3 if available

2. **Zapsplat.com**
   - Visit: https://www.zapsplat.com/sound-effects/
   - Search: "sci-fi", "electronic", "game effects"
   - Download: Usually MP3, very high quality

3. **Pixabay Sound**
   - Visit: https://pixabay.com/sound/
   - Search: "retro", "laser", "ambient"
   - Download: Completely free, no attribution required

4. **FreePD.com**
   - Visit: https://freeplayground.com/
   - Search: "arcade", "electronic"
   - Download: Free CC0 licensed music

#### Option 2: Create Your Own Audio 🎹
Using **Audacity** (free, open-source):

1. **Download Audacity:** https://www.audacityteam.org/
2. **Create simple sounds:**
   - Generate tone (for shooting): Generate → Tone
   - Generate noise (for hit): Generate → Noise
   - Use built-in effects: Echo, Filter, Equalization
3. **Export as MP3:**
   - File → Export → Export as MP3
   - Quality: 192 kbps
   - Save to `assets/audio/`

**Simple Sound Ideas:**
- **Shoot:** Pure sine wave tone (440-880 Hz, 0.1s, with slight fade)
- **Hit:** White noise burst (0.2s, with echo effect)
- **Background:** Low ambient drone with slight modulation

#### Option 3: Use Online Generators 🎸
1. **Chiptone:** https://sfbgames.itch.io/chiptone
   - Generate 8-bit style sounds
   - Export as MP3
   - Great for retro arcade feel

2. **BFXR:** https://www.bfxr.net/
   - Classic game sound generator
   - Perfect for laser sounds
   - Export and convert to MP3

#### Option 4: Purchase Music 💰 (Optional)
- **AudioJungle:** https://audiojungle.net/
- **Shutterstock Music:** https://music.shutterstock.com/
- **Epidemic Sound:** https://www.epidemicsound.com/

---

## 📝 Installation Steps

### Step 1: Download/Create Audio Files
Follow one of the options above to get:
- `background_music.mp3`
- `shoot.mp3`
- `hit.mp3`

### Step 2: Place Files in Project
```
space_shooter/
└── assets/
    └── audio/
        ├── background_music.mp3  ← Place here
        ├── shoot.mp3             ← Place here
        └── hit.mp3               ← Place here
```

### Step 3: Verify pubspec.yaml
Ensure `assets/audio/` is registered (it should be):

```yaml
flutter:
  uses-material-design: true
  
  assets:
    - assets/images/
    - assets/audio/
```

### Step 4: Run the Game
```bash
flutter run --release
```

Audio should play automatically! 🎵

---

## 🖼️ Visual Assets (Optional - Future Features)

The `assets/images/` folder is ready for:
- Custom player sprites
- Enemy graphics
- Particle effects
- Background images
- UI badges/medals

**Current state:** All graphics drawn via code (optimized)

To add sprites in the future:
1. Place PNG files in `assets/images/`
2. Add to pubspec.yaml assets list
3. Load in code using `Sprite.load()` from Flame

Example:
```dart
final sprite = await Sprite.load('my_image.png');
sprite.paint();
```

---

## 🔧 Audio Configuration

### Adjust Audio Levels

Edit **lib/utils/audio_manager.dart**:

```dart
class AudioManager {
  // Change these values (0.0 to 1.0)
  double musicVolume = 0.3      // Background music (lower = quieter)
  double sfxVolume = 0.7        // Sound effects (0.7 = louder)
}
```

Examples:
- `musicVolume = 0.0` → Silent background
- `musicVolume = 0.5` → Medium volume
- `musicVolume = 1.0` → Full volume
- `sfxVolume = 0.3` → Subtle sound effects
- `sfxVolume = 1.0` → Loud sound effects

### Test Audio Levels
After placing audio files:
```bash
flutter run --release
```

Adjust volumes in AudioManager if needed.

---

## ❓ Troubleshooting Audio

### "Audio file not found" message
**Cause:** File not in correct location  
**Solution:**
1. Check file is in `assets/audio/` (not nested directory)
2. Check filename matches exactly (case-sensitive on Linux):
   - `background_music.mp3` ✅
   - `Background_Music.mp3` ❌ (wrong case)
3. Rebuild: `flutter clean && flutter run`

### Audio doesn't play
**Cause:** File format or codec issue  
**Solution:**
1. Convert to MP3: Use Audacity or Handbrake
2. Check bitrate: 128-192 kbps recommended
3. Test in different emulator/device
4. Check volume levels aren't 0

### Audio is distorted/crackles
**Cause:** Bitrate too low or encoding issue  
**Solution:**
1. Re-export at 192 kbps or higher
2. Use AAC codec instead (better quality at lower bitrate)
3. Add audio editing software processing (normalization)

### Only one sound plays
**Cause:** Multiple sounds can't play simultaneously  
**Solution:**
1. AudioManager uses separate players for music and SFX
2. Game designed to support both looping music + SFX
3. If SFX overlap, only latest plays (normal behavior)

### App too large now
**Cause:** Large audio files  
**Solution:**
1. Reduce audio bitrate to 128 kbps
2. Shorten music duration
3. Use compressed AAC format instead
4. Trim silence from sound effects

---

## 📊 File Size Guide

Typical audio file sizes:

| Type | Duration | Size |
|------|----------|------|
| Background music | 60 sec | 600 KB - 1 MB |
| Shoot sound | 0.1 sec | 10-20 KB |
| Hit sound | 0.2 sec | 20-30 KB |
| | **Total Max** | **1.1 MB** |

Game APK size breakdown:
- Flutter runtime: ~20 MB
- Game code: ~2 MB
- Audio: ~1 MB (max)
- Other: ~2 MB
- **Total:** ~25 MB (release APK)

---

## 🎵 Audio Format Reference

### MP3 Encoding (Recommended)
```
Format: MP3 (MPEG-3)
Codec: libmp3lame
Bitrate: 192 kbps (quality) or 128 kbps (size)
Sample Rate: 44100 Hz
Channels: Mono or Stereo
```

### AAC Encoding (Alternative)
```
Format: AAC (Advanced Audio Coding)
Codec: AAC
Bitrate: 128 kbps (small size, good quality)
Sample Rate: 44100 Hz
Channels: Mono or Stereo
```

### WAV (Too Large - Avoid)
```
Format: WAV (uncompressed)
Size: Much larger than MP3/AAC
Only for sound design, convert before deployment
```

---

## 🛠️ Tools Reference

### Audio Conversion/Editing

**Audacity** (Free, open-source)
- https://www.audacityteam.org/
- Recording, editing, effects
- Export to MP3, AAC, WAV
- Perfect for creating custom sounds

**Handbrake** (Free, open-source)
- https://handbrake.fr/
- Convert video audio to MP3
- Batch processing
- Good quality, small files

**FFmpeg** (Free, command-line)
- https://ffmpeg.org/
- Professional audio conversion
- Powerful batch processing
- Example: `ffmpeg -i input.wav -b:a 192k output.mp3`

**Online Converters**
- https://online-audio-converter.com/
- https://cloudconvert.com/
- No installation needed
- Good for one-off conversions

---

## ✅ Quick Checklist

Before launching with audio:

- [ ] Three MP3 files created/downloaded
- [ ] Files are in `assets/audio/` folder
- [ ] Filenames are:
  - [ ] `background_music.mp3`
  - [ ] `shoot.mp3`
  - [ ] `hit.mp3`
- [ ] pubspec.yaml includes `assets/audio/`
- [ ] Game runs without errors: `flutter run --release`
- [ ] Audio plays during gameplay
- [ ] Volume levels are appropriate
- [ ] APK size acceptable (<50 MB)

---

## Next Steps

1. **Get audio files** (download or create)
2. **Place in `assets/audio/`** folder
3. **Run game:** `flutter run --release`
4. **Test audio** during gameplay
5. **Adjust volumes** if needed (AudioManager)
6. **Build APK:** `flutter build apk --release`
7. **Deploy!** 🚀

---

## Audio Not Required!

The game is **fully functional without audio**. If you don't add audio files:
- No error messages
- Game runs normally
- No sounds, just silent gameplay
- Slightly smaller APK size

Feel free to skip this step and add audio later! 🎮

---

For more information:
- See [README.md](README.md) for overview
- See [QUICK_START.md](QUICK_START.md) to start playing
- See [CODE_REFERENCE.md](CODE_REFERENCE.md) for audio code details
