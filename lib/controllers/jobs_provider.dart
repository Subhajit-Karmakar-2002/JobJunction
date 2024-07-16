import 'package:flutter/foundation.dart';
import 'package:jobjunction/models/response/jobs/get_job.dart';
import 'package:jobjunction/models/response/jobs/jobs_response.dart';
import 'package:jobjunction/services/helpers/jobs_helper.dart';

class JobsNotifier extends ChangeNotifier {
  late Future<List<JobsResponse>> joblist;
  late Future<JobsResponse> recentlist;
  late Future<GetJobRes> job;

  getJobs() {
    joblist = JobsHelper.getJobs();
  }

  getJob(String jobid) {
    job = JobsHelper.getJob(jobid);
  }

  getRecent() {
    recentlist = JobsHelper.getRecent();
  }
}
