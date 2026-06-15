// To parse this JSON data, do
//
//     final driverGetbyId = driverGetbyIdFromJson(jsonString);

import 'dart:convert';

DriverGetbyId driverGetbyIdFromJson(String str) => DriverGetbyId.fromJson(json.decode(str));

String driverGetbyIdToJson(DriverGetbyId data) => json.encode(data.toJson());

class DriverGetbyId {
  bool status;
  Driver driver;

  DriverGetbyId({
    required this.status,
    required this.driver,
  });

  factory DriverGetbyId.fromJson(Map<String, dynamic> json) => DriverGetbyId(
    status: json["status"],
    driver: Driver. fromJson(json["driver"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "driver": driver.toJson(),
  };
}

class Driver {
  int id;
  int subsidiaryId;
  String username;
  String password;
  String name;
  String email;
  String mobile;
  String telephone;
  String address;
  String dob;
  String driverType;
  String driverCommission;
  String rentLimit;
  bool rentPaid;
  String balance;
  bool hasPda;
  bool useCompanyVehicle;
  bool active;
  String startDate;
  String endDate;
  dynamic licenceNumber;
  String licenceExpiry;
  dynamic phcDriverNumber;
  String phcDriverExpiry;
  dynamic insuranceNumber;
  String insuranceExpiry;
  dynamic rentalAgreementNumber;
  String rentalAgreementExpiry;
  dynamic roadTaxNumber;
  String roadTaxExpiry;
  dynamic v5RegistrationNumber;
  String v5RegistrationExpiry;
  dynamic motNumber;
  String motExpiry;
  dynamic mot2Number;
  String mot2Expiry;
  dynamic phcVehicleNumber;
  String phcVehicleExpiry;
  String ni;
  String image;
  String createdAt;
  int vehicleId;
  String driverStatus;
  String sessionStatus;
  String bookingStatus;
  String latitude;
  String longitude;
  dynamic webDeviceId;
  dynamic mobileDeviceId;
  dynamic lastBooking;
  dynamic lastVehicle;
  List<Note> notes;
  dynamic zone;
  int rank;
  dynamic waitingTime;
  dynamic zoneUpdatedAt;
  dynamic os;
  dynamic version;
  String sinBinTimer;
  dynamic position;
  String pdaRent;
  dynamic companyVehicleId;
  String licenceExpiryTime;
  String phcDriverExpiryTime;
  String insuranceExpiryTime;
  String phcVehicleExpiryTime;
  String motExpiryTime;
  String mot2ExpiryTime;
  String v5RegistrationExpiryTime;
  String roadTaxExpiryTime;
  String rentalAgreementExpiryTime;
  String driverAccessToken;
  int companyId;
  dynamic fcmToken;
  String fcmUpdatedAt;
  dynamic lastLoginAt;
  String subsidiaryName;
  List<Shift> shifts;
  Vehicle vehicle;

  Driver({
    required this.id,
    required this.subsidiaryId,
    required this.username,
    required this.password,
    required this.name,
    required this.email,
    required this.mobile,
    required this.telephone,
    required this.address,
    required this.dob,
    required this.driverType,
    required this.driverCommission,
    required this.rentLimit,
    required this.rentPaid,
    required this.balance,
    required this.hasPda,
    required this.useCompanyVehicle,
    required this.active,
    required this.startDate,
    required this.endDate,
    required this.licenceNumber,
    required this.licenceExpiry,
    required this.phcDriverNumber,
    required this.phcDriverExpiry,
    required this.insuranceNumber,
    required this.insuranceExpiry,
    required this.rentalAgreementNumber,
    required this.rentalAgreementExpiry,
    required this.roadTaxNumber,
    required this.roadTaxExpiry,
    required this.v5RegistrationNumber,
    required this.v5RegistrationExpiry,
    required this.motNumber,
    required this.motExpiry,
    required this.mot2Number,
    required this.mot2Expiry,
    required this.phcVehicleNumber,
    required this.phcVehicleExpiry,
    required this.ni,
    required this.image,
    required this.createdAt,
    required this.vehicleId,
    required this.driverStatus,
    required this.sessionStatus,
    required this.bookingStatus,
    required this.latitude,
    required this.longitude,
    required this.webDeviceId,
    required this.mobileDeviceId,
    required this.lastBooking,
    required this.lastVehicle,
    required this.notes,
    required this.zone,
    required this.rank,
    required this.waitingTime,
    required this.zoneUpdatedAt,
    required this.os,
    required this.version,
    required this.sinBinTimer,
    required this.position,
    required this.pdaRent,
    required this.companyVehicleId,
    required this.licenceExpiryTime,
    required this.phcDriverExpiryTime,
    required this.insuranceExpiryTime,
    required this.phcVehicleExpiryTime,
    required this.motExpiryTime,
    required this.mot2ExpiryTime,
    required this.v5RegistrationExpiryTime,
    required this.roadTaxExpiryTime,
    required this.rentalAgreementExpiryTime,
    required this.driverAccessToken,
    required this.companyId,
    required this.fcmToken,
    required this.fcmUpdatedAt,
    required this.lastLoginAt,
    required this.subsidiaryName,
    required this.shifts,
    required this.vehicle,
  });
  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    id: json["id"] ?? 0,
    subsidiaryId: json["subsidiary_id"] ?? 0,
    username: json["username"] ?? "",
    password: json["password"] ?? "",
    name: json["name"] ?? "",
    email: json["email"] ?? "",
    mobile: json["mobile"] ?? "",
    telephone: json["telephone"] ?? "",
    address: json["address"] ?? "",
    dob: json["dob"] ?? "",
    driverType: json["driver_type"] ?? "",
    driverCommission: json["driver_commission"]?.toString() ?? "",
    rentLimit: json["rent_limit"]?.toString() ?? "",
    rentPaid: json["rent_paid"] ?? false,
    balance: json["balance"]?.toString() ?? "",
    hasPda: json["has_pda"] ?? false,
    useCompanyVehicle: json["use_company_vehicle"] ?? false,
    active: json["active"] ?? false,
    startDate: json["start_date"] ?? "",
    endDate: json["end_date"] ?? "",
    licenceNumber: json["licence_number"],
    licenceExpiry: json["licence_expiry"] ?? "",
    phcDriverNumber: json["phc_driver_number"],
    phcDriverExpiry: json["phc_driver_expiry"] ?? "",
    insuranceNumber: json["insurance_number"],
    insuranceExpiry: json["insurance_expiry"] ?? "",
    rentalAgreementNumber: json["rental_agreement_number"],
    rentalAgreementExpiry: json["rental_agreement_expiry"] ?? "",
    roadTaxNumber: json["road_tax_number"],
    roadTaxExpiry: json["road_tax_expiry"] ?? "",
    v5RegistrationNumber: json["v5_registration_number"],
    v5RegistrationExpiry: json["v5_registration_expiry"] ?? "",
    motNumber: json["mot_number"],
    motExpiry: json["mot_expiry"] ?? "",
    mot2Number: json["mot2_number"],
    mot2Expiry: json["mot2_expiry"] ?? "",
    phcVehicleNumber: json["phc_vehicle_number"],
    phcVehicleExpiry: json["phc_vehicle_expiry"] ?? "",
    ni: json["ni"] ?? "",
    image: json["image"] ?? "",
    createdAt: json["created_at"] ?? "",
    vehicleId: json["vehicle_id"] ?? 0,
    driverStatus: json["driver_status"] ?? "",
    sessionStatus: json["session_status"] ?? "",
    bookingStatus: json["booking_status"] ?? "",
    latitude: json["latitude"]?.toString() ?? "",
    longitude: json["longitude"]?.toString() ?? "",
    webDeviceId: json["web_device_id"],
    mobileDeviceId: json["mobile_device_id"],
    lastBooking: json["last_booking"],
    lastVehicle: json["last_vehicle"],
    notes: json["notes"] == null
        ? []
        : List<Note>.from(
        json["notes"].map((x) => Note.fromJson(x))),
    zone: json["zone"],
    rank: json["rank"] ?? 0,
    waitingTime: json["waiting_time"],
    zoneUpdatedAt: json["zone_updated_at"],
    os: json["os"],
    version: json["version"],
    sinBinTimer: json["sin_bin_timer"] ?? "",
    position: json["position"],
    pdaRent: json["pda_rent"]?.toString() ?? "",
    companyVehicleId: json["company_vehicle_id"],
    licenceExpiryTime: json["licence_expiry_time"] ?? "",
    phcDriverExpiryTime: json["phc_driver_expiry_time"] ?? "",
    insuranceExpiryTime: json["insurance_expiry_time"] ?? "",
    phcVehicleExpiryTime: json["phc_vehicle_expiry_time"] ?? "",
    motExpiryTime: json["mot_expiry_time"] ?? "",
    mot2ExpiryTime: json["mot2_expiry_time"] ?? "",
    v5RegistrationExpiryTime:
    json["v5_registration_expiry_time"] ?? "",
    roadTaxExpiryTime: json["road_tax_expiry_time"] ?? "",
    rentalAgreementExpiryTime:
    json["rental_agreement_expiry_time"] ?? "",
    driverAccessToken: json["driver_access_token"] ?? "",
    companyId: json["company_id"] ?? 0,
    fcmToken: json["fcm_token"],
    fcmUpdatedAt: json["fcm_updated_at"] ?? "",
    lastLoginAt: json["last_login_at"],
    subsidiaryName: json["subsidiary_name"] ?? "",
    shifts: json["shifts"] == null
        ? []
        : List<Shift>.from(
        json["shifts"].map((x) => Shift.fromJson(x))),
    vehicle: Vehicle.fromJson(json["vehicle"]),
  );
  // factory Driver.fromJson(Map<String, dynamic> json) => Driver(
  //   id: json["id"],
  //   subsidiaryId: json["subsidiary_id"],
  //   username: json["username"],
  //   password: json["password"],
  //   name: json["name"],
  //   email: json["email"],
  //   mobile: json["mobile"],
  //   telephone: json["telephone"],
  //   address: json["address"],
  //   dob: json["dob"],
  //   driverType: json["driver_type"],
  //   driverCommission: json["driver_commission"],
  //   rentLimit: json["rent_limit"],
  //   rentPaid: json["rent_paid"],
  //   balance: json["balance"],
  //   hasPda: json["has_pda"],
  //   useCompanyVehicle: json["use_company_vehicle"],
  //   active: json["active"],
  //   startDate: json["start_date"],
  //   endDate: json["end_date"],
  //   licenceNumber: json["licence_number"],
  //   licenceExpiry: json["licence_expiry"],
  //   phcDriverNumber: json["phc_driver_number"],
  //   phcDriverExpiry: json["phc_driver_expiry"],
  //   insuranceNumber: json["insurance_number"],
  //   insuranceExpiry: json["insurance_expiry"],
  //   rentalAgreementNumber: json["rental_agreement_number"],
  //   rentalAgreementExpiry: json["rental_agreement_expiry"],
  //   roadTaxNumber: json["road_tax_number"],
  //   roadTaxExpiry: json["road_tax_expiry"],
  //   v5RegistrationNumber: json["v5_registration_number"],
  //   v5RegistrationExpiry: json["v5_registration_expiry"],
  //   motNumber: json["mot_number"],
  //   motExpiry: json["mot_expiry"],
  //   mot2Number: json["mot2_number"],
  //   mot2Expiry: json["mot2_expiry"],
  //   phcVehicleNumber: json["phc_vehicle_number"],
  //   phcVehicleExpiry: json["phc_vehicle_expiry"],
  //   ni: json["ni"] ?? "",
  //   image: json["image"],
  //   createdAt: json["created_at"],
  //   vehicleId: json["vehicle_id"],
  //   driverStatus: json["driver_status"],
  //   sessionStatus: json["session_status"],
  //   bookingStatus: json["booking_status"],
  //   latitude: json["latitude"],
  //   longitude: json["longitude"],
  //   webDeviceId: json["web_device_id"],
  //   mobileDeviceId: json["mobile_device_id"],
  //   lastBooking: json["last_booking"],
  //   lastVehicle: json["last_vehicle"],
  //   notes: List<Note>.from(json["notes"].map((x) => Note.fromJson(x))),
  //   zone: json["zone"],
  //   rank: json["rank"],
  //   waitingTime: json["waiting_time"],
  //   zoneUpdatedAt: json["zone_updated_at"],
  //   os: json["os"],
  //   version: json["version"],
  //   sinBinTimer: json["sin_bin_timer"],
  //   position: json["position"],
  //   pdaRent: json["pda_rent"],
  //   companyVehicleId: json["company_vehicle_id"],
  //   licenceExpiryTime: json["licence_expiry_time"],
  //   phcDriverExpiryTime: json["phc_driver_expiry_time"],
  //   insuranceExpiryTime: json["insurance_expiry_time"],
  //   phcVehicleExpiryTime: json["phc_vehicle_expiry_time"],
  //   motExpiryTime: json["mot_expiry_time"],
  //   mot2ExpiryTime: json["mot2_expiry_time"],
  //   v5RegistrationExpiryTime: json["v5_registration_expiry_time"],
  //   roadTaxExpiryTime: json["road_tax_expiry_time"],
  //   rentalAgreementExpiryTime: json["rental_agreement_expiry_time"],
  //   driverAccessToken: json["driver_access_token"],
  //   companyId: json["company_id"],
  //   fcmToken: json["fcm_token"],
  //   fcmUpdatedAt: json["fcm_updated_at"],
  //   lastLoginAt: json["last_login_at"],
  //   subsidiaryName: json["subsidiary_name"],
  //   shifts: List<Shift>.from(json["shifts"].map((x) => Shift.fromJson(x))),
  //   vehicle: Vehicle.fromJson(json["vehicle"]),
  // );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subsidiary_id": subsidiaryId,
    "username": username,
    "password": password,
    "name": name,
    "email": email,
    "mobile": mobile,
    "telephone": telephone,
    "address": address,
    "dob": dob,
    "driver_type": driverType,
    "driver_commission": driverCommission,
    "rent_limit": rentLimit,
    "rent_paid": rentPaid,
    "balance": balance,
    "has_pda": hasPda,
    "use_company_vehicle": useCompanyVehicle,
    "active": active,
    "start_date": startDate,
    "end_date": endDate,
    "licence_number": licenceNumber,
    "licence_expiry": licenceExpiry,
    "phc_driver_number": phcDriverNumber,
    "phc_driver_expiry": phcDriverExpiry,
    "insurance_number": insuranceNumber,
    "insurance_expiry": insuranceExpiry,
    "rental_agreement_number": rentalAgreementNumber,
    "rental_agreement_expiry": rentalAgreementExpiry,
    "road_tax_number": roadTaxNumber,
    "road_tax_expiry": roadTaxExpiry,
    "v5_registration_number": v5RegistrationNumber,
    "v5_registration_expiry": v5RegistrationExpiry,
    "mot_number": motNumber,
    "mot_expiry": motExpiry,
    "mot2_number": mot2Number,
    "mot2_expiry": mot2Expiry,
    "phc_vehicle_number": phcVehicleNumber,
    "phc_vehicle_expiry": phcVehicleExpiry,
    "ni": ni,
    "image": image,
    "created_at": createdAt,
    "vehicle_id": vehicleId,
    "driver_status": driverStatus,
    "session_status": sessionStatus,
    "booking_status": bookingStatus,
    "latitude": latitude,
    "longitude": longitude,
    "web_device_id": webDeviceId,
    "mobile_device_id": mobileDeviceId,
    "last_booking": lastBooking,
    "last_vehicle": lastVehicle,
    "notes": List<dynamic>.from(notes.map((x) => x.toJson())),
    "zone": zone,
    "rank": rank,
    "waiting_time": waitingTime,
    "zone_updated_at": zoneUpdatedAt,
    "os": os,
    "version": version,
    "sin_bin_timer": sinBinTimer,
    "position": position,
    "pda_rent": pdaRent,
    "company_vehicle_id": companyVehicleId,
    "licence_expiry_time": licenceExpiryTime,
    "phc_driver_expiry_time": phcDriverExpiryTime,
    "insurance_expiry_time": insuranceExpiryTime,
    "phc_vehicle_expiry_time": phcVehicleExpiryTime,
    "mot_expiry_time": motExpiryTime,
    "mot2_expiry_time": mot2ExpiryTime,
    "v5_registration_expiry_time": v5RegistrationExpiryTime,
    "road_tax_expiry_time": roadTaxExpiryTime,
    "rental_agreement_expiry_time": rentalAgreementExpiryTime,
    "driver_access_token": driverAccessToken,
    "company_id": companyId,
    "fcm_token": fcmToken,
    "fcm_updated_at": fcmUpdatedAt,
    "last_login_at": lastLoginAt,
    "subsidiary_name": subsidiaryName,
    "shifts": List<dynamic>.from(shifts.map((x) => x.toJson())),
    "vehicle": vehicle.toJson(),
  };
}

