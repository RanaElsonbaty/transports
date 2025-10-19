class ProfileModel {
  bool? success;
  String? message;
  Data? data;
  dynamic errors;

  ProfileModel({this.success, this.message, this.data, this.errors});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
    errors = json["errors"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    _data["message"] = message;
    if (data != null) _data["data"] = data!.toJson();
    _data["errors"] = errors;
    return _data;
  }
}

class Data {
  User? user;
  Profile? profile;
  List<Vehicle>? vehicles;

  Data({this.user, this.profile, this.vehicles});

  Data.fromJson(Map<String, dynamic> json) {
    user = json["user"] == null ? null : User.fromJson(json["user"]);
    profile = json["profile"] == null ? null : Profile.fromJson(json["profile"]);
    if (json["vehicles"] != null) {
      vehicles = List<Vehicle>.from(
        json["vehicles"].map((v) => Vehicle.fromJson(v)),
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (user != null) _data["user"] = user!.toJson();
    if (profile != null) _data["profile"] = profile!.toJson();
    if (vehicles != null) {
      _data["vehicles"] = vehicles!.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class User {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? plateNumber;
  int? manufacturingYear;
  String? status;
  bool? isDriver;
  bool? isAdmin;
  String? avatarUrl;

  User({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.plateNumber,
    this.manufacturingYear,
    this.status,
    this.isDriver,
    this.isAdmin,
    this.avatarUrl,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    phone = json["phone"];
    email = json["email"];
    plateNumber = json["plate_number"];
    manufacturingYear = json["manufacturing_year"];
    status = json["status"];
    isDriver = json["is_driver"];
    isAdmin = json["is_admin"];
    avatarUrl = json["avatar_url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["phone"] = phone;
    _data["email"] = email;
    _data["plate_number"] = plateNumber;
    _data["manufacturing_year"] = manufacturingYear;
    _data["status"] = status;
    _data["is_driver"] = isDriver;
    _data["is_admin"] = isAdmin;
    _data["avatar_url"] = avatarUrl;
    return _data;
  }
}

class Profile {
  int? id;
  String? driverName;
  String? nationalId;
  String? nationality;
  String? drivingLicensePhoto;
  String? nationalIdPhoto;
  String? avatar;

  Profile({
    this.id,
    this.driverName,
    this.nationalId,
    this.nationality,
    this.drivingLicensePhoto,
    this.nationalIdPhoto,
    this.avatar,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    driverName = json["driver_name"];
    nationalId = json["national_id"];
    nationality = json["nationality"];
    drivingLicensePhoto = json["driving_license_photo"];
    nationalIdPhoto = json["national_id_photo"];
    avatar = json["avatar"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["driver_name"] = driverName;
    _data["national_id"] = nationalId;
    _data["nationality"] = nationality;
    _data["driving_license_photo"] = drivingLicensePhoto;
    _data["national_id_photo"] = nationalIdPhoto;
    _data["avatar"] = avatar;
    return _data;
  }
}

class Vehicle {
  int? id;
  int? driverId;
  String? ownerName;
  String? ownerNationalId;
  String? plateNumber;
  String? vehicleModel;
  int? manufacturingYear;
  String? vehicleType;
  int? capacity;
  String? color;
  String? registrationNumber;
  String? registrationExpiry;
  String? insuranceNumber;
  String? insuranceExpiry;
  String? vehiclePhoto;
  String? registrationPhoto;
  String? insurancePhoto;
  String? stampPhoto;
  String? logoPhoto;
  String? status;
  String? notes;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? companyPhone;
  String? companyTaxNumber;
  String? companyAddress;

  Vehicle({
    this.id,
    this.driverId,
    this.ownerName,
    this.ownerNationalId,
    this.plateNumber,
    this.vehicleModel,
    this.manufacturingYear,
    this.vehicleType,
    this.capacity,
    this.color,
    this.registrationNumber,
    this.registrationExpiry,
    this.insuranceNumber,
    this.insuranceExpiry,
    this.vehiclePhoto,
    this.registrationPhoto,
    this.insurancePhoto,
    this.stampPhoto,
    this.logoPhoto,
    this.status,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.companyPhone,
    this.companyTaxNumber,
    this.companyAddress,
  });

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    driverId = json["driver_id"];
    ownerName = json["owner_name"];
    ownerNationalId = json["owner_national_id"];
    plateNumber = json["plate_number"];
    vehicleModel = json["vehicle_model"];
    manufacturingYear = json["manufacturing_year"];
    vehicleType = json["vehicle_type"];
    capacity = json["capacity"];
    color = json["color"];
    registrationNumber = json["registration_number"];
    registrationExpiry = json["registration_expiry"];
    insuranceNumber = json["insurance_number"];
    insuranceExpiry = json["insurance_expiry"];
    vehiclePhoto = json["vehicle_photo"];
    registrationPhoto = json["registration_photo"];
    insurancePhoto = json["insurance_photo"];
    stampPhoto = json["stamp_photo"];
    logoPhoto = json["logo_photo"];
    status = json["status"];
    notes = json["notes"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    deletedAt = json["deleted_at"];
    companyPhone = json["company_phone"];
    companyTaxNumber = json["company_tax_number"];
    companyAddress = json["company_address"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["driver_id"] = driverId;
    _data["owner_name"] = ownerName;
    _data["owner_national_id"] = ownerNationalId;
    _data["plate_number"] = plateNumber;
    _data["vehicle_model"] = vehicleModel;
    _data["manufacturing_year"] = manufacturingYear;
    _data["vehicle_type"] = vehicleType;
    _data["capacity"] = capacity;
    _data["color"] = color;
    _data["registration_number"] = registrationNumber;
    _data["registration_expiry"] = registrationExpiry;
    _data["insurance_number"] = insuranceNumber;
    _data["insurance_expiry"] = insuranceExpiry;
    _data["vehicle_photo"] = vehiclePhoto;
    _data["registration_photo"] = registrationPhoto;
    _data["insurance_photo"] = insurancePhoto;
    _data["stamp_photo"] = stampPhoto;
    _data["logo_photo"] = logoPhoto;
    _data["status"] = status;
    _data["notes"] = notes;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    _data["deleted_at"] = deletedAt;
    _data["company_phone"] = companyPhone;
    _data["company_tax_number"] = companyTaxNumber;
    _data["company_address"] = companyAddress;
    return _data;
  }
}
