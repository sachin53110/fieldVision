import 'dart:convert';

ErrorMessage statusMessageFromJson(String str) => ErrorMessage.fromJson(json.decode(str));

String statusMessageToJson(ErrorMessage data) => json.encode(data.toJson());

class ErrorMessage {
  ErrorMessage({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory ErrorMessage.fromJson(Map<String, dynamic> json) => ErrorMessage(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
