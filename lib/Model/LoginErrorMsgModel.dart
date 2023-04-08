import 'dart:convert';

LoginErrorMsgModel? loginErrorMsgModelFromJson(String str) => LoginErrorMsgModel.fromJson(json.decode(str));

String loginErrorMsgModelToJson(LoginErrorMsgModel? data) => json.encode(data!.toJson());

class LoginErrorMsgModel {
  LoginErrorMsgModel({
    this.status,
    this.title,
    this.message,
  });

  bool? status;
  String? title;
  String? message;

  factory LoginErrorMsgModel.fromJson(Map<String, dynamic> json) => LoginErrorMsgModel(
    status: json["status"],
    title: json["title"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "title": title,
    "message": message,
  };
}