# Pavilijon App

Flutter app untuk pengalaman coffee retail bergaya editorial dengan dummy data, active tab navigation, dan beberapa flow transaksi end-to-end untuk `Store` dan `Grab & Go`.

## Current Scope

Project saat ini sudah mencakup:

- Splash screen animatif dengan auto-navigation dan simulasi startup check
- Home screen editorial sebagai landing page utama
- Store flow: `Store -> Store Cart -> Store Checkout -> Store Payment Success`
- Grab & Go flow: `Grab & Go -> Variant Picker Sheet -> Grab & Go Cart -> Grab & Go Checkout -> Grab & Go Payment Success`
- Track Order screen dengan queue status, timeline progress, dan summary order
- Terms & Conditions screen
- Loyalty Registration screen
- Bottom navigation aktif untuk `Home`, `Store`, `Grab & Go`, dan `Track`

## Main Flow

1. App dibuka ke splash screen.
2. Splash mensimulasikan loading data awal dan pengecekan konfigurasi.
3. App otomatis masuk ke Home screen.
4. Dari Home, user bisa membuka:
   - `Store`
   - `Grab & Go`
   - `Track`
   - `Terms & Conditions`
   - `Loyalty Registration` lewat tombol `BECOME A MEMBER`

## Active User Journeys

### Store

1. User membuka tab `Store`
2. User menekan `REVIEW ORDER`
3. App membuka `Store Cart`
4. User menekan `BEGIN CHECKOUT RITUAL`
5. App membuka `Store Checkout`
6. User menekan `PAY NOW`
7. App membuka `Store Payment Success`

### Grab & Go

1. User membuka tab `Grab & Go`
2. User menekan `QUICK ADD`
3. App membuka `Variant Picker` dalam bentuk modal sheet
4. User menekan `CHECKOUT`
5. App membuka `Grab & Go Cart`
6. User menekan `PROCEED TO CHECKOUT`
7. App membuka `Grab & Go Checkout`
8. User menekan `FINALIZE RITUAL`
9. App membuka `Grab & Go Payment Success`

## Project Structure

### Entry Point

- `lib/main.dart`

### Screens

- `lib/screens/splash_screen.dart`
- `lib/screens/home_screen.dart`
- `lib/screens/store_screen.dart`
- `lib/screens/store_cart_screen.dart`
- `lib/screens/store_checkout_screen.dart`
- `lib/screens/store_payment_success_screen.dart`
- `lib/screens/grab_and_go_screen.dart`
- `lib/screens/grab_and_go_variant_picker_sheet.dart`
- `lib/screens/grab_and_go_cart_screen.dart`
- `lib/screens/grab_and_go_checkout_screen.dart`
- `lib/screens/grab_and_go_payment_success_screen.dart`
- `lib/screens/track_order_screen.dart`
- `lib/screens/terms_conditions_screen.dart`
- `lib/screens/loyalty_registration_screen.dart`
- `lib/screens/screen_components.dart`

### Widgets

- `lib/widgets/home`
- `lib/widgets/store`
- `lib/widgets/store_cart`
- `lib/widgets/store_checkout`
- `lib/widgets/store_payment_success`
- `lib/widgets/grab_and_go`
- `lib/widgets/grab_and_go_variant`
- `lib/widgets/grab_and_go_cart`
- `lib/widgets/grab_and_go_checkout`
- `lib/widgets/grab_and_go_payment_success`
- `lib/widgets/track`

### Tests

- `test/widget_test.dart`

## Navigation Notes

- Bottom navigation aktif di seluruh jalur utama dengan tab `Home`, `Store`, `Grab & Go`, dan `Track`
- Burger menu sudah dihapus dari screen yang memiliki bottom navigation aktif
- Icon search di kanan atas juga sudah dihapus dari screen yang sebelumnya masih memilikinya
- Screen sekunder tetap memakai bottom navigation yang sama bila relevan
- `Variant Picker Grab & Go` bukan screen penuh, tetapi modal sheet di atas `Grab & Go`

## UI Notes

- UI dibangun dengan Flutter widgets, Material 3, gradient panels, dan komponen editorial custom
- Konten produk, checkout, tracking, loyalty, dan payment success masih memakai dummy data
- Visual item tidak bergantung pada asset image eksternal; sebagian besar memakai ambient panel/gradient lokal
- Layout sudah dioptimalkan agar aman di viewport yang lebih pendek dan tidak mudah overflow

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

Widget test saat ini memverifikasi:

- splash screen berpindah otomatis ke Home
- tombol `BECOME A MEMBER` membuka Loyalty Registration
- tab `Track` membuka Track Order screen
- tab `Store` dan `Grab & Go` membuka screen masing-masing
- `QUICK ADD` di `Grab & Go` membuka variant picker sheet
- `CHECKOUT` di `Grab & Go` membuka `To-Go Cart`
- `PROCEED TO CHECKOUT` membuka `Grab & Go Checkout`
- `FINALIZE RITUAL` membuka `Grab & Go Payment Success`
- `REVIEW ORDER` di `Store` membuka `Store Cart`
- `BEGIN CHECKOUT RITUAL` membuka `Store Checkout`
- `PAY NOW` membuka `Store Payment Success`

## Current Status

Yang sudah selesai:

- screen utama sudah dipisah dari `main.dart` ke folder `lib/screens`
- komponen besar sudah dipisah ke folder `lib/widgets`
- flow `Store` sudah lengkap sampai payment success
- flow `Grab & Go` sudah lengkap sampai payment success
- `Terms & Conditions`, `Track`, dan `Loyalty Registration` sudah terhubung
- bottom navigation aktif dan konsisten
- widget tests aktif dan semuanya lolos

