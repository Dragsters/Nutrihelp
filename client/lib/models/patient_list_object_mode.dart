import 'dart:convert';

class Patient {
  int age;
  String gender;
  String name;
  String mobile;
  String id;
  Patient({
    this.age,
    this.gender,
    this.name,
    this.mobile,
    this.id,
  });

  factory Patient.fromJson(Map json) {
    if (json == null) return null;

    return Patient(
      age: json['age'] as int,
      gender: json['gender'] as String,
      name: json['name'] as String,
      mobile: json['mobile'] as String,
      id: json['id']['\$oid'] as String,
    );
  }

  @override
  String toString() {
    return 'Patient(age: $age, gender: $gender, name: $name, mobile: $mobile, id: $id)';
  }
}

List<Patient> parsePatients(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Patient>((json) => Patient.fromJson(json)).toList();
}
