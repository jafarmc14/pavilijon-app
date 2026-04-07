# Pavilijon App

Flutter application for a premium coffee experience with an editorial visual style.

## Current Scope

The project currently includes:

- Animated splash screen with coffee cup artwork, steam animation, ripple effect, and automatic startup flow
- Home screen inspired by the provided design reference
- Terms & Conditions screen that opens from the bottom section of the home screen
- Bottom navigation shell for `Home`, `Store`, `Grab & Go`, and `Track`

## Main Flow

1. App opens to the splash screen
2. Splash simulates initial data loading and configuration checking
3. App navigates automatically to the home screen
4. User can open `Terms & Conditions (Regulamin)` from the home screen
5. User can return from the terms screen by tapping `Home` in the bottom navigation

## Tech Notes

- Built with Flutter and Material 3
- Uses only local Flutter widgets and custom painting
- No external image assets are required for the current UI
- Main implementation is currently centered in `lib/main.dart`

## Project Structure

Key files:

- [lib/main.dart](d:\pavilijonApp\pavilijon_app\lib\main.dart)
- [test/widget_test.dart](d:\pavilijonApp\pavilijon_app\test\widget_test.dart)
- [pubspec.yaml](d:\pavilijonApp\pavilijon_app\pubspec.yaml)

## Run The App

```bash
flutter pub get
flutter run
```

## Run Tests

```bash
flutter test
```

## Status

Current state of the project:

- Splash flow is implemented
- Home screen UI is implemented with dummy content
- Terms & Conditions screen is implemented
- Widget test for splash-to-home navigation is passing

## Next Suggested Improvements

- Split `lib/main.dart` into smaller screen and widget files
- Replace dummy content with real data sources
- Connect bottom navigation items to their actual screens
- Add more widget and navigation tests
