import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_scan_app/main.dart';

void main() {
  testWidgets('QR Scan App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Wait for the widgets to settle
    await tester.pumpAndSettle();

    // Verify that the app starts with QR Scanner title
    expect(find.text('QR Scanner'), findsOneWidget);

    // Verify that the scan button is present
    expect(find.text('Scan QR Code'), findsOneWidget);
  });

  testWidgets('App has correct title', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Find the MaterialApp and check its title
    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.title, 'QR Scan App');
  });
}
