import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campkeeper_riverpod/main.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: CampKeeperApp()));

    // Verify that the app bar is present
    expect(find.text('CampKeeper'), findsOneWidget);
  });
}
