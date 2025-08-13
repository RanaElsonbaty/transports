
class CityModel {
    bool? success;
    String? message;
    List<Data>? data;
    dynamic errors;

    CityModel({this.success, this.message, this.data, this.errors});

    CityModel.fromJson(Map<String, dynamic> json) {
        success = json["success"];
        message = json["message"];
        data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
        errors = json["errors"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["success"] = success;
        _data["message"] = message;
        if(data != null) {
            _data["data"] = data?.map((e) => e.toJson()).toList();
        }
        _data["errors"] = errors;
        return _data;
    }
}

class Data {
    int? id;
    int? regionId;
    String? nameAr;
    String? nameEn;
    String? code;
    bool? isActive;
    int? sortOrder;
    dynamic descriptionAr;
    dynamic descriptionEn;
    String? latitude;
    String? longitude;
    String? createdAt;
    String? updatedAt;
    dynamic deletedAt;

    Data({this.id, this.regionId, this.nameAr, this.nameEn, this.code, this.isActive, this.sortOrder, this.descriptionAr, this.descriptionEn, this.latitude, this.longitude, this.createdAt, this.updatedAt, this.deletedAt});

    Data.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        regionId = json["region_id"];
        nameAr = json["name_ar"];
        nameEn = json["name_en"];
        code = json["code"];
        isActive = json["is_active"];
        sortOrder = json["sort_order"];
        descriptionAr = json["description_ar"];
        descriptionEn = json["description_en"];
        latitude = json["latitude"];
        longitude = json["longitude"];
        createdAt = json["created_at"];
        updatedAt = json["updated_at"];
        deletedAt = json["deleted_at"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["region_id"] = regionId;
        _data["name_ar"] = nameAr;
        _data["name_en"] = nameEn;
        _data["code"] = code;
        _data["is_active"] = isActive;
        _data["sort_order"] = sortOrder;
        _data["description_ar"] = descriptionAr;
        _data["description_en"] = descriptionEn;
        _data["latitude"] = latitude;
        _data["longitude"] = longitude;
        _data["created_at"] = createdAt;
        _data["updated_at"] = updatedAt;
        _data["deleted_at"] = deletedAt;
        return _data;
    }
}