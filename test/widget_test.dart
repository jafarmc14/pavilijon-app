import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pavilijon_app/data/homepage_content.dart';
import 'package:pavilijon_app/main.dart';
import 'package:pavilijon_app/screens/loyalty_registration_screen.dart';
import 'package:pavilijon_app/screens/splash_screen.dart';

final _mockHomepageContent = <String, dynamic>{
  'hero': {
    'images': ['https://pavilijoncoffee.com/uploads/mock-hero.png'],
  },
  'story': {
    'images': ['https://pavilijoncoffee.com/uploads/mock-story.png'],
  },
  'signatureMenu': [
    {
      'id': 2,
      'name': 'Americano',
      'description': 'House signature',
      'priceGross': 14,
      'imageUrl': 'https://pavilijoncoffee.com/uploads/mock-americano.png',
    },
  ],
};

void main() {
  setUp(() {
    HomepageContentStore.instance.clear();
    SplashScreen.homepageLoaderOverride = () async {
      HomepageContentStore.instance.replaceFromJson(_mockHomepageContent);
      return true;
    };
    LoyaltyRegistrationScreen.favoriteProductsLoaderOverride = () async => [
      'Americano',
      'Cappuccino',
      'Latte',
    ];
  });

  tearDown(() {
    HomepageContentStore.instance.clear();
    SplashScreen.homepageLoaderOverride = null;
    LoyaltyRegistrationScreen.favoriteProductsLoaderOverride = null;
  });

  testWidgets('Splash screen navigates to home after startup checks', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PavilijonApp());

    expect(find.text('Pavilijon'), findsOneWidget);
    expect(find.text('FETCHING HOMEPAGE DATA...'), findsOneWidget);

    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    expect(find.text('THE SILENT CEREMONY'), findsOneWidget);
    expect(find.text('The Morning Ritual'), findsOneWidget);
    expect(find.text('Americano'), findsOneWidget);
  });

  testWidgets('Become a Member opens loyalty registration screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PavilijonApp());
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('BECOME A MEMBER'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(find.text('BECOME A MEMBER'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('BECOME A MEMBER'));
    await tester.pumpAndSettle();

    expect(find.text('MEMBERSHIP INVITATION'), findsOneWidget);
    expect(find.text('BEGIN THE CEREMONY'), findsOneWidget);
    expect(find.text('THE FAVORITE ORIGIN'), findsOneWidget);
    expect(find.text('Americano'), findsOneWidget);
  });

  testWidgets('Track bottom navigation opens track order screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PavilijonApp());
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    await tester.tap(find.text('TRACK'));
    await tester.pumpAndSettle();

    expect(find.text('Track Your Ritual'), findsOneWidget);
    expect(find.text('#232425'), findsOneWidget);
    expect(find.text('RITUAL SUMMARY'), findsOneWidget);
  });

  testWidgets('Store and Grab & Go bottom navigation open their screens', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PavilijonApp());
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    await tester.tap(find.text('STORE'));
    await tester.pumpAndSettle();

    expect(find.text('Kohi Store'), findsOneWidget);
    expect(find.text('Floral Ceremony Roast'), findsOneWidget);

    await tester.tap(find.text('GRAB & GO'));
    await tester.pumpAndSettle();

    expect(find.text('To Go Menu'), findsOneWidget);
    expect(find.text('Ceremony Latte'), findsOneWidget);
    expect(find.text('VESSEL SIZE'), findsNothing);
  });

  testWidgets('Quick Add on Grab & Go opens variant picker screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PavilijonApp());
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    await tester.tap(find.text('GRAB & GO'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('QUICK ADD').first);
    await tester.pumpAndSettle();

    expect(find.text('KURASU TOKYO'), findsOneWidget);
    expect(find.text('SIGNATURE BREW'), findsOneWidget);
    expect(find.text('Small'), findsOneWidget);
    expect(find.text('Medium'), findsOneWidget);
    expect(find.text('Big'), findsOneWidget);
    expect(find.text('ADD TO CART'), findsOneWidget);
  });

  testWidgets('Checkout on Grab & Go opens To-Go Cart screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PavilijonApp());
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    await tester.tap(find.text('GRAB & GO'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('CHECKOUT'));
    await tester.pumpAndSettle();

    expect(find.text('To-Go Cart'), findsOneWidget);
    expect(find.text('Ceremony Latte'), findsOneWidget);
    expect(find.text('Cold Brew Reserve'), findsOneWidget);
    expect(find.text('ENHANCE THE RITUAL'), findsNothing);
  });

  testWidgets('Proceed to checkout on Grab & Go cart opens checkout screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PavilijonApp());
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    await tester.tap(find.text('GRAB & GO'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('CHECKOUT'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('PROCEED TO CHECKOUT'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('PROCEED TO CHECKOUT'));
    await tester.pumpAndSettle();

    expect(find.text('Personal Ritual'), findsOneWidget);
    expect(find.text('LOYALTY VALIDATION'), findsOneWidget);
    expect(find.text('FINALIZE RITUAL'), findsOneWidget);
  });

  testWidgets('Finalize ritual on Grab & Go checkout opens payment success', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PavilijonApp());
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    await tester.tap(find.text('GRAB & GO'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('CHECKOUT'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('PROCEED TO CHECKOUT'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('PROCEED TO CHECKOUT'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('FINALIZE RITUAL'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('FINALIZE RITUAL'));
    await tester.pumpAndSettle();

    expect(find.text('Your Ritual is Brewing'), findsOneWidget);
    expect(find.text('#042'), findsOneWidget);
    expect(find.text('8-10'), findsNothing);
    expect(find.text('TRACK IN REAL-TIME'), findsNothing);
    expect(find.text('RETURN TO HOME'), findsNothing);
  });

  testWidgets('Review Order on Store opens Store Cart screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PavilijonApp());
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    await tester.tap(find.text('STORE'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('REVIEW ORDER'));
    await tester.pumpAndSettle();

    expect(find.text('THE CART\nRITUAL'), findsOneWidget);
    expect(find.text('Floral Ceremony Roast'), findsOneWidget);
    expect(find.text('BEGIN CHECKOUT RITUAL'), findsOneWidget);
  });

  testWidgets('Begin Checkout Ritual opens Store Checkout screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PavilijonApp());
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    await tester.tap(find.text('STORE'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('REVIEW ORDER'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('BEGIN CHECKOUT RITUAL'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('BEGIN CHECKOUT RITUAL'));
    await tester.pumpAndSettle();

    expect(find.text('Personal Details'), findsOneWidget);
    expect(find.text('PAY NOW'), findsOneWidget);
    expect(find.text('Payment Method'), findsNothing);
  });

  testWidgets('Pay Now opens Store Payment Success screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PavilijonApp());
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    await tester.tap(find.text('STORE'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('REVIEW ORDER'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('BEGIN CHECKOUT RITUAL'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('BEGIN CHECKOUT RITUAL'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('PAY NOW'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('PAY NOW'));
    await tester.pumpAndSettle();

    expect(find.text('The Ritual Awaits'), findsOneWidget);
    expect(find.text('#SR-2024'), findsOneWidget);
    expect(find.text('RETURN TO HOME'), findsNothing);
    expect(find.text('VIEW ORDER TRACKING'), findsNothing);
  });
}
