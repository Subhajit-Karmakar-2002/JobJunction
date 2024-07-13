import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/views/common/app_bar.dart';
import 'package:jobjunction/views/common/drawer/drawer_widget.dart';
import 'package:jobjunction/views/common/exports.dart';
import 'package:jobjunction/views/common/heading_widget.dart';
import 'package:jobjunction/views/common/height_spacer.dart';
import 'package:jobjunction/views/common/search.dart';
import 'package:jobjunction/views/ui/jobs/job_page.dart';
import 'package:jobjunction/views/ui/jobs/widgets/jobHorizontalTile.dart';
import 'package:jobjunction/views/ui/jobs/widgets/jobverticalTile.dart';
import 'package:jobjunction/views/ui/search/searchpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          actions: [
            Padding(
              padding: EdgeInsets.all(5.h),
              child: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/user.png'),
              ),
            )
          ],
          child: DrawerWidget(
            color: Color(kDark.value),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeightSpacer(
                  size: 20,
                ),
                Text(
                  "Search \nFind & Apply",
                  style: appstyle(40, Color(kDark.value), FontWeight.bold),
                ),
                const HeightSpacer(size: 40),
                SearchWidget(
                  onTap: () {
                    Get.to(() => const SearchPage());
                  },
                ),
                const HeightSpacer(
                  size: 20,
                ),
                const HeadingWidget(
                  text: "Popular Jobs",
                ),
                const HeightSpacer(size: 20),
                SizedBox(
                  height: height * 0.28,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Jobhorizontaltile(
                        onTap: () {
                          Get.to(() => const JobDetails());
                        },
                      );
                    },
                  ),
                ),
                const HeadingWidget(
                  text: "Recent Jobs",
                ),
                const HeightSpacer(size: 20),
                const JobsVerticalWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
