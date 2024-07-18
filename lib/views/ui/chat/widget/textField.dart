import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/views/common/app_style.dart';

class MessageTextField extends StatelessWidget {
  MessageTextField(
      {super.key,
      required this.msgcontroller,
      this.suffixIcon,
      this.onChanged,
      this.onEditingComplete, this.ontapOutSide, this.onSubmitted});
  TextEditingController msgcontroller = TextEditingController();
  final suffixIcon;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onEditingComplete;
  final void Function(PointerDownEvent)? ontapOutSide;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.all(12.h),
      child: TextField(
        controller: msgcontroller,
        decoration: InputDecoration(
          isDense: true,
          hintText: "Type a message",
          contentPadding: EdgeInsets.all(6.h),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
            borderSide: const BorderSide(
              color: kLightGrey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
            borderSide: const BorderSide(
              color: kLightGrey,
            ),
          ),
          fillColor: Color(kLight.value),
          suffixIcon: suffixIcon,
        ),
        style: appstyle(
          16,
          Color(kDark.value),
          FontWeight.w500,
        ),
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onTapOutside: ontapOutSide,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
