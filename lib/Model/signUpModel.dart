import 'dart:convert';

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  SignUpModel({
    this.status,
    this.message,
    this.email,
    this.password,
    this.sentOtp,
  });

  bool? status;
  String? message;
  String? email;
  String? password;
  int? sentOtp;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    email: json["email"] == null ? null : json["email"],
    password: json["password"] == null ? null : json["password"],
    sentOtp: json["sent_otp"] == null ? null : json["sent_otp"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "email": email == null ? null : email,
    "password": password == null ? null : password,
    "sent_otp": sentOtp == null ? null : sentOtp,
  };
}