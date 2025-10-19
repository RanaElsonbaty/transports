class SeatsModel {
    bool? success;
    String? message;
    SeatsData? data;
    dynamic errors;

    SeatsModel({this.success, this.message, this.data, this.errors});

    SeatsModel.fromJson(Map<String, dynamic> json) {
        success = json["success"];
        message = json["message"];
        data = json["data"] == null ? null : SeatsData.fromJson(json["data"]);
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

class SeatsData {
    List<Seats>? seats;
    int? seatCount;
    int? maxPassengers;
    String? vehicleType;
    bool? secondParty;

    SeatsData({
        this.seats,
        this.seatCount,
        this.maxPassengers,
        this.vehicleType,
        this.secondParty,
    });

    SeatsData.fromJson(Map<String, dynamic> json) {
        seats = json["seats"] == null
            ? null
            : (json["seats"] as List).map((e) => Seats.fromJson(e)).toList();
        seatCount = json["seat_count"];
        maxPassengers = json["max_passengers"];
        vehicleType = json["vehicle_type"];
        secondParty = json["second_party"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if (seats != null) {
            _data["seats"] = seats?.map((e) => e.toJson()).toList();
        }
        _data["seat_count"] = seatCount;
        _data["max_passengers"] = maxPassengers;
        _data["vehicle_type"] = vehicleType;
        _data["second_party"] = secondParty;
        return _data;
    }
}

class Seats {
    dynamic tripId;
    int? seatNumber;
    int? rowNumber;
    int? columnNumber;
    String? seatType;
    String? status;
    dynamic createdAt;
    dynamic updatedAt;

    Seats({
        this.tripId,
        this.seatNumber,
        this.rowNumber,
        this.columnNumber,
        this.seatType,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    Seats.fromJson(Map<String, dynamic> json) {
        tripId = json["trip_id"];
        seatNumber = json["seat_number"];
        rowNumber = json["row_number"];
        columnNumber = json["column_number"];
        seatType = json["seat_type"];
        status = json["status"];
        createdAt = json["created_at"];
        updatedAt = json["updated_at"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["trip_id"] = tripId;
        _data["seat_number"] = seatNumber;
        _data["row_number"] = rowNumber;
        _data["column_number"] = columnNumber;
        _data["seat_type"] = seatType;
        _data["status"] = status;
        _data["created_at"] = createdAt;
        _data["updated_at"] = updatedAt;
        return _data;
    }
}
