
class PreviousTrips {
    bool? success;
    String? message;
    Data? data;
    dynamic errors;

    PreviousTrips({this.success, this.message, this.data, this.errors});

    PreviousTrips.fromJson(Map<String, dynamic> json) {
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
    int? currentPage;
    List<Data1>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Links>? links;
    dynamic nextPageUrl;
    String? path;
    int? perPage;
    dynamic prevPageUrl;
    int? to;
    int? total;

    Data({this.currentPage, this.data, this.firstPageUrl, this.from, this.lastPage, this.lastPageUrl, this.links, this.nextPageUrl, this.path, this.perPage, this.prevPageUrl, this.to, this.total});

    Data.fromJson(Map<String, dynamic> json) {
        currentPage = json["current_page"];
        data = json["data"] == null ? null : (json["data"] as List).map((e) => Data1.fromJson(e)).toList();
        firstPageUrl = json["first_page_url"];
        from = json["from"];
        lastPage = json["last_page"];
        lastPageUrl = json["last_page_url"];
        links = json["links"] == null ? null : (json["links"] as List).map((e) => Links.fromJson(e)).toList();
        nextPageUrl = json["next_page_url"];
        path = json["path"];
        perPage = json["per_page"];
        prevPageUrl = json["prev_page_url"];
        to = json["to"];
        total = json["total"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["current_page"] = currentPage;
        if(data != null) {
            _data["data"] = data?.map((e) => e.toJson()).toList();
        }
        _data["first_page_url"] = firstPageUrl;
        _data["from"] = from;
        _data["last_page"] = lastPage;
        _data["last_page_url"] = lastPageUrl;
        if(links != null) {
            _data["links"] = links?.map((e) => e.toJson()).toList();
        }
        _data["next_page_url"] = nextPageUrl;
        _data["path"] = path;
        _data["per_page"] = perPage;
        _data["prev_page_url"] = prevPageUrl;
        _data["to"] = to;
        _data["total"] = total;
        return _data;
    }
}

class Links {
    dynamic url;
    String? label;
    bool? active;

    Links({this.url, this.label, this.active});

    Links.fromJson(Map<String, dynamic> json) {
        url = json["url"];
        label = json["label"];
        active = json["active"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["url"] = url;
        _data["label"] = label;
        _data["active"] = active;
        return _data;
    }
}

class Data1 {
    int? id;
    int? driverId;
    String? departureLocation;
    String? destinationLocation;
    String? departureTime;
    dynamic estimatedArrivalTime;
    dynamic actualDepartureTime;
    dynamic actualArrivalTime;
    String? status;
    int? totalPassengers;
    int? maxPassengers;
    dynamic distanceKm;
    dynamic estimatedDurationMinutes;
    dynamic notes;
    dynamic routeCoordinates;
    String? createdAt;
    String? updatedAt;
    dynamic deletedAt;
    dynamic departureRegionId;
    dynamic destinationRegionId;
    dynamic departureCityId;
    dynamic destinationCityId;

    Data1({this.id, this.driverId, this.departureLocation, this.destinationLocation, this.departureTime, this.estimatedArrivalTime, this.actualDepartureTime, this.actualArrivalTime, this.status, this.totalPassengers, this.maxPassengers, this.distanceKm, this.estimatedDurationMinutes, this.notes, this.routeCoordinates, this.createdAt, this.updatedAt, this.deletedAt, this.departureRegionId, this.destinationRegionId, this.departureCityId, this.destinationCityId});

    Data1.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        driverId = json["driver_id"];
        departureLocation = json["departure_location"];
        destinationLocation = json["destination_location"];
        departureTime = json["departure_time"];
        estimatedArrivalTime = json["estimated_arrival_time"];
        actualDepartureTime = json["actual_departure_time"];
        actualArrivalTime = json["actual_arrival_time"];
        status = json["status"];
        totalPassengers = json["total_passengers"];
        maxPassengers = json["max_passengers"];
        distanceKm = json["distance_km"];
        estimatedDurationMinutes = json["estimated_duration_minutes"];
        notes = json["notes"];
        routeCoordinates = json["route_coordinates"];
        createdAt = json["created_at"];
        updatedAt = json["updated_at"];
        deletedAt = json["deleted_at"];
        departureRegionId = json["departure_region_id"];
        destinationRegionId = json["destination_region_id"];
        departureCityId = json["departure_city_id"];
        destinationCityId = json["destination_city_id"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["driver_id"] = driverId;
        _data["departure_location"] = departureLocation;
        _data["destination_location"] = destinationLocation;
        _data["departure_time"] = departureTime;
        _data["estimated_arrival_time"] = estimatedArrivalTime;
        _data["actual_departure_time"] = actualDepartureTime;
        _data["actual_arrival_time"] = actualArrivalTime;
        _data["status"] = status;
        _data["total_passengers"] = totalPassengers;
        _data["max_passengers"] = maxPassengers;
        _data["distance_km"] = distanceKm;
        _data["estimated_duration_minutes"] = estimatedDurationMinutes;
        _data["notes"] = notes;
        _data["route_coordinates"] = routeCoordinates;
        _data["created_at"] = createdAt;
        _data["updated_at"] = updatedAt;
        _data["deleted_at"] = deletedAt;
        _data["departure_region_id"] = departureRegionId;
        _data["destination_region_id"] = destinationRegionId;
        _data["departure_city_id"] = departureCityId;
        _data["destination_city_id"] = destinationCityId;
        return _data;
    }
}