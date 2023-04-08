import 'dart:convert';

SettingModel settingModelFromJson(String str) => SettingModel.fromJson(json.decode(str));

String settingModelToJson(SettingModel data) => json.encode(data.toJson());

class SettingModel {
  SettingModel({
    this.status,
    this.data,
  });

  bool? status;
  Data? data;

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
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
