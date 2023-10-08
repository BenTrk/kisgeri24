
## KisGeri24 mobile app (v0.2.0)
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white) ![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase)
___  
### Requirements:
#### For development:
- Flutter: 3.10.6
- Dart: 3.0.6
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