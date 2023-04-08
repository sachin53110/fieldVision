class SubmissionFoundDetailModel {
  bool? status;
  bool? isSubmissionFound;
  String? message;
  Data? data;

  SubmissionFoundDetailModel(
      {this.status, this.isSubmissionFound, this.message, this.data});

  SubmissionFoundDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    isSubmissionFound = json['is_submission_found'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['is_submission_found'] = this.isSubmissionFound;
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
  Submission? submission;

  Data({this.title, this.kiosk, this.submission});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    kiosk = json['kiosk'] != null ? new Kiosk.fromJson(json['kiosk']) : null;
    submission = json['submission'] != null
        ? new Submission.fromJson(json['submission'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.kiosk != null) {
      data['kiosk'] = this.kiosk!.toJson();
    }
    if (this.submission != null) {
      data['submission'] = this.submission!.toJson();
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

class Submission {
  bool? status;
  bool? submissionFound;
  String? message;
  SubmissionData? submissionData;

  Submission(
      {this.status, this.submissionFound, this.message, this.submissionData});

  Submission.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    submissionFound = json['submission_found'];
    message = json['message'];
    submissionData = json['submission_data'] != null
        ? new SubmissionData.fromJson(json['submission_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['submission_found'] = this.submissionFound;
    data['message'] = this.message;
    if (this.submissionData != null) {
      data['submission_data'] = this.submissionData!.toJson();
    }
    return data;
  }
}

class SubmissionData {
  int? id;
  int? anyRepairToday;
  dynamic reasonForNoRepairToday;
  int? additionalDamageCouldNotRepairToday;
  String? rightImage;
  String? leftImage;
  String? middleImage;
  int? isDamage;
  int? status;
  String? date;
  User? user;
  KioskDetails? kioskDetails;
  List<KioskComponentsData>? kioskComponents;

  SubmissionData(
      {this.id,
        this.anyRepairToday,
        this.reasonForNoRepairToday,
        this.additionalDamageCouldNotRepairToday,
        this.rightImage,
        this.leftImage,
        this.middleImage,
        this.isDamage,
        this.status,
        this.date,
        this.user,
        this.kioskDetails,
        this.kioskComponents});

  SubmissionData.fromJson(Map<String, dynamic> json) {
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
    date = json['date'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    kioskDetails = json['kiosk_details'] != null
        ? new KioskDetails.fromJson(json['kiosk_details'])
        : null;
    if (json['kiosk_components'] != null) {
      kioskComponents = <KioskComponentsData>[];
      json['kiosk_components'].forEach((v) {
        kioskComponents!.add(new KioskComponentsData.fromJson(v));
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
    if (this.kioskDetails != null) {
      data['kiosk_details'] = this.kioskDetails!.toJson();
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

class KioskDetails {
  int? id;
  String? serialNumber;
  String? qrCode;

  KioskDetails({this.id, this.serialNumber, this.qrCode});

  KioskDetails.fromJson(Map<String, dynamic> json) {
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

class KioskComponentsData {
  int? id;
  String? name;
  String? value;

  KioskComponentsData({this.id, this.name, this.value});

  KioskComponentsData.fromJson(Map<String, dynamic> json) {
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