import 'package:flutter/material.dart';
import 'package:jobjunction/views/common/exports.dart';

class HeadingWidget extends StatelessWidget {

  const HeadingWidget({super.key, this.ontap, required this.text});
  final void Function()? ontap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ReusableText(
          text: text,
          style: appstyle(16, Color(kDark.value), FontWeight.w600),
        ),
        GestureDetector(
          onTap: ontap,
          child: ReusableText(
              text: "View all",
              style: appstyle(16, Color(kDark.value), FontWeight.w500)),
        )
      ],
    );
  }
}
