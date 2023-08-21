import 'dart:convert';

class ControlFile {
  ControlFile({
    required this.staffId,
    required this.name,
    required this.password,
  });

  int? staffId;
  String? name;
  String? password;

  factory ControlFile.fromJson(Map<String, dynamic> json) => ControlFile(
        staffId: json["staff_id"],
        name: json["name"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "staff_id": staffId,
        "name": name,
        "password": password,
      };
}

List<ControlFile> userModelFromJson(String str) => List<ControlFile>.from(
    json.decode(str).map((x) => ControlFile.fromJson(x)));

String userModelToJson(List<ControlFile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
