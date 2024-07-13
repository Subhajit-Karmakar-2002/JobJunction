import 'package:flutter/material.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/views/common/exports.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.color, required this.text, this.ontap});
  final Color? color;
  final String text;
  final void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        color: Color(kOrange.value),
        width: width,
        height: height * 0.065,
        child: Center(
          child: ReusableText(
            text: text,
            style: appstyle(
              18,
              color ?? Color(kLight.value),
              FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
