import 'package:get/get.dart';

class KioskComponentsModel {
  bool? status;
  String? message;
  Data? data;

  KioskComponentsModel({this.status, this.message, this.data});

  KioskComponentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<KioskComponentsList>? kioskComponents;

  Data({this.kioskComponents});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['kiosk_components'] != null) {
      kioskComponents = <KioskComponentsList>[];
      json['kiosk_components'].forEach((v) {
        kioskComponents!.add(new KioskComponentsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.kioskComponents != null) {
      data['kiosk_components'] =
          this.kioskComponents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class KioskComponentsList {
  int? id;
  String? name;
  String? otherText;
  String? slug;
  RxBool selected=false.obs;
  List<LockDoorModel>? lockDoor = [
    LockDoorModel(name: 1.obs, select: false.obs ),
    LockDoorModel(name: 2.obs, select: false.obs),
    LockDoorModel(name: 3.obs, select: false.obs),
    LockDoorModel(name: 4.obs, select: false.obs),
    LockDoorModel(name: 5.obs, select: false.obs),
    LockDoorModel(name: 6.obs, select: false.obs),
    LockDoorModel(name: 7.obs, select: false.obs),
    LockDoorModel(name: 8.obs, select: false.obs),
  ];

  KioskComponentsList({this.id, this.name, this.slug,this.lockDoor, this. otherText});

  KioskComponentsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }

}


class LockDoorModel{
  RxInt? name;
  RxBool? select=false.obs;
  LockDoorModel({this.name,this.select});
}
