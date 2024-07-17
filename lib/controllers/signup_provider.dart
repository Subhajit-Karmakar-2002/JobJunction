import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/models/request/auth/signup_model.dart';
import 'package:jobjunction/services/helpers/auth_helper.dart';
import 'package:jobjunction/views/ui/auth/login.dart';

class SignUpNotifier extends ChangeNotifier {
// trigger to hide and unhide the password
  bool _isObsecure = true;

  bool get isObsecure => _isObsecure;

  set isObsecure(bool obsecure) {
    _isObsecure = obsecure;
    notifyListeners();
  }

// triggered when the login button is clicked to show the loading widget
  bool _processing = false;

  bool get processing => _processing;

  set processing(bool newValue) {
    _processing = newValue;
    notifyListeners();
  }

// triggered when the fist time when user login to be prompted to the update profile page
  bool _firstTime = false;

  bool get firstTime => _firstTime;

  set firstTime(bool newValue) {
    _firstTime = newValue;
    notifyListeners();
  }

  bool passwordValidator(String password) {
    if (password.isEmpty) return false;
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  final signupFormKey = GlobalKey<FormState>();
  bool validateAndSave() {
    final form = signupFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  signup(SignupModel model) {
    AuthHelper.signUp(model).then((response) => {
        
          if (response)
            {
              Get.offAll(
                () => LoginPage(),
                transition: Transition.fade,
                duration: Duration(seconds: 2),
              ),
            }
          else
            {
              Get.snackbar(
                "SignUp fail",
                "Try again",
                colorText: Color(kLight.value),
                backgroundColor: Colors.red,
                icon: const Icon(Icons.add_alert),
              ),
            }
        });
  }
}
