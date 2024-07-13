import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/controllers/exports.dart';
import 'package:jobjunction/views/common/app_bar.dart';
import 'package:jobjunction/views/common/app_style.dart';
import 'package:jobjunction/views/common/drawer/drawer_widget.dart';
import 'package:jobjunction/views/common/exports.dart';
import 'package:jobjunction/views/common/height_spacer.dart';
import 'package:jobjunction/views/ui/device_mgt/widgets/device_info.dart';
import 'package:jobjunction/views/ui/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';

class DeviceManagement extends StatelessWidget {
  const DeviceManagement({super.key});

  @override
  Widget build(BuildContext context) {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    var onboardNotifier = Provider.of<OnBoardNotifier>(context);
    String date = DateTime.now().toString();
    var loginDate = date.substring(0, 11);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(child: DrawerWidget(color: Color(kDark.value))),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const HeightSpacer(size: 50),
                  Text(
                    "You are Logged in",
                    style: appstyle(16, Color(kDark.value), FontWeight.normal),
                  ),
                  const HeightSpacer(size: 50),
                  deviceInfo(
                    date: loginDate,
                    device: "Macbook",
                    ipAddress: "19.0.0.0",
                    location: "Mumbai",
                    platform: "Window",
                  ),
                  const HeightSpacer(size: 50),
                  deviceInfo(
                    date: loginDate,
                    device: "Macbook",
                    ipAddress: "19.0.0.0",
                    location: "Mumbai",
                    platform: "Window",
                  ),
                ],
              ),
            ),
            Consumer<LoginNotifier>(
              builder: (context, loginNotifier, child) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      zoomNotifier.currentIndex = 0;
                      onboardNotifier.isLastPage = false;
                      Get.to(
                        () => OnBoardingScreen(),
                      );
                    },
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ReusableText(
                        text: "Sign out of all Devices",
                        style: appstyle(
                          14,
                          Color(kOrange.value),
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
