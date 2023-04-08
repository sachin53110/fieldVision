import 'dart:convert';

UpdateSettingModel updateSettingModelFromJson(String str) => UpdateSettingModel.fromJson(json.decode(str));

String updateSettingModelToJson(UpdateSettingModel data) => json.encode(data.toJson());

class UpdateSettingModel {
  UpdateSettingModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory UpdateSettingModel.fromJson(Map<String, dynamic> json) => UpdateSettingModel(
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
    this.setting,
  });

  Setting? setting;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    setting: json["setting"] == null ? null : Setting.fromJson(json["setting"]),
  );

  Map<String, dynamic> toJson() => {
    "setting": setting == null ? null : setting?.toJson(),
  };
}

class Setting {
  Setting({
    this.pushNotification,
    this.emailNotification,
  });

  int? pushNotification;
  int? emailNotification;

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
    pushNotification: json["push_notification"] == null ? null : json["push_notification"],
    emailNotification: json["email_notification"] == null ? null : json["email_notification"],
  );

  Map<String, dynamic> toJson() => {
    "push_notification": pushNotification == null ? null : pushNotification,
    "email_notification": emailNotification == null ? null : emailNotification,
  };
}