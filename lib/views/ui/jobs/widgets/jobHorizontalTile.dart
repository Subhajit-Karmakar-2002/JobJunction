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
                image: AssetImage("assets/images/user.png"),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // CircleAvatar(
                    //   backgroundImage: NetworkImage(job.imageUrl),
                    // ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(kLight.value),
                        borderRadius: BorderRadius.all(Radius.circular(12.w)),
                      ),
                      padding: const EdgeInsets.all(8),
                      width: width * 0.5,
                      child: Text(
                        "Google",
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const HeightSpacer(
                  size: 10,
                ),
                ReusableText(
                  text: "Flutter Job",
                  style: appstyle(16, Color(kDark.value), FontWeight.bold),
                ),
                const HeightSpacer(
                  size: 10,
                ),
                ReusableText(
                  text: "Pune",
                  style: appstyle(13, Color(kDark.value), FontWeight.normal),
                ),
                const HeightSpacer(
                  size: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: " 25k/Monthly",
                      // text: " ${job.salary}/Monthly",
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
