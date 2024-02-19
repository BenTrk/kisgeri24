CLEAN_COMMAND := flutter clean
BUILD_APK_COMMAND := flutter build apk

ifeq ($(OS),Windows_NT)
	OS_NAME := Windows
else
	OS_NAME := $(shell uname -s)
endif

validate: check-format check-dart-code-analysis test

check-format:
	echo 'Performing Dart code format validation'
	dart format --output=none --set-exit-if-changed .

get-dart-dependencies:
	echo 'Getting Dart dependencies'
	dart pub get

check-dart-code-analysis:
	echo 'Performing Dart code analysis.'
	dart analyze

format:
	dart format --output=write .

test:
	make generate-unit-test-mocks
	echo 'About to initiate Dart unit test execution...'
	dart test

generate-unit-test-mocks:
	dart run build_runner build --delete-conflicting-outputs

GOOGLE_IOS_FILE := GoogleService-Info.plist
GOOGLE_ANDROID_FILE := google-services.json
ifeq ($(OS_NAME),Windows)
	IOS_DEST_PATH := ios\Runner
	IOS_SRC_PATH := \config\$(GOOGLE_IOS_FILE)
	ANDROID_DEST_PATH := android\app
	ANDROID_SRC_PATH := \config\$(GOOGLE_ANDROID_FILE)
else
	IOS_DEST_PATH := ios/Runner
	IOS_SRC_PATH := config/$(GOOGLE_IOS_FILE)
	ANDROID_DEST_PATH := android/app
	ANDROID_SRC_PATH := config/$(GOOGLE_ANDROID_FILE)
endif

clean_build_ios:
	@echo "Copying $(GOOGLE_IOS_FILE) to $(IOS_DEST_PATH)"
	@cp $(IOS_SRC_PATH) $(IOS_DEST_PATH)
	@echo "Performing Flutter clean"
	@$(CLEAN_COMMAND)
	@echo "Performing build for ios (simulator)"
	@flutter build ios --simulator

clean_build_android:
ifeq ($(OS_NAME),Windows)
	@echo "Copying $(GOOGLE_ANDROID_FILE) to $(ANDROID_DEST_PATH)"
	@copy $(ANDROID_SRC_PATH) $(ANDROID_DEST_PATH)
	@$(CLEAN_COMMAND)
	@$(BUILD_APK_COMMAND)
else
	@echo "Copying $(GOOGLE_ANDROID_FILE) to $(ANDROID_DEST_PATH)"
	@cp $(ANDROID_SRC_PATH) $(ANDROID_DEST_PATH)
	@$(CLEAN_COMMAND)
	@$(BUILD_APK_COMMAND)
endif