import 'dart:convert';

String updateJobsRequestToJson(UpdateJobsRequest data) =>
    json.encode(data.toJson());

class UpdateJobsRequest {
  UpdateJobsRequest({
    this.title,
    this.location,
    this.company,
    this.hiring,
    this.description,
    this.salary,
    this.period,
    this.contract,
    this.imageurl,
    this.agentId,
    this.requirements,
  });

  final String? title;
  final String? location;
  final String? company;
  final bool? hiring;
  final String? description;
  final String? salary;
  final String? period;
  final String? contract;
  final String? imageurl;
  final String? agentId;
  final List<String>? requirements;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (title != null) data['title'] = title;
    if (location != null) data['location'] = location;
    if (company != null) data['company'] = company;
    if (hiring != null) data['hiring'] = hiring;
    if (description != null) data['description'] = description;
    if (salary != null) data['salary'] = salary;
    if (period != null) data['period'] = period;
    if (contract != null) data['contract'] = contract;
    if (imageurl != null) data['imageurl'] = imageurl;
    if (agentId != null) data['agentId'] = agentId;
    if (requirements != null)
      data['requirements'] = List<dynamic>.from(requirements!.map((x) => x));
    return data;
  }
}
