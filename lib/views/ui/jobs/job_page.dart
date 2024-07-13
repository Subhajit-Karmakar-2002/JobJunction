import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/models/response/jobs/jobs_response.dart';
import 'package:jobjunction/views/common/app_bar.dart';
import 'package:jobjunction/views/common/custom_outline_btn.dart';

class JobDetails extends StatefulWidget {
  const JobDetails({super.key});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomAppBar(
          actions: [
            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.bookmark,
                  size: 30,
                ),
              ),
            ),
          ],
          child: const Padding(
            padding: EdgeInsets.all(10),
            // child: BackBtn(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              children: [
                Container(
                  width: width,
                  height: height * 0.27,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Color(kLightGrey.value),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/jobs.png"),
                      opacity: 0.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          "job.imageUrl",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "job.title",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "job.location",
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomOutlineBtn(
                              color2: Color(kLight.value),
                              text: "job.contract",
                              color: Color(kOrange.value),
                            ),
                            Text(
                              " job.salary",
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "job.description",
                  maxLines: 9,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Requirement:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: height * 0.6,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Text("job.requirements[index]");
                    },
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.w),
                child: CustomOutlineBtn(
                  height: height * 0.06,
                  text: "Please Login",
                  color: Color(kLight.value),
                  color2: Color(kOrange.value),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
