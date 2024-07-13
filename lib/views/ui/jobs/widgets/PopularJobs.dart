import 'package:flutter/material.dart';
import 'package:job_finder/constants/app_constants.dart';
import 'package:job_finder/controllers/jobs_provider.dart';
import 'package:job_finder/models/response/jobs/jobs_response.dart';
import 'package:job_finder/views/common/loader.dart';
import 'package:job_finder/views/common/pages_loader.dart';
import 'package:job_finder/views/common/styled_container.dart';
import 'package:job_finder/views/screens/jobs/widgets/jobHorizontalTile.dart';
import 'package:provider/provider.dart';

class Popularjobs extends StatelessWidget {
  const Popularjobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
      builder: (context, jobnotifier, child) {
        jobnotifier.getJobs();
        print(jobnotifier.jobList);
        return SizedBox(
          height: 0.25 * hieght,
          child: FutureBuilder<List<JobsResponse>>(
            future: jobnotifier.jobList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error?.toString() ?? "Error");
              } else if (snapshot.data!.isEmpty) {
                return const NoSearchResults(text: "No Jobs Available");
              } else {
                final jobs = snapshot.data;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: jobs!.length,
                  itemBuilder: (context, index) {
                    final job = jobs[index];
                    return Jobhorizontaltile(
                      job: jobs[index],
                      onTap: () {},
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
