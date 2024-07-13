import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/models/response/jobs/jobs_response.dart';
import 'package:jobjunction/views/ui/jobs/job_page.dart';

class JobsVerticalWidget extends StatelessWidget {
  const JobsVerticalWidget({super.key});
  // final JobsResponse job;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(const JobDetails());
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          height: height * 0.1,
          decoration: BoxDecoration(
            color: Color(kLightGrey.value),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const ListTile(
            title: Text("sdf"),
            subtitle: Text("sfdsfsdfdsf"),
            trailing: Icon(
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
