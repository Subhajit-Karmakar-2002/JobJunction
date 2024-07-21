import 'package:flutter/cupertino.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/views/admin/widget/textfield.dart';
import 'package:jobjunction/views/common/app_style.dart';

class Edittextfield extends StatelessWidget {
  const Edittextfield(
      {super.key, required this.controller, required this.text});
  final controller;
  final text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          text,
          style: appstyle(20, Color(kDark.value), FontWeight.w300),
        ),
        Expanded(
          child: JobTextField(
            controller: controller,
            hintext: text,
          ),
        ),
      ],
    );
  }
}
