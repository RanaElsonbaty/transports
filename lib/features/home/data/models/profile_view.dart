
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

    Data({this.user});

    Data.fromJson(Map<String, dynamic> json) {
        user = json["user"] == null ? null : User.fromJson(json["user"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(user != null) {
            _data["user"] = user?.toJson();
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