import 'package:flutter/material.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/views/common/app_style.dart';
import 'package:jobjunction/views/common/height_spacer.dart';
import 'package:jobjunction/views/common/reusable_text.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Color(kDarkBlue.value),
        child: Column(
          children: [
            const HeightSpacer(
              size: 70,
            ),
            Image.asset("assets/images/page2.png"),
            const HeightSpacer(
              size: 70,
            ),
            Column(
              children: [
                Text(
                  "Stable Yourself \nwith your ability",
                  textAlign: TextAlign.center,
                  style: appstyle(30, Color(kLight.value), FontWeight.w500),
                ),
                const HeightSpacer(
                  size: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "We help you find your dream job according to your skill set,location,ans preference to build your career",
                    textAlign: TextAlign.center,
                    style: appstyle(16, Color(kLight.value), FontWeight.normal),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
