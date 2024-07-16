import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:jobjunction/controllers/exports.dart';
import 'package:jobjunction/models/response/jobs/jobs_response.dart';
import 'package:jobjunction/services/helpers/jobs_helper.dart';
import 'package:jobjunction/views/common/exports.dart';
import 'package:jobjunction/views/ui/jobs/job_page.dart';
import 'package:jobjunction/views/ui/jobs/widgets/jobHorizontalTile.dart';
import 'package:jobjunction/views/ui/search/widgets/custom_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kOrange.value),
        iconTheme: IconThemeData(
          color: Color(kLight.value),
        ),
        title: CustomField(
          onEditingComplete: () {
            setState(() {});
          },
          hintText: "Search",
          controller: search,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: const Icon(
              Icons.search,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: search.text.isNotEmpty
          ? FutureBuilder<List<JobsResponse>>(
              future: JobsHelper.searchJob(search.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error occured"),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return searchLoading(
                    text: "No job Found",
                  );
                } else {
                  final job = snapshot.data;

                  return ListView.builder(
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
                  );
                }
              },
            )
          : searchLoading(text: "Start Searching for a Job"),
    );
  }
}

class searchLoading extends StatelessWidget {
  const searchLoading({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/optimized_search.png"),
            ReusableText(
              text: text,
              style: appstyle(
                20,
                Color(kDark.value),
                FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
