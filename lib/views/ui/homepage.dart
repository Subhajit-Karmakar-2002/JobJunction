import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/controllers/exports.dart';
import 'package:jobjunction/views/common/app_bar.dart';
import 'package:jobjunction/views/common/drawer/drawer_widget.dart';
import 'package:jobjunction/views/common/exports.dart';
import 'package:jobjunction/views/common/heading_widget.dart';
import 'package:jobjunction/views/common/height_spacer.dart';
import 'package:jobjunction/views/common/search.dart';
import 'package:jobjunction/views/ui/jobs/job_page.dart';
import 'package:jobjunction/views/ui/jobs/jobs_list.dart';
import 'package:jobjunction/views/ui/jobs/widgets/jobHorizontalTile.dart';
import 'package:jobjunction/views/ui/jobs/widgets/jobverticalTile.dart';
import 'package:jobjunction/views/ui/search/searchpage.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<JobsNotifier>(
        builder: (context, jobNotifier, child) {
          jobNotifier.getJobs();
          jobNotifier.getRecent();
          return SafeArea(
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
                      "Welcome",
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
                    HeadingWidget(
                      text: "Popular Jobs",
                      ontap: () {
                        Get.to(() => JobListPage());
                      },
                    ),
                    const HeightSpacer(size: 20),
                    SizedBox(
                      height: height * 0.28,
                      child: FutureBuilder(
                        future: jobNotifier.joblist,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              color: ShimmerEffect.defaultColor,
                            );
                          } else if (snapshot.hasError) {
                            print(snapshot);
                            return Container(
                              color: Colors.red,
                            );
                          } else {
                            final job = snapshot.data;

                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: job!.length,
                              itemBuilder: (context, index) {
                                print(job[index].agentId);
                                return Jobhorizontaltile(
                                  job: job[index],
                                  onTap: () {
                                    Get.to(
                                      () => JobDetails(
                                        job: job[index],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                    const HeadingWidget(
                      text: "Recent Jobs",
                    ),
                    const HeightSpacer(size: 20),
                    FutureBuilder(
                      future: jobNotifier.recentlist,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (!snapshot.hasData) {
                          return Text("Error Occured");
                        } else {
                          final job = snapshot.data;
                          return JobsVerticalWidget(
                            job: job,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
