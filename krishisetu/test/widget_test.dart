// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:krishisetu/app.dart';
import 'package:krishisetu/services/app_state.dart';

void main() {
  testWidgets('KrishiSetu app renders home screen', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppState()..initialize(),
        child: const KrishiSetuApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.textContaining('KrishiSetu'), findsWidgets);
  });
}
