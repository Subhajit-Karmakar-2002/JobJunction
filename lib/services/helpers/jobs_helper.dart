import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:jobjunction/models/response/jobs/get_job.dart';
import 'package:jobjunction/models/response/jobs/jobs_response.dart';
import 'package:jobjunction/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobsHelper {
  static var client = https.Client();

  static Future<List<JobsResponse>> getJobs() async {
    Map<String, String> requestHeaders = {'Content-type': 'application/json'};
    var url = Uri.https(Config.apiUrl, Config.job);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jobList = jobsResponseFromJson(response.body);
      return jobList;
    } else {
      throw Exception("Failed to get the Job");
    }
  }

  static Future<GetJobRes> getJob(String jobid) async {
    Map<String, String> requestHeaders = {'Content-type': 'application/json'};
    var url = Uri.https(Config.apiUrl, "${Config.job}/$jobid");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var job = getJobResFromJson(response.body);
      return job;
    } else {
      throw Exception("Failed to get a Job");
    }
  }

  static Future<JobsResponse> getRecent() async {
    Map<String, String> requestHeaders = {'Content-type': 'application/json'};
    var url = Uri.https(Config.apiUrl, Config.job);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jobs = jobsResponseFromJson(response.body);
      var recentJobs = jobs.first;
      return recentJobs;
    } else {
      throw Exception("Failed to get the Job");
    }
  }


  
  static Future<List<JobsResponse>> searchJob(String key) async {
    Map<String, String> requestHeaders = {'Content-type': 'application/json'};
    var url = Uri.https(Config.apiUrl, "${Config.search}/$key");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jobList = jobsResponseFromJson(response.body);
      return jobList;
    } else {
      throw Exception("Failed to get the Job");
    }
  }
}
