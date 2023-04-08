class IntroModel {
  bool? status;
  String? message;
  List<ContentData>? data;

  IntroModel({this.status, this.message, this.data});

  IntroModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ContentData>[];
      json['data'].forEach((v) {
        data!.add(new ContentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContentData {
  String? title;
  String? description;
  String? lightImage;
  String? darkImage;

  ContentData({this.title, this.description, this.lightImage, this.darkImage});

  ContentData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    lightImage = json['light_image'];
    darkImage = json['dark_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['light_image'] = this.lightImage;
    data['dark_image'] = this.darkImage;
    return data;
  }
}