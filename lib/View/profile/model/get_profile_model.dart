// To parse this JSON data, do
//
//     final getProfileModel = getProfileModelFromJson(jsonString);
import 'dart:convert';

GetProfileModel getProfileModelFromJson(String str) => GetProfileModel.fromJson(json.decode(str));

String getProfileModelToJson(GetProfileModel data) => json.encode(data.toJson());

class GetProfileModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? password;
  dynamic confirmPassword;
  dynamic otpCode;
  bool? isActive;
  String? createdAt;
  dynamic profilePicture;
  dynamic addhomeAddress;
  dynamic addworkAddress;

  GetProfileModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.password,
    this.confirmPassword,
    this.otpCode,
    this.isActive,
    this.createdAt,
    this.profilePicture,
    this.addhomeAddress,
    this.addworkAddress,
  });

  factory GetProfileModel.fromJson(Map<String, dynamic> json) => GetProfileModel(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    password: json["password"],
    confirmPassword: json["confirm_password"],
    otpCode: json["otp_code"],
    isActive: json["is_active"],
    createdAt: json["created_at"],
    profilePicture: json["profile_picture"],
    addhomeAddress: json["addhome_address"],
    addworkAddress: json["addwork_address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone_number": phoneNumber,
    "password": password,
    "confirm_password": confirmPassword,
    "otp_code": otpCode,
    "is_active": isActive,
    "created_at": createdAt,
    "profile_picture": profilePicture,
    "addhome_address": addhomeAddress,
    "addwork_address": addworkAddress,
  };
}
