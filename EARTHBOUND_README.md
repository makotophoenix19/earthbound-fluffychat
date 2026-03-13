# Earthbound Theme for FluffyChat

An Earthbound (Mother 2) inspired theme for FluffyChat - the open source Matrix client.

## Features

- **Authentic Earthbound Color Palette** - Warm Memphis design colors
  - Cream background (#FCEEB4)
  - Orange CTB text boxes (#FF6B35)
  - Bubblegum pink received bubbles (#FF9EAA)
  - Sky blue sent bubbles (#64B5F6)
  - Kelly green accents (#7CB342)
  - Golden yellow stars (#FFD93D)

- **Custom Chat Bubbles** - Wavy, hand-drawn style borders inspired by Earthbound's text boxes

- **Star Patterns** - Subtle star decorations in backgrounds

- **PSI Flash Effects** - Purple flash effects for notifications (inspired by PSI powers)

- **Earthbound UI Elements** - Custom buttons, text boxes, and decorations

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/fluffychat.git
   cd fluffychat
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Enabling the Earthbound Theme

The theme files are already included:
- `lib/config/themes.dart` - Contains `buildEarthboundTheme()` 
- `lib/widgets/earthbound_theme.dart` - Custom widgets and decorations

To enable the Earthbound theme in the app:

### Option 1: Use in your app
```dart
import 'package:fluffychat/config/themes.dart';

// In your theme selection UI:
ThemeData earthboundLight = FluffyThemes.buildEarthboundTheme(context, Brightness.light);
ThemeData earthboundDark = FluffyThemes.buildEarthboundTheme(context, Brightness.dark);
```

### Option 2: Use custom bubble widgets
```dart
import 'package:fluffychat/widgets/earthbound_theme.dart';

// Wrap your chat messages:
EarthboundChatBubble(
  isSent: true, // or false for received
  child: Text("Your message here"),
)
```

## Font Options

The theme supports multiple font options:

- **Pixel fonts** (original Earthbound vibe):
  - VT323 (Google Fonts) - closest to game text
  - Press Start 2P - more 8-bit
  - Silkscreen - cleaner pixel look

- **Modern readable**:
  - Nunito (default) - rounded, friendly
  - Poppins - geometric, matches Memphis

To change fonts, add to your `pubspec.yaml`:
```yaml
dependencies:
  google_fonts: ^6.1.0
```

Then in your theme:
```dart
fontFamily: 'VT323', // or any preferred font
```

## Project Structure

```
lib/
├── config/
│   └── themes.dart          # Theme definitions (including Earthbound)
├── widgets/
│   └── earthbound_theme.dart # Custom Earthbound widgets
└── pages/
    └── chat/
        └── events/
            └── message.dart  # Chat bubble rendering
```

## Customization

### Colors
Edit `EarthboundColors` class in `lib/config/themes.dart`:
```dart
class EarthboundColors {
  static const Color background = Color(0xFFFCEEB4);
  static const Color primary = Color(0xFFFF6B35);
  // ... etc
}
```

### Bubble Style
Edit `EarthboundBubbleDecoration` in `lib/widgets/earthbound_theme.dart` for different bubble shapes.

## Screenshots

(Add screenshots here showing the Earthbound theme in action)

## Credits

- **FluffyChat** - https://github.com/krille-chan/fluffychat
- **Earthbound/Mother 2** - Game by Shigesato Itoi / Nintendo
- **Memphis Design** - 1980s design movement that inspired Earthbound's UI

## License

Same as FluffyChat - AGPLv3

---

🧀 *Your name will not be forgotten.* 🧀
