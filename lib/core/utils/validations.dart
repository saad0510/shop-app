import '../extensions/string.dart';

// TODO: user regex for validations

class Validator {
  Validator._();

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) return "The name is required";
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return "The phone number is required";
    if (value.length != 11) return "Enter a valid phone number";
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "The email is required";
    if (value.isValidEmail() == false) return "Please enter a valid email";
    return null;
  }

  static String? validatePass(String? value) {
    if (value == null || value.isEmpty) return "The password is required";
    if (value.length < 6) return "Password should contain atleast 6 characters";
    return null;
  }

  static String? validateConfirmPass(String? value, String? original) {
    return value == original ? null : "Passwords do not match";
  }
}
