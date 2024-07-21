import 'package:flutter/foundation.dart';
import 'package:jobjunction/models/request/jobs/create_job.dart';
import 'package:jobjunction/models/request/updateJobModel.dart';
import 'package:jobjunction/models/response/jobs/get_job.dart';
import 'package:jobjunction/models/response/jobs/jobs_response.dart';
import 'package:jobjunction/services/helpers/jobs_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobsNotifier extends ChangeNotifier {
  late Future<List<JobsResponse>> joblist;
  late Future<JobsResponse> recentlist;
  late Future<List<JobsResponse>> agentjoblist;
  late Future<GetJobRes> job;

  late String _userid = "";

  String get userid => _userid;

  set userid(String lastpage) {
    _userid = lastpage;
    notifyListeners();
  }

  bool _isHiring = true;
  bool get isHiring => _isHiring;
  set isHiring(bool val) {
    _isHiring = val;
    notifyListeners();
  }

  getprefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('userId');
    userid = uid!;

    // notifyListeners();
  }

  getJobs() {
    joblist = JobsHelper.getJobs();
  }

  getAgentJob() {
    agentjoblist = JobsHelper.getAgentJobs(userid);
  }

  getJob(String jobid) {
    job = JobsHelper.getJob(jobid);
  }

  getRecent() {
    recentlist = JobsHelper.getRecent();
  }
}
