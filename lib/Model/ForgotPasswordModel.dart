import 'dart:convert';

ForgotPasswordModel? forgotPasswordModelFromJson(String str) => ForgotPasswordModel.fromJson(json.decode(str));

String forgotPasswordModelToJson(ForgotPasswordModel? data) => json.encode(data!.toJson());

class ForgotPasswordModel {
  ForgotPasswordModel({
    this.status,
    this.token,
    this.message,
  });

  bool? status;
  String? token;
  String? message;

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) => ForgotPasswordModel(
    status: json["status"],
    token: json["token"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "token": token,
    "message": message,
  };
}