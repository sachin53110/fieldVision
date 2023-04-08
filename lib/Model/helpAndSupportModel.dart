import 'dart:convert';

HelpAndSupportModel helpAndSupportModelFromJson(String str) => HelpAndSupportModel.fromJson(json.decode(str));

String helpAndSupportModelToJson(HelpAndSupportModel data) => json.encode(data.toJson());

class HelpAndSupportModel {
  HelpAndSupportModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory HelpAndSupportModel.fromJson(Map<String, dynamic> json) => HelpAndSupportModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data?.toJson(),
  };
}

class Data {
  Data({
    this.helpAndSupport,
  });

  HelpAndSupport? helpAndSupport;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    helpAndSupport: json["helpAndSupport"] == null ? null : HelpAndSupport.fromJson(json["helpAndSupport"]),
  );

  Map<String, dynamic> toJson() => {
    "helpAndSupport": helpAndSupport == null ? null : helpAndSupport?.toJson(),
  };
}

class HelpAndSupport {
  HelpAndSupport({
    this.subject,
    this.description,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? subject;
  String? description;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory HelpAndSupport.fromJson(Map<String, dynamic> json) => HelpAndSupport(
    subject: json["subject"] == null ? null : json["subject"],
    description: json["description"] == null ? null : json["description"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "subject": subject == null ? null : subject,
    "description": description == null ? null : description,
    "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
    "id": id == null ? null : id,
  };
}