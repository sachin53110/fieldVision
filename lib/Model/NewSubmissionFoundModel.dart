class NewSubmissionFoundModel {
  bool? status;
  bool? isSubmissionFound;
  String? message;
  Data? data;

  NewSubmissionFoundModel(
      {this.status, this.isSubmissionFound, this.message, this.data});

  NewSubmissionFoundModel.fromJson(Map<String, dynamic> json) {
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

  Submission({this.status, this.submissionFound, this.message});

  Submission.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    submissionFound = json['submission_found'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['submission_found'] = this.submissionFound;
    data['message'] = this.message;
    return data;
  }
}