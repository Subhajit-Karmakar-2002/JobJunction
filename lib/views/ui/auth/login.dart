import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobjunction/controllers/exports.dart';
import 'package:jobjunction/views/common/app_bar.dart';
import 'package:jobjunction/views/common/custom_btn.dart';
import 'package:jobjunction/views/common/custom_textfield.dart';
import 'package:jobjunction/views/common/exports.dart';
import 'package:jobjunction/views/common/height_spacer.dart';
import 'package:jobjunction/views/ui/auth/signup.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(
      builder: (context, loginNotifier, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
              text: "Login",
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
                  obscureText: loginNotifier.obscuretext,
                  controller: password,
                  hintText: "Password",
                  keyboardType: TextInputType.emailAddress,
                  validator: (password) {
                    if (password!.isEmpty && password.length >= 6) {
                      return "Please Enter a Valid password";
                    } else {
                      return null;
                    }
                  },
                  suffixIcon: GestureDetector(
                    onTap: () {
                      loginNotifier.obscuretext = !loginNotifier.obscuretext;
                    },
                    child: Icon(
                      loginNotifier.obscuretext
                          ? Icons.remove_red_eye_rounded
                          : Icons.remove_red_eye_outlined,
                    ),
                  ),
                ),
                const HeightSpacer(size: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(RegistrationPage());
                    },
                    child: ReusableText(
                      text: "Register",
                      style: appstyle(
                        19,
                        Color(kDark.value),
                        FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                HeightSpacer(size: 20),
                CustomButton(
                  text: "Login",
                  ontap: () {},
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
