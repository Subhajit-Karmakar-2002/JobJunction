import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/controllers/exports.dart';
import 'package:jobjunction/controllers/login_provider.dart';
import 'package:jobjunction/models/request/auth/signup_model.dart';
import 'package:jobjunction/views/common/app_bar.dart';
import 'package:jobjunction/views/common/custom_btn.dart';
import 'package:jobjunction/views/common/custom_textfield.dart';
import 'package:jobjunction/views/common/exports.dart';
import 'package:jobjunction/views/common/height_spacer.dart';
import 'package:jobjunction/views/common/reusable_text.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Consumer<SignUpNotifier>(
      builder: (context, signupNotifier, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
              text: "SignUp",
              child: GestureDetector(
                child: const Icon(CupertinoIcons.arrow_left),
                onTap: () {
                  Get.back();
                },
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Form(
              key: signupNotifier.signupFormKey,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const HeightSpacer(size: 30),
                  ReusableText(
                    text: "Welcome Back",
                    style: appstyle(
                      30,
                      Color(kDark.value),
                      FontWeight.bold,
                    ),
                  ),
                  ReusableText(
                    text: "Fill in details to login",
                    style: appstyle(
                      16,
                      Color(kDarkGrey.value),
                      FontWeight.normal,
                    ),
                  ),
                  const HeightSpacer(size: 40),
                  CustomTextField(
                    controller: email,
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email!.isEmpty || !email.contains('@')) {
                        return "Please Enter a Valid Email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 20),
                  CustomTextField(
                    controller: name,
                    hintText: "Username",
                    keyboardType: TextInputType.text,
                    validator: (name) {
                      if (name!.isEmpty) {
                        return "Please enter a userName";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 20),
                  CustomTextField(
                    obscureText: signupNotifier.isObsecure,
                    controller: password,
                    hintText: "Password",
                    keyboardType: TextInputType.emailAddress,
                    // validator: (password) {
                    //   if (signupNotifier.passwordValidator(password ?? '')) {
                    //     return "Enter a valid passoword";
                    //   }
                    //   return null;
                    // },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        signupNotifier.isObsecure = !signupNotifier.isObsecure;
                      },
                      child: Icon(
                        signupNotifier.isObsecure
                            ? Icons.remove_red_eye_rounded
                            : Icons.remove_red_eye_outlined,
                      ),
                    ),
                  ),
                  const HeightSpacer(size: 20),
                  HeightSpacer(size: 20),
                  CustomButton(
                    text: "SignUp",
                    ontap: () {
                      loginNotifier.firstTime = !loginNotifier.firstTime;
                      if (signupNotifier.validateAndSave()) {
                        SignupModel model = SignupModel(
                            email: email.text,
                            password: password.text,
                            username: name.text);
                        signupNotifier.signup(model);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
