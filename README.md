# Soul Cards

A divination card game built with Flutter, optimized for iOS (iPhone).

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── soul_card.dart       # SoulCard model and Suit enum
│   └── cards_data.dart      # All 18 card definitions
├── screens/                  # Screen widgets
│   ├── landing_screen.dart  # Intro screen
│   └── divination_screen.dart # Main divination experience
├── widgets/                  # Reusable widgets
│   ├── soul_card_widget.dart # Card component
│   ├── card_fan.dart        # Fan layout widget
│   └── card_reveal.dart     # Card reveal with flip animation
├── constants/               # App constants
│   └── app_constants.dart   # Colors, dimensions, iPhone-optimized values
└── utils/                    # Utility classes
    └── fan_calculator.dart   # Fan layout calculations
```

## Features

- ✅ All 18 cards with proper data structure
- ✅ iPhone-optimized viewport calculations
- ✅ Semi-circular fan layout with smooth animations
- ✅ Interactive hover/touch feedback
- ✅ 3D flip animation for card reveal
- ✅ Clean, maintainable, testable codebase
- ✅ State management with setState
- ✅ Responsive design for iPhone viewports

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Xcode (for iOS development)
- iOS Simulator or physical iOS device

### Installation

1. Install Flutter: https://flutter.dev/docs/get-started/install

2. Get dependencies:
```bash
flutter pub get
```

3. Run on iOS simulator or device:
```bash
flutter run
```

## Building for iOS

### Debug Build
```bash
flutter build ios --debug
```

### Release Build
```bash
flutter build ios --release
```

### Build and Open in Xcode
```bash
flutter build ios
open ios/Runner.xcworkspace
```

### Build IPA for Distribution
```bash
flutter build ipa
```

## Testing

Run tests with:
```bash
flutter test
```

## iPhone Optimization

The app is optimized for iPhone viewports:
- Card dimensions: 200x300px (2:3 ratio)
- Fan arc angle: 100 degrees
- Fan radius: calculated dynamically
- All calculations account for iPhone screen dimensions (393x852 for iPhone 14/15 Pro)
