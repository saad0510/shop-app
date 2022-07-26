// TODO: user regex for validations

class FormValidator {
  FormValidator._();

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
}

extension on String {
  bool isValidEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }
}
