import 'package:meta/meta.dart';
import 'dart:convert';

List<AllBookMark> allBookMarkFromJson(String str) => List<AllBookMark>.from(
    json.decode(str).map((x) => AllBookMark.fromJson(x)));


class AllBookMark {
  final String id;
  final Job job;
  final String userId;

  AllBookMark({
    required this.id,
    required this.job,
    required this.userId,
  });

  factory AllBookMark.fromJson(Map<String, dynamic> json) => AllBookMark(
        id: json["_id"],
        job: Job.fromJson(json["job"]),
        userId: json["userId"],
      );


}

class Job {
  final String id;
  final String title;
  final String location;
  final String description;
  final String company;
  final String salary;
  final String period;
  final String contract;
  final List<String> requirements;
  final String imageurl;
  final String agentId;

  Job({
    required this.id,
    required this.title,
    required this.location,
    required this.description,
    required this.company,
    required this.salary,
    required this.period,
    required this.contract,
    required this.requirements,
    required this.imageurl,
    required this.agentId,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["_id"],
        title: json["title"],
        location: json["location"],
        description: json["description"],
        company: json["company"],
        salary: json["salary"],
        period: json["period"],
        contract: json["contract"],
        requirements: List<String>.from(json["requirements"].map((x) => x)),
        imageurl: json["imageurl"],
        agentId: json["agentId"],
      );
}
