
class SendingOtpModel {
    bool? success;
    String? message;
    Data? data;
    dynamic errors;

    SendingOtpModel({this.success, this.message, this.data, this.errors});

    SendingOtpModel.fromJson(Map<String, dynamic> json) {
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
    String? phone;
    String? expiresAt;
    String? otp;

    Data({this.phone, this.expiresAt, this.otp});

    Data.fromJson(Map<String, dynamic> json) {
        phone = json["phone"];
        expiresAt = json["expires_at"];
        otp = json["otp"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["phone"] = phone;
        _data["expires_at"] = expiresAt;
        _data["otp"] = otp;
        return _data;
    }
}