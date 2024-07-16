import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/models/response/jobs/jobs_response.dart';
import 'package:jobjunction/views/common/app_style.dart';
import 'package:jobjunction/views/ui/jobs/job_page.dart';

class JobsVerticalWidget extends StatelessWidget {
  const JobsVerticalWidget({super.key, this.job});
  final JobsResponse? job;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          JobDetails(
            job: job,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          height: height * 0.1,
          decoration: BoxDecoration(
            color: Color(kLightGrey.value),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: Text(
              job!.company,
              style: appstyle(20, Color(kDark.value), FontWeight.w700),
            ),
            subtitle: Text(
              job!.title,
              style: appstyle(15, Color(kDark.value), FontWeight.w400),
            ),
            leading: CircleAvatar(
              child: Image(
                image: NetworkImage(job!.imageurl),
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            // leading: CircleAvatar(
            //   backgroundImage: NetworkImage(
            //     job.imageUrl,
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}
