import 'dart:convert';

StatusMessage statusMessageFromJson(String str) => StatusMessage.fromJson(json.decode(str));

String statusMessageToJson(StatusMessage data) => json.encode(data.toJson());

class StatusMessage {
  StatusMessage({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory StatusMessage.fromJson(Map<String, dynamic> json) => StatusMessage(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
