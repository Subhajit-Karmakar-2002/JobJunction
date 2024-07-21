import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/models/request/auth/login_model.dart';
import 'package:jobjunction/models/request/auth/profile_update_model.dart';
import 'package:jobjunction/services/helpers/auth_helper.dart';
import 'package:jobjunction/views/ui/auth/update_user.dart';
import 'package:jobjunction/views/ui/homepage.dart';
import 'package:jobjunction/views/ui/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends ChangeNotifier {
  bool _obscuretext = true;

  bool get obscuretext => _obscuretext;

  set obscuretext(bool value) {
    _obscuretext = value;
    notifyListeners();
  }

  bool _isagent = true;

  bool get isagent => _isagent;


  bool _firstTime = true;
  bool get firstTime => _firstTime;

  set firstTime(bool value) {
    _firstTime = value;
    notifyListeners();
  }




  bool? _entrypoint;

  bool get entrypoint => _entrypoint ?? false;

  set entrypoint(bool value) {
    entrypoint = value;
    notifyListeners();
  }

  bool? _loggedIn;

  bool get loggedIn => _loggedIn ?? false;

  set loggedIn(bool value) {
    _loggedIn = value;
    notifyListeners();
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _entrypoint = prefs.getBool('entrypoint') ?? false;
    _loggedIn = prefs.getBool('loggedIn') ?? false;

    notifyListeners();
  }

  userLogin(LoginModel model) {
    print(firstTime);
    AuthHelper.login(model).then(
      (response) {
        if (response && firstTime) {
          Get.off(() => const PersonalDetails());
        } else if (response && !firstTime) {
          loggedIn = true;
          Get.off(() => const HomePage());
        } else if (!response) {
          Get.snackbar(
            'Login Failed',
            'Please check your credentials',
            colorText: Color(kLight.value),
            backgroundColor: Colors.red,
            icon: const Icon(Icons.add_alert),
          );
        }
      },
    );
  }

  // final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final profileFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = loginFormKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  bool profileValidation() {
    final form = profileFormKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', false);
    await prefs.remove('token');
    _firstTime = false;
  }

  updateProfile(ProfileUpdateReq model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    AuthHelper.updateProfile(model).then((response) => {
          if (response)
            {
              Get.snackbar(
                "Profile Updated",
                "Enjoy your search",
                colorText: Color(kLight.value),
                backgroundColor: Colors.green,
                icon: const Icon(Icons.add_alert),
              ),
              Future.delayed(const Duration(seconds: 1)).then(
                (Value) {
                  Get.offAll(() => const Mainscreen());
                },
              ),
            }
          else
            {
              Get.snackbar(
                "Update fail",
                "Try again",
                colorText: Color(kLight.value),
                backgroundColor: Colors.red,
                icon: const Icon(Icons.add_alert),
              ),
            }
        });
  }
}
