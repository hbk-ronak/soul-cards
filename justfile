# Soul Cards - Flutter App Commands

# Default command - show available commands
default:
    @just --list

# Run the app in debug mode
run:
    flutter run

# Run the app in release mode
run-release:
    flutter run --release

# Run on iOS simulator
run-ios:
    flutter run -d ios

# Run on Android emulator
run-android:
    flutter run -d android

# Run on a specific device (use `just run-device <device-id>`)
run-device device:
    flutter run -d {{device}}

# List available devices
devices:
    flutter devices

# Get dependencies
deps:
    flutter pub get

# Update dependencies
deps-update:
    flutter pub upgrade

# Run tests
test:
    flutter test

# Run tests with coverage
test-coverage:
    flutter test --coverage

# Analyze code
analyze:
    flutter analyze

# Format code
format:
    flutter format .

# Format and analyze
check:
    flutter format .
    flutter analyze

# Clean build files
clean:
    flutter clean

# Clean and get dependencies
clean-deps:
    flutter clean
    flutter pub get

# Build iOS app
build-ios:
    flutter build ios

# Build iOS app (release)
build-ios-release:
    flutter build ios --release

# Build Android app
build-android:
    flutter build apk

# Build Android app (release)
build-android-release:
    flutter build apk --release

# Build Android app bundle (for Play Store)
build-android-bundle:
    flutter build appbundle --release

# Watch for changes and hot reload
watch:
    flutter run --hot

# Show Flutter doctor information
doctor:
    flutter doctor

# Show Flutter version
version:
    flutter --version

# Run with verbose output
run-verbose:
    flutter run -v

# Build for web
build-web:
    flutter build web

# Run on web
run-web:
    flutter run -d chrome
