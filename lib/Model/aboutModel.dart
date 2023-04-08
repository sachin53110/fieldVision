import 'dart:convert';

AboutModel aboutModelFromJson(String str) => AboutModel.fromJson(json.decode(str));

String aboutModelToJson(AboutModel data) => json.encode(data.toJson());

class AboutModel {
  AboutModel({
    this.status,
    this.data,
  });

  bool? status;
  Data? data;

  factory AboutModel.fromJson(Map<String, dynamic> json) => AboutModel(
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
    this.content,
  });

  Content? content;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    content: json["content"] == null ? null : Content.fromJson(json["content"]),
  );

  Map<String, dynamic> toJson() => {
    "content": content == null ? null : content?.toJson(),
  };
}

class Content {
  Content({
    this.id,
    this.title,
    this.section,
    this.content,
    this.slug,
    this.deviceType,
    this.addedById,
    this.updatedById,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? title;
  String? section;
  String? content;
  String? slug;
  String? deviceType;
  int? addedById;
  int? updatedById;
  int? status;
  dynamic createdAt;
  dynamic updatedAt;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    section: json["section"] == null ? null : json["section"],
    content: json["content"] == null ? null : json["content"],
    slug: json["slug"] == null ? null : json["slug"],
    deviceType: json["device_type"] == null ? null : json["device_type"],
    addedById: json["added_by_id"] == null ? null : json["added_by_id"],
    updatedById: json["updated_by_id"] == null ? null : json["updated_by_id"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "section": section == null ? null : section,
    "content": content == null ? null : content,
    "slug": slug == null ? null : slug,
    "device_type": deviceType == null ? null : deviceType,
    "added_by_id": addedById == null ? null : addedById,
    "updated_by_id": updatedById == null ? null : updatedById,
    "status": status == null ? null : status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}