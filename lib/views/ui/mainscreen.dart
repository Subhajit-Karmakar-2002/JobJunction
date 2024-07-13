import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:jobjunction/views/common/drawer/drawerScreen.dart';
import 'package:jobjunction/views/common/drawer/drawer_widget.dart';
import 'package:jobjunction/views/common/reusable_text.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/controllers/zoom_provider.dart';
import 'package:jobjunction/views/common/drawer/drawerScreen.dart';
import 'package:jobjunction/views/ui/auth/profile.dart';
import 'package:jobjunction/views/ui/bookmarks/bookmarks.dart';
import 'package:jobjunction/views/ui/chat/chatpage.dart';
import 'package:jobjunction/views/ui/device_mgt/devices_info.dart';
import 'package:jobjunction/views/ui/homepage.dart';
import 'package:provider/provider.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ZoomNotifier>(
        builder: (context, zoomNotifier, child) {
          return ZoomDrawer(
            menuScreen: DrawerScreen(
              indexSetter: (value) {
                zoomNotifier.currentIndex = value;
              },
            ),
            menuBackgroundColor: Color(kLightBlue.value),
            angle: 0.0,
            slideWidth: 250,
            mainScreen: CurrentScreen(),
          );
        },
      ),
    );
  }

  Widget CurrentScreen() {
    int zoomNotifier = (Provider.of<ZoomNotifier>(context)).currentIndex;
    switch (zoomNotifier) {
      case 0:
        return const HomePage();
      case 1:
        return const ChatsPage();
      case 2:
        return const BookMarkPage();
      case 3:
        return const DeviceManagement();
      case 4:
        return const ProfilePage(
          drawer: true,
        );

      default:
        return const HomePage();
    }
  }
}
