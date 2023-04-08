class SubmissionModel {
  bool? status;
  String? message;
  Data? data;

  SubmissionModel({this.status, this.message, this.data});

  SubmissionModel.fromJson(Map<String, dynamic> json) {
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
  List<SubmissionsData>? submissions;
  int? notificationsCount;
  Data({this.submissions});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['submissions'] != null) {
      submissions = <SubmissionsData>[];
      json['submissions'].forEach((v) {
        submissions!.add(new SubmissionsData.fromJson(v));
      });
    }
    notificationsCount = json['notifications_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.submissions != null) {
      data['submissions'] = this.submissions!.map((v) => v.toJson()).toList();
    }
    data['notifications_count'] = this.notificationsCount;
    return data;
  }
}

class SubmissionsData {
  int? id;
  int? anyRepairToday;
  dynamic reasonForNoRepairToday;
  int? additionalDamageCouldNotRepairToday;
  String? rightImage;
  String? leftImage;
  String? middleImage;
  int? isDamage;
  int? status;
  String? iconName;
  String? date;
  User? user;
  Kiosk? kiosk;
  List<KioskComponents>? kioskComponents;

  SubmissionsData(
      {this.id,
        this.anyRepairToday,
        this.reasonForNoRepairToday,
        this.additionalDamageCouldNotRepairToday,
        this.rightImage,
        this.leftImage,
        this.middleImage,
        this.isDamage,
        this.status,
        this.iconName,
        this.date,
        this.user,
        this.kiosk,
        this.kioskComponents});

  SubmissionsData.fromJson(Map<String, dynamic> json) {
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
    iconName = json['icon_name'];
    date = json['date'];
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
    data['date'] = this.date;
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
  String? firstName;
  String? lastName;

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