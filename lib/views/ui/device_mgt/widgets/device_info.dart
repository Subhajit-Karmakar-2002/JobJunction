import 'package:flutter/material.dart';
import 'package:jobjunction/views/common/custom_outline_btn.dart';
import 'package:jobjunction/views/common/exports.dart';
import 'package:jobjunction/views/common/height_spacer.dart';

class deviceInfo extends StatelessWidget {
  const deviceInfo(
      {super.key,
      required this.location,
      required this.device,
      required this.platform,
      required this.date,
      required this.ipAddress});
  final String location;
  final String device;
  final String platform;
  final String date;
  final String ipAddress;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusableText(
          text: platform,
          style: appstyle(
            22,
            Color(kDark.value),
            FontWeight.bold,
          ),
        ),
        ReusableText(
          text: device,
          style: appstyle(
            22,
            Color(kDark.value),
            FontWeight.bold,
          ),
        ),
        HeightSpacer(
          size: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ReusableText(
                  text: date,
                  style: appstyle(
                    16,
                    Color(kDarkGrey.value),
                    FontWeight.w400,
                  ),
                ),
                ReusableText(
                  text: ipAddress,
                  style: appstyle(
                    16,
                    Color(kDarkGrey.value),
                    FontWeight.w400,
                  ),
                ),
              ],
            ),
            CustomOutlineBtn(
                text: "Sign Out",
                height: height * 0.04,
                width: width * 0.3,
                color: Color(kOrange.value),
                color2: Colors.white)
          ],
        )
      ],
    );
  }
}
