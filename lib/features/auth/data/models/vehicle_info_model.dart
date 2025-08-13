
class VehicleInfoModel {
    bool? success;
    String? message;
    Data? data;
    dynamic errors;

    VehicleInfoModel({this.success, this.message, this.data, this.errors});

    VehicleInfoModel.fromJson(Map<String, dynamic> json) {
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
    dynamic vehiclePhoto;
    dynamic registrationPhoto;
    dynamic insurancePhoto;
    dynamic logoPhoto;
    dynamic stampPhoto;
    String? notes;
    String? status;
    String? updatedAt;
    String? createdAt;
    int? id;

    Data({this.driverId, this.ownerName, this.ownerNationalId, this.plateNumber, this.vehicleModel, this.manufacturingYear, this.vehicleType, this.capacity, this.color, this.registrationNumber, this.registrationExpiry, this.insuranceNumber, this.insuranceExpiry, this.vehiclePhoto, this.registrationPhoto, this.insurancePhoto, this.logoPhoto, this.stampPhoto, this.notes, this.status, this.updatedAt, this.createdAt, this.id});

    Data.fromJson(Map<String, dynamic> json) {
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
        logoPhoto = json["logo_photo"];
        stampPhoto = json["stamp_photo"];
        notes = json["notes"];
        status = json["status"];
        updatedAt = json["updated_at"];
        createdAt = json["created_at"];
        id = json["id"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
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
        _data["logo_photo"] = logoPhoto;
        _data["stamp_photo"] = stampPhoto;
        _data["notes"] = notes;
        _data["status"] = status;
        _data["updated_at"] = updatedAt;
        _data["created_at"] = createdAt;
        _data["id"] = id;
        return _data;
    }
}