// To parse this JSON data, do
//
//     final verifyCodeModel = verifyCodeModelFromJson(jsonString);

import 'dart:convert';

VerifyCodeModel verifyCodeModelFromJson(String str) => VerifyCodeModel.fromJson(json.decode(str));

String verifyCodeModelToJson(VerifyCodeModel data) => json.encode(data.toJson());

class VerifyCodeModel {
  VerifyCodeModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory VerifyCodeModel.fromJson(Map<String, dynamic> json) => VerifyCodeModel(
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
    this.user,
    this.accessToken,
  });

  User? user;
  String? accessToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    accessToken: json["access_token"] == null ? null : json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user == null ? null : user?.toJson(),
    "access_token": accessToken == null ? null : accessToken,
  };
}

class User {
  User({
    this.firstName,
    this.lastName,
    this.email,
    this.image
  });

  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic image;

  factory User.fromJson(Map<String, dynamic> json) => User(
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"] == null ? null : json["email"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email == null ? null : email,
    "image": image == null ? null : image,
  };
}
