import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kisgeri24/main.dart' as app;
import 'package:kisgeri24/ui/auth/onBoarding/on_boarding_screen.dart';

void main() {
  group('App test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('full app test', (tester) async {

      app.main();
      await tester.pumpAndSettle();

      FlutterDriver driver;
// connect flutter driver to the app before executing the runs
      setUpAll(() async {
        driver = await FlutterDriver.connect();
      });
// disconnect flutter driver from the app after executing the runs
      tearDownAll(() async {
        if (driver != null) {
          driver.close();
        }
      });


      SerializableFinder stuff = find.byKey(Key("onboarding-screen"));

      await driver.waitFor(stuff);
      await driver.scroll(stuff), 300, 0, Duration(500));



      await tester.drag(
          find.byKey(Key("onboarding-screen")), const Offset(300, 0));
      await tester.pumpAndSettle();
      await tester.drag(
          find.byKey(Key("onboarding-screen")), const Offset(300, 0));
      await tester.pumpAndSettle();
      await tester.drag(
          find.byKey(Key("onboarding-screen")), const Offset(300, 0));
      await tester.pumpAndSettle();
      await tester.drag(
          find.byKey(Key("onboarding-screen")), const Offset(300, 0));
      await tester.pumpAndSettle();
      await tester.drag(
          find.byKey(Key("onboarding-screen")), const Offset(300, 0));
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
    }
    });
  });
}
