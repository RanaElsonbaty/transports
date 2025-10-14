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
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    _data["errors"] = errors;
    return _data;
  }
}

class Data {
  User? user;
  List<Vehicle>? vehicles;

  Data({this.user, this.vehicles});

  Data.fromJson(Map<String, dynamic> json) {
    user = json["user"] == null ? null : User.fromJson(json["user"]);
    if (json["vehicles"] != null) {
      vehicles = List<Vehicle>.from(
        json["vehicles"].map((v) => Vehicle.fromJson(v)),
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (user != null) {
      _data["user"] = user?.toJson();
    }
    if (vehicles != null) {
      _data["vehicles"] = vehicles?.map((e) => e.toJson()).toList();
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

  User({this.id, this.name, this.phone, this.email, this.plateNumber, this.manufacturingYear, this.status, this.isDriver, this.isAdmin, this.avatarUrl});

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

class Vehicle {
  int? id;
  int? driverId;
  String? ownerName;
  String? plateNumber;
  String? vehicleModel;
  int? manufacturingYear;
  String? vehicleType;
  int? capacity;
  String? color;
  String? registrationNumber;
  String? insuranceNumber;
  String? status;
  String? notes;

  Vehicle({
    this.id,
    this.driverId,
    this.ownerName,
    this.plateNumber,
    this.vehicleModel,
    this.manufacturingYear,
    this.vehicleType,
    this.capacity,
    this.color,
    this.registrationNumber,
    this.insuranceNumber,
    this.status,
    this.notes,
  });

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    driverId = json["driver_id"];
    ownerName = json["owner_name"];
    plateNumber = json["plate_number"];
    vehicleModel = json["vehicle_model"];
    manufacturingYear = json["manufacturing_year"];
    vehicleType = json["vehicle_type"];
    capacity = json["capacity"];
    color = json["color"];
    registrationNumber = json["registration_number"];
    insuranceNumber = json["insurance_number"];
    status = json["status"];
    notes = json["notes"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["driver_id"] = driverId;
    _data["owner_name"] = ownerName;
    _data["plate_number"] = plateNumber;
    _data["vehicle_model"] = vehicleModel;
    _data["manufacturing_year"] = manufacturingYear;
    _data["vehicle_type"] = vehicleType;
    _data["capacity"] = capacity;
    _data["color"] = color;
    _data["registration_number"] = registrationNumber;
    _data["insurance_number"] = insuranceNumber;
    _data["status"] = status;
    _data["notes"] = notes;
    return _data;
  }
}