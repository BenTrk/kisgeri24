import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kisgeri24/main.dart' as app;

void main() {
  group('App test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('full app test', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.drag(find.byType(Overlay), const Offset(280, 0));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(Overlay), const Offset(280, 0));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(Overlay), const Offset(280, 0));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(Overlay), const Offset(280, 0));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(Overlay), const Offset(280, 0));
      await tester.pumpAndSettle();

      /*final emailField = find.byKey(const Key("emailKey"));
      final pwField = find.byKey(const Key("passwordKey"));
      final loginButton = find.byKey(const Key("loginButton"));


      //tester.tap(emailField);
      await tester.enterText(emailField, "some@email.com");
      //tester.tap(pwField);
      await tester.enterText(pwField, "somePassword");
      await tester.pumpAndSettle();
      await tester.tap(loginButton);
      await tester.pumpAndSettle();*/
    });
  });
}
