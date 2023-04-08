class VerifyKioskModel {
  bool? status;
  String? message;
  Data? data;

  VerifyKioskModel({this.status, this.message, this.data});

  VerifyKioskModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  Kiosk? kiosk;

  Data({this.title, this.kiosk});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    kiosk = json['kiosk'] != null ? new Kiosk.fromJson(json['kiosk']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.kiosk != null) {
      data['kiosk'] = this.kiosk!.toJson();
    }
    return data;
  }
}

class Kiosk {
  int? id;
  String? serialNumber;
  String? qrCode;
  String? brand;
  String? location;

  Kiosk({this.id, this.serialNumber, this.qrCode, this.brand, this.location});

  Kiosk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serialNumber = json['serial_number'];
    qrCode = json['qr_code'];
    brand = json['brand'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serial_number'] = this.serialNumber;
    data['qr_code'] = this.qrCode;
    data['brand'] = this.brand;
    data['location'] = this.location;
    return data;
  }
}