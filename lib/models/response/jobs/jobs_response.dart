import 'dart:convert';

// Function to parse JSON string into a list of JobsResponse
List<JobsResponse> jobsResponseFromJson(String str) => List<JobsResponse>.from(
    json.decode(str).map((x) => JobsResponse.fromJson(x)));

class JobsResponse {
  JobsResponse({
    required this.id,
    required this.title,
    required this.location,
    required this.company,
    required this.hiring,
    required this.description,
    required this.salary,
    required this.period,
    required this.contract,
    required this.requirements,
    required this.imageurl,
    required this.agentId,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final String location;
  final String company;
  final bool hiring;
  final String description;
  final String salary;
  final String period;
  final String contract;
  final List<String> requirements;
  final String imageurl;
  final String agentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory JobsResponse.fromJson(Map<String, dynamic> json) => JobsResponse(
        id: json["_id"] ?? '',
        title: json["title"] ?? '',
        location: json["location"] ?? '',
        company: json["company"] ?? '',
        hiring: json["hiring"] ?? false,
        description: json["description"] ?? '',
        salary: json["salary"] ?? '',
        period: json["period"] ?? '',
        contract: json["contract"] ?? '',
        requirements: json["requirements"] != null
            ? List<String>.from(json["requirements"].map((x) => x))
            : [],
        imageurl: json["imageurl"] ?? '',
        agentId: json["agentId"] ?? '',
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : DateTime.now(),
      );
}
