import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/views/common/exports.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.actions, required this.child, this.text});
  final List<Widget>? actions;
  final Widget child;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(),
      backgroundColor: Color(kLight.value),
      elevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: 70.w,
      centerTitle: true,
      leading: child,
      actions: actions,
      title: ReusableText(
        text: text ?? "",
        style: appstyle(20, Color(kDark.value), FontWeight.bold),
      ),
    );
  }
}
