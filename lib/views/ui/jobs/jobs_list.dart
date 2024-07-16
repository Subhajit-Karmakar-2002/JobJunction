import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/controllers/exports.dart';
import 'package:jobjunction/views/common/app_bar.dart';
import 'package:jobjunction/views/ui/jobs/job_page.dart';
import 'package:jobjunction/views/ui/jobs/widgets/jobHorizontalTile.dart';
import 'package:provider/provider.dart';

class JobListPage extends StatelessWidget {
  const JobListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var jobList = Provider.of<JobsNotifier>(context);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          text: "Jobs",
          child: Padding(
            padding: EdgeInsets.all(10),
            // child: BackBtn(),
          ),
        ),
      ),
      body: FutureBuilder(
        future: jobList.joblist,
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
  }
}
