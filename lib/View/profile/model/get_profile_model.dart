// To parse this JSON data, do
//
//     final getProfileModel = getProfileModelFromJson(jsonString);

import 'dart:convert';

GetProfileModel getProfileModelFromJson(String str) => GetProfileModel.fromJson(json.decode(str));

String getProfileModelToJson(GetProfileModel data) => json.encode(data.toJson());

class GetProfileModel {
  bool? status;
  Customer? customer;

  GetProfileModel({
    this.status,
    this.customer,
  });

  factory GetProfileModel.fromJson(Map<String, dynamic> json) => GetProfileModel(
    status: json["status"],
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "customer": customer?.toJson(),
  };
}

class Customer {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? telephone;
  dynamic fax;
  String? doorNumber;
  String? address1;
  String? address2;
  bool? blacklist;
  dynamic blacklistReason;
  String? notes;
  dynamic username;
  dynamic password;
  dynamic webDeviceId;
  dynamic mobileDeviceId;
  dynamic emailVerificationCode;
  dynamic mobileVerificationCode;
  dynamic emailVerified;
  dynamic mobileVerified;
  dynamic emailVerifiedAt;
  dynamic mobileVerifiedAt;
  bool? smsFlag;
  String? createdAt;
  dynamic otpCreatedAt;
  List<RestrictedDriver>? restrictedDrivers;

  Customer({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.telephone,
    this.fax,
    this.doorNumber,
    this.address1,
    this.address2,
    this.blacklist,
    this.blacklistReason,
    this.notes,
    this.username,
    this.password,
    this.webDeviceId,
    this.mobileDeviceId,
    this.emailVerificationCode,
    this.mobileVerificationCode,
    this.emailVerified,
    this.mobileVerified,
    this.emailVerifiedAt,
    this.mobileVerifiedAt,
    this.smsFlag,
    this.createdAt,
    this.otpCreatedAt,
    this.restrictedDrivers,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    telephone: json["telephone"],
    fax: json["fax"],
    doorNumber: json["door_number"],
    address1: json["address1"],
    address2: json["address2"],
    blacklist: json["blacklist"],
    blacklistReason: json["blacklist_reason"],
    notes: json["notes"],
    username: json["username"],
    password: json["password"],
    webDeviceId: json["web_device_id"],
    mobileDeviceId: json["mobile_device_id"],
    emailVerificationCode: json["email_verification_code"],
    mobileVerificationCode: json["mobile_verification_code"],
    emailVerified: json["email_verified"],
    mobileVerified: json["mobile_verified"],
    emailVerifiedAt: json["email_verified_at"],
    mobileVerifiedAt: json["mobile_verified_at"],
    smsFlag: json["sms_flag"],
    createdAt: json["created_at"],
    otpCreatedAt: json["otp_created_at"],
    restrictedDrivers: json["restricted_drivers"] == null ? [] : List<RestrictedDriver>.from(json["restricted_drivers"]!.map((x) => RestrictedDriver.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "telephone": telephone,
    "fax": fax,
    "door_number": doorNumber,
    "address1": address1,
    "address2": address2,
    "blacklist": blacklist,
    "blacklist_reason": blacklistReason,
    "notes": notes,
    "username": username,
    "password": password,
    "web_device_id": webDeviceId,
    "mobile_device_id": mobileDeviceId,
    "email_verification_code": emailVerificationCode,
    "mobile_verification_code": mobileVerificationCode,
    "email_verified": emailVerified,
    "mobile_verified": mobileVerified,
    "email_verified_at": emailVerifiedAt,
    "mobile_verified_at": mobileVerifiedAt,
    "sms_flag": smsFlag,
    "created_at": createdAt,
    "otp_created_at": otpCreatedAt,
    "restricted_drivers": restrictedDrivers == null ? [] : List<dynamic>.from(restrictedDrivers!.map((x) => x.toJson())),
  };
}

class RestrictedDriver {
  int? id;
  String? username;
  String? name;

  RestrictedDriver({
    this.id,
    this.username,
    this.name,
  });

  factory RestrictedDriver.fromJson(Map<String, dynamic> json) => RestrictedDriver(
    id: json["id"],
    username: json["username"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "name": name,
  };
}
