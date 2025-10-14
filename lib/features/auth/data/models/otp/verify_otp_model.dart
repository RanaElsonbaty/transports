class VerifyingOtpModel {
    bool? success;
    String? message;
    Data? data;
    dynamic errors;

    VerifyingOtpModel({this.success, this.message, this.data, this.errors});

    VerifyingOtpModel.fromJson(Map<String, dynamic> json) {
        success = json["success"];
        message = json["message"];
        data = json["data"] == null ? null : Data.fromJson(json["data"]);
        errors = json["errors"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["success"] = success;
        _data["message"] = message;
        if (data != null) {
            _data["data"] = data?.toJson();
        }
        _data["errors"] = errors;
        return _data;
    }
}

class Data {
    User? user;
    String? token;
    String? tokenType;

    Data({this.user, this.token, this.tokenType});

    Data.fromJson(Map<String, dynamic> json) {
        user = json["user"] == null ? null : User.fromJson(json["user"]);
        token = json["token"];
        tokenType = json["token_type"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if (user != null) {
            _data["user"] = user?.toJson();
        }
        _data["token"] = token;
        _data["token_type"] = tokenType;
        return _data;
    }
}

class User {
    int? id;
    String? name;
    String? phone;
    String? email;
    String? status;
    bool? isDriver;
    bool? isAdmin;
    String? avatarUrl;
    int?vehicle;
    DriverProfile? driverProfile;

    User({
        this.id,
        this.name,
        this.phone,
        this.email,
        this.status,
        this.isDriver,
        this.isAdmin,
        this.avatarUrl,
        this.vehicle,
        this.driverProfile,
    });

    User.fromJson(Map<String, dynamic> json) {
        id = json["id"]??0;
        name = json["name"]??'';
        phone = json["phone"]??'';
        email = json["email"]??'';
        status = json["status"]??'';
        isDriver = json["is_driver"]??true;
        isAdmin = json["is_admin"]??false;
        avatarUrl = json["avatar_url"]??'';
        vehicle = json["vehicle"]??0;
        driverProfile = json["driver_profile"] != null
            ? DriverProfile.fromJson(json["driver_profile"])
            : null;
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["name"] = name;
        _data["phone"] = phone;
        _data["email"] = email;
        _data["status"] = status;
        _data["is_driver"] = isDriver;
        _data["is_admin"] = isAdmin;
        _data["avatar_url"] = avatarUrl;
        _data["vehicle"] = vehicle;
        if (driverProfile != null) {
            _data["driver_profile"] = driverProfile?.toJson();
        }
        return _data;
    }
}

class DriverProfile {
    int? id;
    int? userId;
    String? nationalId;
    String? nationality;
    String? drivingLicenseNumber;
    String? drivingLicenseExpiry;
    String? drivingLicensePhoto;
    String? nationalIdPhoto;
    String? profilePhoto;
    String? status;
    String? rejectionReason;
    String? createdAt;
    String? updatedAt;
    String? deletedAt;

    DriverProfile({
        this.id,
        this.userId,
        this.nationalId,
        this.nationality,
        this.drivingLicenseNumber,
        this.drivingLicenseExpiry,
        this.drivingLicensePhoto,
        this.nationalIdPhoto,
        this.profilePhoto,
        this.status,
        this.rejectionReason,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    DriverProfile.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        userId = json["user_id"];
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
