class NewSubmissionModel {
  bool? status;
  String? message;
  Data? data;

  NewSubmissionModel({this.status, this.message, this.data});

  NewSubmissionModel.fromJson(Map<String, dynamic> json) {
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
  Submission? submission;

  Data({this.submission});

  Data.fromJson(Map<String, dynamic> json) {
    submission = json['submission'] != null
        ? new Submission.fromJson(json['submission'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.submission != null) {
      data['submission'] = this.submission!.toJson();
    }
    return data;
  }
}

class Submission {
  int? id;
  int? anyRepairToday;
  dynamic reasonForNoRepairToday;
  int? additionalDamageCouldNotRepairToday;
  String? rightImage;
  String? leftImage;
  String? middleImage;
  int? isDamage;
  int? status;
  User? user;
  Kiosk? kiosk;
  List<KioskComponents>? kioskComponents;

  Submission(
      {this.id,
        this.anyRepairToday,
        this.reasonForNoRepairToday,
        this.additionalDamageCouldNotRepairToday,
        this.rightImage,
        this.leftImage,
        this.middleImage,
        this.isDamage,
        this.status,
        this.user,
        this.kiosk,
        this.kioskComponents});

  Submission.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    anyRepairToday = json['any_repair_today'];
    reasonForNoRepairToday = json['reason_for_no_repair_today'];
    additionalDamageCouldNotRepairToday =
    json['additional_damage_could_not_repair_today'];
    rightImage = json['right_image'];
    leftImage = json['left_image'];
    middleImage = json['middle_image'];
    isDamage = json['is_damage'];
    status = json['status'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    kiosk = json['kiosk'] != null ? new Kiosk.fromJson(json['kiosk']) : null;
    if (json['kiosk_components'] != null) {
      kioskComponents = <KioskComponents>[];
      json['kiosk_components'].forEach((v) {
        kioskComponents!.add(new KioskComponents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['any_repair_today'] = this.anyRepairToday;
    data['reason_for_no_repair_today'] = this.reasonForNoRepairToday;
    data['additional_damage_could_not_repair_today'] =
        this.additionalDamageCouldNotRepairToday;
    data['right_image'] = this.rightImage;
    data['left_image'] = this.leftImage;
    data['middle_image'] = this.middleImage;
    data['is_damage'] = this.isDamage;
    data['status'] = this.status;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.kiosk != null) {
      data['kiosk'] = this.kiosk!.toJson();
    }
    if (this.kioskComponents != null) {
      data['kiosk_components'] =
          this.kioskComponents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  dynamic firstName;
  dynamic lastName;

  User({this.id, this.firstName, this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class Kiosk {
  int? id;
  String? serialNumber;
  String? qrCode;

  Kiosk({this.id, this.serialNumber, this.qrCode});

  Kiosk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serialNumber = json['serial_number'];
    qrCode = json['qr_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serial_number'] = this.serialNumber;
    data['qr_code'] = this.qrCode;
    return data;
  }
}

class KioskComponents {
  int? id;
  String? name;
  String? value;

  KioskComponents({this.id, this.name, this.value});

  KioskComponents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}