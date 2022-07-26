import 'package:get/state_manager.dart';

import '../../../utils/validations.dart';

class SigninErrorController extends GetxController {
  final _email = "".obs;
  final _pass = "".obs;

  String get emailErr => _email.value;
  String get passErr => _pass.value;

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
}
