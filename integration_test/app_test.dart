import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kisgeri24/main.dart' as app;
import 'package:kisgeri24/ui/auth/onBoarding/on_boarding_screen.dart';

void main() {
  testWidgets('Test swipe gesture', (tester) async {
    // Build the app and trigger a frame.
    app.main();
    IntegrationTestWidgetsFlutterBinding.ensureInitialized().initInstances();
    await tester.pumpWidget(const app.MyApp());

    // Find the widget you want to swipe within.
    final widgetFinder = find.byKey(const Key('onboarding-page'));

    // Ensure the widget is found.
    expect(widgetFinder, findsOneWidget);

    // Perform the swipe gesture five times.
    for (var i = 0; i < 5; i++) {
      final gesture = await tester.startGesture(tester.getCenter(widgetFinder));
      await gesture.moveBy(const Offset(-200, 0)); // Swipe from right to left
      await tester.pump();
      await gesture.up();
      await tester.pumpAndSettle(); // Wait for animations to complete
    }

    // Assert that the swipe action has been performed.
    // You can add your own assertion here based on the effect of the swipe.
  });

  /*group('App test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('full app test', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final emailField = find.byKey(const Key("emailKey"));
      final pwField = find.byKey(const Key("passwordKey"));
      final loginButton = find.byKey(const Key("loginButton"));

      //tester.tap(emailField);
      await tester.enterText(emailField, "some@email.com");
      //tester.tap(pwField);
      await tester.enterText(pwField, "somePassword");
      await tester.pumpAndSettle();
      await tester.tap(loginButton);
      await tester.pumpAndSettle();
    });
  });*/
}
