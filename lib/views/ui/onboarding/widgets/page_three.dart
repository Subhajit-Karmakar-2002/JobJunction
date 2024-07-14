import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/views/common/app_style.dart';
import 'package:jobjunction/views/common/custom_outline_btn.dart';
import 'package:jobjunction/views/common/height_spacer.dart';
import 'package:jobjunction/views/ui/auth/login.dart';
import 'package:jobjunction/views/ui/auth/signup.dart';
import 'package:jobjunction/views/ui/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Color(kLightBlue.value),
        child: Column(
          children: [
            Image.asset("assets/images/page3.png"),
            const HeightSpacer(
              size: 20,
            ),
            Column(
              children: [
                Text(
                  "Welcome to \nJobjunction",
                  style: appstyle(30, Color(kLight.value), FontWeight.w500),
                ),
                const HeightSpacer(
                  size: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text(
                    "We help you find your dream job according to your skill set,location,ans preference to build your career",
                    textAlign: TextAlign.center,
                    style: appstyle(14, Color(kLight.value), FontWeight.normal),
                  ),
                ),
                const HeightSpacer(size: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomOutlineBtn(
                      color2: Color(kLightBlue.value),
                      text: "Login",
                      color: Color(kLight.value),
                      height: height * 0.05,
                      width: width * 0.3,
                      onTap: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool("entrypoint", true);
                        Get.to(() => const LoginPage());
                      },
                    ),
                    CustomOutlineBtn(
                      color2: Color(kLightBlue.value),
                      text: "Signup",
                      color: Color(kLight.value),
                      height: height * 0.05,
                      width: width * 0.3,
                      onTap: () {
                        Get.to(() => const RegistrationPage());
                      },
                    ),
                  ],
                ),
                const HeightSpacer(size: 20),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const Mainscreen());
                  },
                  child: Text(
                    "Continue as Guest",
                    style: appstyle(18, Color(kLight.value), FontWeight.normal),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
