import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/models/response/jobs/jobs_response.dart';
import 'package:jobjunction/views/common/exports.dart';
import 'package:jobjunction/views/common/height_spacer.dart';
import 'package:jobjunction/views/common/reusable_text.dart';

class Jobhorizontaltile extends StatelessWidget {
  const Jobhorizontaltile({super.key, this.onTap, this.job});
  final void Function()? onTap;
  final JobsResponse? job;
  @override
  Widget build(BuildContext context) {
    // print(job.imageUrl);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12.w)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
            width: width * 0.7,
            height: height * 0.28,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/images/jobs.png"),
                fit: BoxFit.contain,
                opacity: 0.5,
              ),
              color: Color(kLightGrey.value),
              borderRadius: BorderRadius.all(Radius.circular(12.w)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: job!.imageurl != null
                          ? NetworkImage(job!.imageurl)
                          : AssetImage('assets/images/jobs.png')
                              as ImageProvider,
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    ReusableText(
                        text: job!.company,
                        style:
                            appstyle(18, Color(kDark.value), FontWeight.w700)),
                  ],
                ),
                const HeightSpacer(
                  size: 10,
                ),
                ReusableText(
                  text: job!.title,
                  style: appstyle(16, Color(kDark.value), FontWeight.bold),
                ),
                const HeightSpacer(
                  size: 10,
                ),
                ReusableText(
                  text: job!.location,
                  style: appstyle(13, Color(kDark.value), FontWeight.normal),
                ),
                const HeightSpacer(
                  size: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: " ${job!.salary}/Monthly",
                      style: appstyle(15, Color(kDark.value), FontWeight.bold),
                    ),
                    CircleAvatar(
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          // Get.to(() => JobDetails(job: job));
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
