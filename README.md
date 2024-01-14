
## KisGeri24 mobile app (v0.3.0)
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white) ![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase)
___  
### Requirements:
#### For development:
- Flutter: 3.16.7
- Dart: 3.2.4
#### For testing:
- Maestro: 1.32.0

### Building:
#### Requirements:
To be able to build it properly, you have to obtain the necessary `GoogleService-Info.plist` file for iOS or/and the `google-services.json` for Android.
For
- iOS, you have to put it (`GoogleService-Info.plist`) under the `ios/Runner` folder
- Android, you have to put it (`google-services.json`) under the `android/app` folder

More about this in this answer: [Download Firebase config file or object](https://support.google.com/firebase/answer/7015592?hl=en#zippy=,in-this-article)
##### Optionally through make goal:
There's a slight automation for building the iOS and Android binaries, which is the `make clean_build_ios` and the `make clean_build_android` commands. These goals will copy the designated config file from the project root's `config` folder (which isn't in the repository by default, so you have to create it in advance) to the target folder and it performs a `clean` and a `build` flutter command.

---
### Testing
#### Unit testing
##### Writing mock unit tests
1. start to write the test class, and while doing so, add the necessary imports for modules/classes
2. once you have all the imports you need, select those which are needed to be mocked. Above that specific import line, add the @GenerateNiceMocks() annotation and list all the classes under that module that you would like to have a generated mock for
3. run the `make generate-unit-test-mocks` target from the root. this will generate the mock classes under the `<test-file-name>_mocks.dart` file. Don't get frightened, these files are quite long since they contain all the mocked classes and try to specify defaults for their behaviour.
4. once you have the generated mocks, you can use them instead of the actual import

#### Manipulate mock behaviour:
- use `when(<mockedClass>.<mockedClass-action).then(<action>)` when you would like to do something on a specific invocation on the selected mock
- use `when(<mockedClass>.<mockedClass-action).thenReturn(<expected-value-to-return-upon-invocation>)`, when you would like to return a specific value once the mock's selected method gets called
- use `when(<mockedClass>.<mockedClass-action).thenThrow(<expected-object-to-be-thrown>)`, when you would throw an error once this specific invocation gets called