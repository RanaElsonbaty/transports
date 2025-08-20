
class LogOutModel {
    bool? success;
    String? message;
    dynamic data;
    dynamic errors;

    LogOutModel({this.success, this.message, this.data, this.errors});

    LogOutModel.fromJson(Map<String, dynamic> json) {
        success = json["success"];
        message = json["message"];
        data = json["data"];
        errors = json["errors"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["success"] = success;
        _data["message"] = message;
        _data["data"] = data;
        _data["errors"] = errors;
        return _data;
    }
}