import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/controllers/exports.dart';
import 'package:jobjunction/views/common/app_bar.dart';
import 'package:jobjunction/views/common/drawer/drawer_widget.dart';
import 'package:jobjunction/views/common/exports.dart';
import 'package:jobjunction/views/ui/jobs/job_page.dart';
import 'package:jobjunction/views/ui/jobs/widgets/jobHorizontalTile.dart';
import 'package:provider/provider.dart';

class GetJobs extends StatefulWidget {
  const GetJobs({super.key});

  @override
  State<GetJobs> createState() => _GetJobsState();
}

class _GetJobsState extends State<GetJobs> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
      builder: (context, jobsNotifier, child) {
        jobsNotifier.getAgentJob();
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppBar(
              text: "Display Added Job",
              child: DrawerWidget(
                color: Color(kDark.value),
              ),
            ),
          ),
          body: FutureBuilder(
            future: jobsNotifier.agentjoblist,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  color: ShimmerEffect.defaultColor,
                );
              } else if (snapshot.hasError) {
                return Container(
                  color: Colors.red,
                );
              } else {
                final job = snapshot.data;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: job!.length,
                    itemBuilder: (context, index) {
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
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
