class KioskDetailModel {
  bool? status;
  String? message;
  Data? data;

  KioskDetailModel({this.status, this.message, this.data});

  KioskDetailModel.fromJson(Map<String, dynamic> json) {
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
  Kiosk? kiosk;

  Data({this.kiosk});

  Data.fromJson(Map<String, dynamic> json) {
    kiosk = json['kiosk'] != null ? new Kiosk.fromJson(json['kiosk']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.kiosk != null) {
      data['kiosk'] = this.kiosk!.toJson();
    }
    return data;
  }
}

class Kiosk {
  int? id;
  String? serialNumber;
  String? brand;
  String? location;
  dynamic timestamp;

  Kiosk(
      {this.id, this.serialNumber, this.brand, this.location, this.timestamp});

  Kiosk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serialNumber = json['serial_number'];
    brand = json['brand'];
    location = json['location'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serial_number'] = this.serialNumber;
    data['brand'] = this.brand;
    data['location'] = this.location;
    data['timestamp'] = this.timestamp;
    return data;
  }
}