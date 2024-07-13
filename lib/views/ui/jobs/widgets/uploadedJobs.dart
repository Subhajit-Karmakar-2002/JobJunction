import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:job_finder/constants/app_constants.dart';
import 'package:job_finder/models/response/jobs/get_job.dart';
import 'package:job_finder/models/response/jobs/jobs_response.dart';
import 'package:job_finder/views/common/app_style.dart';
import 'package:job_finder/views/common/height_spacer.dart';
import 'package:job_finder/views/common/reusable_text.dart';
import 'package:job_finder/views/screens/jobs/jobDetial.dart';

class UploadedJob extends StatelessWidget {
  const UploadedJob({super.key, required this.job, required this.txt});
  final JobsResponse job;
  final String txt;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(JobDetails(job: job));
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          height: hieght * 0.1,
          decoration: BoxDecoration(
            color: Color(kLightGrey.value),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: Text(job.title),
            subtitle: Text(job.description),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                job.imageUrl,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
