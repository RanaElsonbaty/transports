
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
        if(data != null) {
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
        if(user != null) {
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

    User({this.id, this.name, this.phone, this.email, this.status, this.isDriver, this.isAdmin});

    User.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        name = json["name"];
        phone = json["phone"];
        email = json["email"];
        status = json["status"];
        isDriver = json["is_driver"];
        isAdmin = json["is_admin"];
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
        return _data;
    }
}