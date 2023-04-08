import 'dart:convert';

UpdateProfileModel updateProfileModelFromJson(String str) => UpdateProfileModel.fromJson(json.decode(str));

String updateProfileModelToJson(UpdateProfileModel data) => json.encode(data.toJson());

class UpdateProfileModel {
  UpdateProfileModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) => UpdateProfileModel(
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
  });

  User? user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user == null ? null : user?.toJson(),
  };
}

class User {
  User({
    this.firstName,
    this.lastName,
    this.email,
    this.image,
    this.password,
  });

  String? firstName;
  dynamic lastName;
  String? email;
  dynamic image;
  String? password;

  factory User.fromJson(Map<String, dynamic> json) => User(
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"],
    email: json["email"] == null ? null : json["email"],
    image: json["image"],
    password: json["password"] == null ? null : json["password"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName == null ? null : firstName,
    "last_name": lastName,
    "email": email == null ? null : email,
    "image": image,
    "password": password == null ? null : password,
  };
}