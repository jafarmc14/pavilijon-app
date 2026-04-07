import 'package:flutter_test/flutter_test.dart';
import 'package:pavilijon_app/main.dart';

void main() {
  testWidgets('Splash screen navigates to home after startup checks', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PavilijonApp());

    expect(find.text('Pavilijon'), findsOneWidget);
    expect(find.text('LOADING INITIAL DATA...'), findsOneWidget);

    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    expect(find.text('THE SILENT CEREMONY'), findsOneWidget);
    expect(find.text('The Morning Ritual'), findsOneWidget);
    expect(find.text('EXPLORE BEANS'), findsOneWidget);
  });
}
