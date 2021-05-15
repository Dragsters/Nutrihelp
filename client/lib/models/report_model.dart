import 'dart:convert';

class Report {
  String patientId;
  String patientName;
  String reportId;
  String type;
  double probability;
  Report({
    this.patientId,
    this.patientName,
    this.reportId,
    this.type,
    this.probability,
  });

  factory Report.fromJson(Map json) {
    if (json == null) return null;

    return Report(
      patientId: json['patient_id'],
      patientName: json['patient_name'],
      reportId: json['id']['\$oid'],
      type: json['type'],
      probability: json['probability'],
    );
  }

  @override
  String toString() {
    return 'Report(patientId: $patientId, patientName: $patientName, reportId: $reportId, type: $type, probability: $probability)';
  }
}

List<Report> parseReports(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Report>((json) => Report.fromJson(json)).toList();
}
