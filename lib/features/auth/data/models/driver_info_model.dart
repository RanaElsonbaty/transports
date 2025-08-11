
class DriverInfoModel {
    bool? success;
    String? message;
    Data? data;
    dynamic errors;
    DriverInfoModel({this.success, this.message, this.data, this.errors});

    DriverInfoModel.fromJson(Map<String, dynamic> json) {
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
    int? id;
    int? userId;
    String? nationalId;
    String? nationality;
    String? drivingLicenseNumber;
    String? drivingLicenseExpiry;
    dynamic drivingLicensePhoto;
    dynamic nationalIdPhoto;
    dynamic profilePhoto;
    String? status;
    dynamic rejectionReason;
    String? createdAt;
    String? updatedAt;
    dynamic deletedAt;

    Data({this.id, this.userId, this.nationalId, this.nationality, this.drivingLicenseNumber, this.drivingLicenseExpiry, this.drivingLicensePhoto, this.nationalIdPhoto, this.profilePhoto, this.status, this.rejectionReason, this.createdAt, this.updatedAt, this.deletedAt});

    Data.fromJson(Map<String, dynamic> json) {
id = json["id"] is int ? json["id"] : int.tryParse(json["id"] ?? "") ?? 0;

userId = json["user_id"] is int 
    ? json["user_id"] 
    : int.tryParse(json["user_id"]?.toString() ?? '') ?? 0;
        nationalId = json["national_id"];
        nationality = json["nationality"];
        drivingLicenseNumber = json["driving_license_number"];
        drivingLicenseExpiry = json["driving_license_expiry"];
        drivingLicensePhoto = json["driving_license_photo"];
        nationalIdPhoto = json["national_id_photo"];
        profilePhoto = json["profile_photo"];
        status = json["status"];
        rejectionReason = json["rejection_reason"];
        createdAt = json["created_at"];
        updatedAt = json["updated_at"];
        deletedAt = json["deleted_at"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["user_id"] = userId;
        _data["national_id"] = nationalId;
        _data["nationality"] = nationality;
        _data["driving_license_number"] = drivingLicenseNumber;
        _data["driving_license_expiry"] = drivingLicenseExpiry;
        _data["driving_license_photo"] = drivingLicensePhoto;
        _data["national_id_photo"] = nationalIdPhoto;
        _data["profile_photo"] = profilePhoto;
        _data["status"] = status;
        _data["rejection_reason"] = rejectionReason;
        _data["created_at"] = createdAt;
        _data["updated_at"] = updatedAt;
        _data["deleted_at"] = deletedAt;
        return _data;
    }
}