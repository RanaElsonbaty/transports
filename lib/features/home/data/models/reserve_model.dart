
class ReservingSeatModel {
    bool? success;
    String? message;
    ReservingData? data;
    dynamic errors;

    ReservingSeatModel({this.success, this.message, this.data, this.errors});

    ReservingSeatModel.fromJson(Map<String, dynamic> json) {
        success = json["success"];
        message = json["message"];
        data = json["data"] == null ? null : ReservingData.fromJson(json["data"]);
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

class ReservingData {
    int? id;
    int? tripId;
    String? seatNumber;
    int? rowNumber;
    int? columnNumber;
    String? seatType;
    String? status;
    dynamic passengerId;
    dynamic price;
    bool? isPremium;
    dynamic notes;
    String? createdAt;
    String? updatedAt;
    dynamic deletedAt;

    ReservingData({this.id, this.tripId, this.seatNumber, this.rowNumber, this.columnNumber, this.seatType, this.status, this.passengerId, this.price, this.isPremium, this.notes, this.createdAt, this.updatedAt, this.deletedAt});

    ReservingData.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        tripId = json["trip_id"];
        seatNumber = json["seat_number"];
        rowNumber = json["row_number"];
        columnNumber = json["column_number"];
        seatType = json["seat_type"];
        status = json["status"];
        passengerId = json["passenger_id"];
        price = json["price"];
        isPremium = json["is_premium"];
        notes = json["notes"];
        createdAt = json["created_at"];
        updatedAt = json["updated_at"];
        deletedAt = json["deleted_at"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["trip_id"] = tripId;
        _data["seat_number"] = seatNumber;
        _data["row_number"] = rowNumber;
        _data["column_number"] = columnNumber;
        _data["seat_type"] = seatType;
        _data["status"] = status;
        _data["passenger_id"] = passengerId;
        _data["price"] = price;
        _data["is_premium"] = isPremium;
        _data["notes"] = notes;
        _data["created_at"] = createdAt;
        _data["updated_at"] = updatedAt;
        _data["deleted_at"] = deletedAt;
        return _data;
    }
}