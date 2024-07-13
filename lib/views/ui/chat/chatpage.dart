import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/views/common/app_bar.dart';
import 'package:jobjunction/views/common/drawer/drawer_widget.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(child: DrawerWidget(color: Color(kDark.value))),
      ),
      body: Text("Chat"),
    );
  }
}
