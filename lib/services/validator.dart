import "package:email_validator/email_validator.dart";
import "package:kisgeri24/logging.dart";

@Deprecated("Not needed anymore since registration won't be a feature.")
String? validateName(String? value) {
  const String pattern = r"(^[a-zA-Z ]*$)";
  final RegExp regExp = RegExp(pattern);
  if (value?.isEmpty ?? true) {
    return "Name is required";
  } else if (!regExp.hasMatch(value ?? '')) {
    return "Name must be a-z and A-Z";
  }
  return null;
}

@Deprecated(
    "This wasn't used but can be later on if we'd decide to make the phone number editable.")
String? validateMobile(String? value) {
  logger.i("Validating phone number: $value");
  const String pattern =
      r"((?:\+?3|0)6)(?:-|\()?(\d{1,2})(?:-|\))?(\d{3})-?(\d{3,4})";
  final RegExp regExp = RegExp(pattern);
  if (value == null || value.isEmpty) {
    logger.i(
        "The given input for phone number validation is either null or empty thus no validation can be done!");
    return "Mobile phone number is required";
  } else if (!regExp.hasMatch(value)) {
    logger.i("Phone number ($value) is not acceptable.");
    return "Mobile phone number must contain only digits";
  }
  logger.i("Phone number validation passed!");
  return null;
}

String? validatePassword(String? value) {
  if ((value?.length ?? 0) < 6) {
    return "Password must be more than 5 characters";
  } else {
    return null;
  }
}

String? validateEmail(String? value) {
  if (value != null && EmailValidator.validate(value)) {
    return null;
  }
  return "Not a valid email address";
}

@Deprecated(
    "Ever since the registration feature is not necessary anymore, this validation is also not necessary.")
String? validateConfirmPassword(String? password, String? confirmPassword) {
  if (password != confirmPassword) {
    return "Password doesn't match";
  } else if (confirmPassword?.isEmpty ?? true) {
    return "Confirm password is required";
  } else {
    return null;
  }
}
