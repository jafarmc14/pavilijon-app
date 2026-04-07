# Pavilijon App

Flutter app untuk pengalaman coffee retail bergaya editorial, dibangun dari beberapa screen utama dengan dummy data dan navigasi tab yang aktif.

## Current Scope

Project saat ini mencakup:

- Animated splash screen dengan ilustrasi cangkir kopi, uap, ripple kopi, dan auto-navigation
- Home screen editorial sebagai landing page utama
- Store screen dengan katalog dummy, filter chips, dan floating cart summary
- Grab & Go screen dengan menu cepat, pilihan size, dan floating checkout summary
- Track Order screen dengan queue status, timeline progress, dan ringkasan order
- Terms & Conditions screen
- Loyalty Registration screen
- Bottom navigation aktif untuk `Home`, `Store`, `Grab & Go`, dan `Track`

## Main Flow

1. App dibuka ke splash screen
2. Splash mensimulasikan loading data awal dan pengecekan konfigurasi
3. App otomatis masuk ke Home screen
4. Dari Home, user bisa:
   - membuka `Store`
   - membuka `Grab & Go`
   - membuka `Track`
   - membuka `Terms & Conditions (Regulamin)`
   - membuka `Loyalty Registration` lewat tombol `BECOME A MEMBER`

## Project Structure

### Entry Point

- [lib/main.dart](d:\pavilijonApp\pavilijon_app\lib\main.dart)

### Screens

- [splash_screen.dart](d:\pavilijonApp\pavilijon_app\lib\screens\splash_screen.dart)
- [home_screen.dart](d:\pavilijonApp\pavilijon_app\lib\screens\home_screen.dart)
- [store_screen.dart](d:\pavilijonApp\pavilijon_app\lib\screens\store_screen.dart)
- [grab_and_go_screen.dart](d:\pavilijonApp\pavilijon_app\lib\screens\grab_and_go_screen.dart)
- [track_order_screen.dart](d:\pavilijonApp\pavilijon_app\lib\screens\track_order_screen.dart)
- [terms_conditions_screen.dart](d:\pavilijonApp\pavilijon_app\lib\screens\terms_conditions_screen.dart)
- [loyalty_registration_screen.dart](d:\pavilijonApp\pavilijon_app\lib\screens\loyalty_registration_screen.dart)
- [screen_components.dart](d:\pavilijonApp\pavilijon_app\lib\screens\screen_components.dart)

### Widgets

- `lib/widgets/home`
- `lib/widgets/store`
- `lib/widgets/grab_and_go`
- `lib/widgets/track`

### Tests

- [test/widget_test.dart](d:\pavilijonApp\pavilijon_app\test\widget_test.dart)

## UI Notes

- Layout memakai Flutter widgets, `CustomPainter`, dan komponen Material 3
- Konten produk, menu, tracking, dan loyalty masih memakai dummy data
- UI aktif tidak bergantung pada asset image eksternal; visual produk dibuat dengan panel ambient/gradient lokal

## Navigation

Bottom navigation saat ini aktif dan mengarah ke screen yang tersedia:

- `Home` → Home screen
- `Store` → Store screen
- `Grab & Go` → Grab & Go screen
- `Track` → Track Order screen

Screen sekunder seperti `Terms & Conditions` dan `Loyalty Registration` tetap bisa membuka bottom navigation yang sama.

## Run The App

```bash
flutter pub get
flutter run
```

Untuk cek performa visual yang lebih realistis:

```bash
flutter run --profile
```

## Run Tests

```bash
flutter test test/widget_test.dart -r expanded
```

## Current Test Coverage

Widget test yang sudah ada saat ini memverifikasi:

- splash screen berpindah otomatis ke Home
- tombol `BECOME A MEMBER` membuka Loyalty Registration
- tab `Track` membuka Track Order screen
- tab `Store` dan `Grab & Go` membuka screen masing-masing

## Current Status

Yang sudah selesai:

- screen dipisah dari `main.dart` ke folder `lib/screens`
- komponen besar dipecah ke folder `lib/widgets`
- Home, Store, Grab & Go, dan Track sudah punya screen aktif
- Terms & Conditions dan Loyalty Registration sudah terhubung
- widget tests aktif dan lolos
