import 'package:get/state_manager.dart';

import '../../../utils/validations.dart';

class SignupErrorController extends GetxController {
  final _email = "".obs;
  final _pass = "".obs;
  final _confirmPass = "".obs;
  final _name = "".obs;
  final _phone = "".obs;

  String get emailErr => _email.value;
  String get passErr => _pass.value;
  String get confirmPassErr => _confirmPass.value;
  String get name => _name.value;
  String get phone => _phone.value;

  String? validateEmail(String? val) {
    final err = FormValidator.validateEmail(val);
    err != null ? _email.value = err : _email.value = "";
    return err;
  }

  String? validatePass(String? val) {
    final err = FormValidator.validatePass(val);
    err != null ? _pass.value = err : _pass.value = "";
    return err;
  }

  String? validateConfirmPass(String? val, String? originalPass) {
    final err = originalPass == val ? null : "Passwords don't match";
    err != null ? _confirmPass.value = err : _confirmPass.value = "";
    return err;
  }

  String? validateName(String? val) {
    final err = FormValidator.validateName(val);
    err != null ? _name.value = err : _name.value = "";
    return err;
  }

  String? validatePhone(String? val) {
    final err = FormValidator.validatePhone(val);
    err != null ? _phone.value = err : _phone.value = "";
    return err;
  }
}
