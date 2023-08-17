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

test:
	echo 'About to initiate Dart unit test execution...'
	dart test

format:
	dart format --output=write .