class Note {
  int id;
  String note;
  String createdAt;
  String createdBy;

  Note({
    required this.id,
    required this.note,
    required this.createdAt,
    required this.createdBy,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    id: json["id"],
    note: json["note"],
    createdAt: json["created_at"],
    createdBy: json["created_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "note": note,
    "created_at": createdAt,
    "created_by": createdBy,
  };
}

class Shift {
  int id;
  String name;
  String startTime;
  String endTime;

  Shift({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
  });

  factory Shift.fromJson(Map<String, dynamic> json) => Shift(
    id: json["id"],
    name: json["name"],
    startTime: json["start_time"],
    endTime: json["end_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "start_time": startTime,
    "end_time": endTime,
  };
}

class Vehicle {
  int id;
  int vehicleTypeId;
  String vehicleNumber;
  String make;
  String model;
  String color;
  String owner;
  dynamic startDate;
  dynamic endDate;
  bool company;
  bool assigned;
  LogBook logBook;
  Mot mot;
  Mot2 mot2;
  Insurance insurance;
  PhcVehicle phcVehicle;
  RoadTax roadTax;
  RentalAgreement rentalAgreement;
  V5Registration v5Registration;
  Licence licence;
  PhcDriver phcDriver;
  VehicleType vehicleType;

  Vehicle({
    required this.id,
    required this.vehicleTypeId,
    required this.vehicleNumber,
    required this.make,
    required this.model,
    required this.color,
    required this.owner,
    required this.startDate,
    required this.endDate,
    required this.company,
    required this.assigned,
    required this.logBook,
    required this.mot,
    required this.mot2,
    required this.insurance,
    required this.phcVehicle,
    required this.roadTax,
    required this.rentalAgreement,
    required this.v5Registration,
    required this.licence,
    required this.phcDriver,
    required this.vehicleType,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    id: json["id"]?? "",
    vehicleTypeId: json["vehicle_type_id"]?? "",
    vehicleNumber: json["vehicle_number"]?? "",
    make: json["make"]?? "",
    model: json["model"]?? "",
    color: json["color"]?? "",
    owner: json["owner"]?? "",
    startDate: json["start_date"]?? "",
    endDate: json["end_date"]?? "",
    company: json["company"]?? "",
    assigned: json["assigned"]?? "",
    logBook: LogBook.fromJson(json["log_book"]?? ""),
    mot: Mot.fromJson(json["mot"]?? ""),
    mot2: Mot2.fromJson(json["mot2"]?? ""),
    insurance: Insurance.fromJson(json["insurance"]?? ""),
    phcVehicle: PhcVehicle.fromJson(json["phc_vehicle"]?? ""),
    roadTax: RoadTax.fromJson(json["road_tax"]?? ""),
    rentalAgreement: RentalAgreement.fromJson(json["rental_agreement"]?? ""),
    v5Registration: V5Registration.fromJson(json["v5_registration"]?? ""),
    licence: Licence.fromJson(json["licence"]?? ""),
    phcDriver: PhcDriver.fromJson(json["phc_driver"]?? ""),
    vehicleType: VehicleType.fromJson(json["vehicle_type"]?? ""),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vehicle_type_id": vehicleTypeId,
    "vehicle_number": vehicleNumber,
    "make": make,
    "model": model,
    "color": color,
    "owner": owner,
    "start_date": startDate,
    "end_date": endDate,
    "company": company,
    "assigned": assigned,
    "log_book": logBook.toJson(),
    "mot": mot.toJson(),
    "mot2": mot2.toJson(),
    "insurance": insurance.toJson(),
    "phc_vehicle": phcVehicle.toJson(),
    "road_tax": roadTax.toJson(),
    "rental_agreement": rentalAgreement.toJson(),
    "v5_registration": v5Registration.toJson(),
    "licence": licence.toJson(),
    "phc_driver": phcDriver.toJson(),
    "vehicle_type": vehicleType.toJson(),
  };
}

class Insurance {
  dynamic insuranceNumber;
  DateTime insuranceExpiry;
  String insuranceExpiryTime;
  String insuranceDocument;

  Insurance({
    required this.insuranceNumber,
    required this.insuranceExpiry,
    required this.insuranceExpiryTime,
    required this.insuranceDocument,
  });

  factory Insurance.fromJson(Map<String, dynamic> json) => Insurance(
    insuranceNumber: json["insurance_number"]?? "",
    insuranceExpiry: DateTime.parse(json["insurance_expiry"]?? ""),
    insuranceExpiryTime: json["insurance_expiry_time"]?? "",
    insuranceDocument: json["insurance_document"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "insurance_number": insuranceNumber,
    "insurance_expiry": "${insuranceExpiry.year.toString().padLeft(4, '0')}-${insuranceExpiry.month.toString().padLeft(2, '0')}-${insuranceExpiry.day.toString().padLeft(2, '0')}",
    "insurance_expiry_time": insuranceExpiryTime,
    "insurance_document": insuranceDocument,
  };
}

class Licence {
  dynamic licenceNumber;
  DateTime licenceExpiry;
  String licenceExpiryTime;
  String licenceDocument;

  Licence({
    required this.licenceNumber,
    required this.licenceExpiry,
    required this.licenceExpiryTime,
    required this.licenceDocument,
  });

  factory Licence.fromJson(Map<String, dynamic> json) => Licence(
    licenceNumber: json["licence_number"]?? "",
    licenceExpiry: DateTime.parse(json["licence_expiry"]?? ""),
    licenceExpiryTime: json["licence_expiry_time"]?? "",
    licenceDocument: json["licence_document"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "licence_number": licenceNumber,
    "licence_expiry": "${licenceExpiry.year.toString().padLeft(4, '0')}-${licenceExpiry.month.toString().padLeft(2, '0')}-${licenceExpiry.day.toString().padLeft(2, '0')}",
    "licence_expiry_time": licenceExpiryTime,
    "licence_document": licenceDocument,
  };
}

class LogBook {
  String logBookNumber;
  String logBookDocument;

  LogBook({
    required this.logBookNumber,
    required this.logBookDocument,
  });

  factory LogBook.fromJson(Map<String, dynamic> json) => LogBook(
    logBookNumber: json["log_book_number"] ?? "",
    logBookDocument: json["log_book_document"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "log_book_number": logBookNumber,
    "log_book_document": logBookDocument,
  };
}

class Mot {
  dynamic motNumber;
  DateTime motExpiry;
  String motExpiryTime;
  String motDocument;

  Mot({
    required this.motNumber,
    required this.motExpiry,
    required this.motExpiryTime,
    required this.motDocument,
  });

  factory Mot.fromJson(Map<String, dynamic> json) => Mot(
    motNumber: json["mot_number"]?? "",
    motExpiry: json["mot_expiry"] == null || json["mot_expiry"] == ""
  ? DateTime.now()
      : DateTime.parse(json["mot_expiry"]),
    motExpiryTime: json["mot_expiry_time"]?? "",
    motDocument: json["mot_document"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "mot_number": motNumber,
    "mot_expiry": "${motExpiry.year.toString().padLeft(4, '0')}-${motExpiry.month.toString().padLeft(2, '0')}-${motExpiry.day.toString().padLeft(2, '0')}",
    "mot_expiry_time": motExpiryTime,
    "mot_document": motDocument,
  };
}

class Mot2 {
  dynamic mot2Number;
  DateTime mot2Expiry;
  String mot2ExpiryTime;
  String mot2Document;

  Mot2({
    required this.mot2Number,
    required this.mot2Expiry,
    required this.mot2ExpiryTime,
    required this.mot2Document,
  });

  factory Mot2.fromJson(Map<String, dynamic> json) => Mot2(
    mot2Number: json["mot2_number"]?? "",
    mot2Expiry: DateTime.parse(json["mot2_expiry"]?? ""),
    mot2ExpiryTime: json["mot2_expiry_time"]?? "",
    mot2Document: json["mot2_document"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "mot2_number": mot2Number,
    "mot2_expiry": "${mot2Expiry.year.toString().padLeft(4, '0')}-${mot2Expiry.month.toString().padLeft(2, '0')}-${mot2Expiry.day.toString().padLeft(2, '0')}",
    "mot2_expiry_time": mot2ExpiryTime,
    "mot2_document": mot2Document,
  };
}

class PhcDriver {
  dynamic phcDriverNumber;
  DateTime phcDriverExpiry;
  String phcDriverExpiryTime;
  String phcDriverDocument;

  PhcDriver({
    required this.phcDriverNumber,
    required this.phcDriverExpiry,
    required this.phcDriverExpiryTime,
    required this.phcDriverDocument,
  });

  factory PhcDriver.fromJson(Map<String, dynamic> json) => PhcDriver(
    phcDriverNumber: json["phc_driver_number"]?? "",
    phcDriverExpiry: DateTime.parse(json["phc_driver_expiry"]?? ""),
    phcDriverExpiryTime: json["phc_driver_expiry_time"]?? "",
    phcDriverDocument: json["phc_driver_document"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "phc_driver_number": phcDriverNumber,
    "phc_driver_expiry": "${phcDriverExpiry.year.toString().padLeft(4, '0')}-${phcDriverExpiry.month.toString().padLeft(2, '0')}-${phcDriverExpiry.day.toString().padLeft(2, '0')}",
    "phc_driver_expiry_time": phcDriverExpiryTime,
    "phc_driver_document": phcDriverDocument,
  };
}

class PhcVehicle {
  dynamic phcVehicleNumber;
  DateTime phcVehicleExpiry;
  String phcVehicleExpiryTime;
  String phcVehicleDocument;

  PhcVehicle({
    required this.phcVehicleNumber,
    required this.phcVehicleExpiry,
    required this.phcVehicleExpiryTime,
    required this.phcVehicleDocument,
  });

  factory PhcVehicle.fromJson(Map<String, dynamic> json) => PhcVehicle(
    phcVehicleNumber: json["phc_vehicle_number"]?? "",
    phcVehicleExpiry: DateTime.parse(json["phc_vehicle_expiry"]?? ""),
    phcVehicleExpiryTime: json["phc_vehicle_expiry_time"]?? "",
    phcVehicleDocument: json["phc_vehicle_document"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "phc_vehicle_number": phcVehicleNumber,
    "phc_vehicle_expiry": "${phcVehicleExpiry.year.toString().padLeft(4, '0')}-${phcVehicleExpiry.month.toString().padLeft(2, '0')}-${phcVehicleExpiry.day.toString().padLeft(2, '0')}",
    "phc_vehicle_expiry_time": phcVehicleExpiryTime,
    "phc_vehicle_document": phcVehicleDocument,
  };
}

class RentalAgreement {
  dynamic rentalAgreementNumber;
  DateTime rentalAgreementExpiry;
  String rentalAgreementExpiryTime;
  String rentalAgreementDocument;

  RentalAgreement({
    required this.rentalAgreementNumber,
    required this.rentalAgreementExpiry,
    required this.rentalAgreementExpiryTime,
    required this.rentalAgreementDocument,
  });

  factory RentalAgreement.fromJson(Map<String, dynamic> json) => RentalAgreement(
    rentalAgreementNumber: json["rental_agreement_number"]?? "",
    rentalAgreementExpiry: DateTime.parse(json["rental_agreement_expiry"]?? ""),
    rentalAgreementExpiryTime: json["rental_agreement_expiry_time"]?? "",
    rentalAgreementDocument: json["rental_agreement_document"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "rental_agreement_number": rentalAgreementNumber,
    "rental_agreement_expiry": "${rentalAgreementExpiry.year.toString().padLeft(4, '0')}-${rentalAgreementExpiry.month.toString().padLeft(2, '0')}-${rentalAgreementExpiry.day.toString().padLeft(2, '0')}",
    "rental_agreement_expiry_time": rentalAgreementExpiryTime,
    "rental_agreement_document": rentalAgreementDocument,
  };
}

class RoadTax {
  dynamic roadTaxNumber;
  DateTime roadTaxExpiry;
  String roadTaxExpiryTime;
  String roadTaxDocument;

  RoadTax({
    required this.roadTaxNumber,
    required this.roadTaxExpiry,
    required this.roadTaxExpiryTime,
    required this.roadTaxDocument,
  });

  factory RoadTax.fromJson(Map<String, dynamic> json) => RoadTax(
    roadTaxNumber: json["road_tax_number"]?? "",
    roadTaxExpiry: DateTime.parse(json["road_tax_expiry"]?? ""),
    roadTaxExpiryTime: json["road_tax_expiry_time"]?? "",
    roadTaxDocument: json["road_tax_document"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "road_tax_number": roadTaxNumber,
    "road_tax_expiry": "${roadTaxExpiry.year.toString().padLeft(4, '0')}-${roadTaxExpiry.month.toString().padLeft(2, '0')}-${roadTaxExpiry.day.toString().padLeft(2, '0')}",
    "road_tax_expiry_time": roadTaxExpiryTime,
    "road_tax_document": roadTaxDocument,
  };
}

class V5Registration {
  dynamic v5RegistrationNumber;
  DateTime v5RegistrationExpiry;
  String v5RegistrationExpiryTime;
  String v5RegistrationDocument;

  V5Registration({
    required this.v5RegistrationNumber,
    required this.v5RegistrationExpiry,
    required this.v5RegistrationExpiryTime,
    required this.v5RegistrationDocument,
  });

  factory V5Registration.fromJson(Map<String, dynamic> json) => V5Registration(
    v5RegistrationNumber: json["v5_registration_number"]?? "",
    v5RegistrationExpiry: DateTime.parse(json["v5_registration_expiry"]?? ""),
    v5RegistrationExpiryTime: json["v5_registration_expiry_time"]?? "",
    v5RegistrationDocument: json["v5_registration_document"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "v5_registration_number": v5RegistrationNumber,
    "v5_registration_expiry": "${v5RegistrationExpiry.year.toString().padLeft(4, '0')}-${v5RegistrationExpiry.month.toString().padLeft(2, '0')}-${v5RegistrationExpiry.day.toString().padLeft(2, '0')}",
    "v5_registration_expiry_time": v5RegistrationExpiryTime,
    "v5_registration_document": v5RegistrationDocument,
  };
}

class VehicleType {
  int id;
  String name;
  int driverWaitingCharges;
  int accountWaitingCharges;
  int waitingTime;

  VehicleType({
    required this.id,
    required this.name,
    required this.driverWaitingCharges,
    required this.accountWaitingCharges,
    required this.waitingTime,
  });

  factory VehicleType.fromJson(Map<String, dynamic> json) => VehicleType(
    id: json["id"]?? "",
    name: json["name"]?? "",
    driverWaitingCharges: json["driver_waiting_charges"]?? "",
    accountWaitingCharges: json["account_waiting_charges"]?? "",
    waitingTime: json["waiting_time"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "driver_waiting_charges": driverWaitingCharges,
    "account_waiting_charges": accountWaitingCharges,
    "waiting_time": waitingTime,
  };
}
