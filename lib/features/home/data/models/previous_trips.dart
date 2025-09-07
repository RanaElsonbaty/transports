class PreviousTrips {
    bool? success;
    String? message;
    Data? data;
    dynamic errors;

    PreviousTrips({this.success, this.message, this.data, this.errors});

    PreviousTrips.fromJson(Map<String, dynamic> json) {
        success = json['success'] as bool?;
        message = json['message'] as String?;
        data = json['data'] != null ? Data.fromJson(json['data']) : null;
        errors = json['errors'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> map = {};
        map['success'] = success;
        map['message'] = message;
        if (data != null) map['data'] = data!.toJson();
        map['errors'] = errors;
        return map;
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
    String? nextPageUrl;
    String? path;
    int? perPage;
    String? prevPageUrl;
    int? to;
    int? total;

    Data({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    Data.fromJson(Map<String, dynamic> json) {
        currentPage = json['current_page'] as int?;
        if (json['data'] != null) {
            data = (json['data'] as List?)?.map((v) => Data1.fromJson(v)).toList();
        }
        firstPageUrl = json['first_page_url'] as String?;
        from = json['from'] as int?;
        lastPage = json['last_page'] as int?;
        lastPageUrl = json['last_page_url'] as String?;
        if (json['links'] != null) {
            links = (json['links'] as List?)?.map((v) => Links.fromJson(v)).toList();
        }
        nextPageUrl = json['next_page_url'] as String?;
        path = json['path'] as String?;
        perPage = json['per_page'] is int
            ? json['per_page'] as int?
            : int.tryParse(json['per_page'].toString());
        prevPageUrl = json['prev_page_url'] as String?;
        to = json['to'] as int?;
        total = json['total'] as int?;
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> map = {};
        map['current_page'] = currentPage;
        if (data != null) map['data'] = data!.map((v) => v.toJson()).toList();
        map['first_page_url'] = firstPageUrl;
        map['from'] = from;
        map['last_page'] = lastPage;
        map['last_page_url'] = lastPageUrl;
        if (links != null) map['links'] = links!.map((v) => v.toJson()).toList();
        map['next_page_url'] = nextPageUrl;
        map['path'] = path;
        map['per_page'] = perPage;
        map['prev_page_url'] = prevPageUrl;
        map['to'] = to;
        map['total'] = total;
        return map;
    }
}

class Data1 {
    int? id;
    int? driverId;
    String? departureLocation;
    String? destinationLocation;
    String? departureTime;
    String? estimatedArrivalTime;
    String? actualDepartureTime;
    String? actualArrivalTime;
    String? status;
    int? totalPassengers;
    int? maxPassengers;
    double? distanceKm;
    int? estimatedDurationMinutes;
    String? notes;
    List<RouteCoordinates>? routeCoordinates;
    String? createdAt;
    String? updatedAt;
    String? deletedAt;
    int? departureRegionId;
    int? destinationRegionId;
    int? departureCityId;
    int? destinationCityId;
    Driver? driver;
    List<Passengers>? passengers;
    List<Seats>? seats;

    Data1({
        this.id,
        this.driverId,
        this.departureLocation,
        this.destinationLocation,
        this.departureTime,
        this.estimatedArrivalTime,
        this.actualDepartureTime,
        this.actualArrivalTime,
        this.status,
        this.totalPassengers,
        this.maxPassengers,
        this.distanceKm,
        this.estimatedDurationMinutes,
        this.notes,
        this.routeCoordinates,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.departureRegionId,
        this.destinationRegionId,
        this.departureCityId,
        this.destinationCityId,
        this.driver,
        this.passengers,
        this.seats,
    });

    Data1.fromJson(Map<String, dynamic> json) {
        id = json['id'] as int?;
        driverId = json['driver_id'] as int?;
        departureLocation = json['departure_location'] as String?;
        destinationLocation = json['destination_location'] as String?;
        departureTime = json['departure_time'] as String?;
        estimatedArrivalTime = json['estimated_arrival_time'] as String?;
        actualDepartureTime = json['actual_departure_time'] as String?;
        actualArrivalTime = json['actual_arrival_time'] as String?;
        status = json['status'] as String?;
        totalPassengers = json['total_passengers'] as int?;
        maxPassengers = json['max_passengers'] as int?;
        distanceKm = (json['distance_km'] is num)
            ? (json['distance_km'] as num?)?.toDouble()
            : null;
        estimatedDurationMinutes = json['estimated_duration_minutes'] as int?;
        notes = json['notes'] as String?;
        if (json['route_coordinates'] != null) {
            routeCoordinates = (json['route_coordinates'] as List?)
                ?.map((v) => RouteCoordinates.fromJson(v))
                .toList();
        }
        createdAt = json['created_at'] as String?;
        updatedAt = json['updated_at'] as String?;
        deletedAt = json['deleted_at'] as String?;
        departureRegionId = json['departure_region_id'] as int?;
        destinationRegionId = json['destination_region_id'] as int?;
        departureCityId = json['departure_city_id'] as int?;
        destinationCityId = json['destination_city_id'] as int?;
        driver =
        json['driver'] != null ? Driver.fromJson(json['driver']) : null;
        if (json['passengers'] != null) {
            passengers = (json['passengers'] as List?)
                ?.map((v) => Passengers.fromJson(v))
                .toList();
        }
        if (json['seats'] != null) {
            seats =
                (json['seats'] as List?)?.map((v) => Seats.fromJson(v)).toList();
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> map = {};
        map['id'] = id;
        map['driver_id'] = driverId;
        map['departure_location'] = departureLocation;
        map['destination_location'] = destinationLocation;
        map['departure_time'] = departureTime;
        map['estimated_arrival_time'] = estimatedArrivalTime;
        map['actual_departure_time'] = actualDepartureTime;
        map['actual_arrival_time'] = actualArrivalTime;
        map['status'] = status;
        map['total_passengers'] = totalPassengers;
        map['max_passengers'] = maxPassengers;
        map['distance_km'] = distanceKm;
        map['estimated_duration_minutes'] = estimatedDurationMinutes;
        map['notes'] = notes;
        if (routeCoordinates != null) {
            map['route_coordinates'] =
                routeCoordinates!.map((v) => v.toJson()).toList();
        }
        map['created_at'] = createdAt;
        map['updated_at'] = updatedAt;
        map['deleted_at'] = deletedAt;
        map['departure_region_id'] = departureRegionId;
        map['destination_region_id'] = destinationRegionId;
        map['departure_city_id'] = departureCityId;
        map['destination_city_id'] = destinationCityId;
        if (driver != null) map['driver'] = driver!.toJson();
        if (passengers != null) {
            map['passengers'] = passengers!.map((v) => v.toJson()).toList();
        }
        if (seats != null) {
            map['seats'] = seats!.map((v) => v.toJson()).toList();
        }
        return map;
    }
}

class RouteCoordinates {
    double? lat;
    double? lng;

    RouteCoordinates({this.lat, this.lng});

    RouteCoordinates.fromJson(Map<String, dynamic> json) {
        lat = (json['lat'] is num) ? (json['lat'] as num).toDouble() : null;
        lng = (json['lng'] is num) ? (json['lng'] as num).toDouble() : null;
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> map = {};
        map['lat'] = lat;
        map['lng'] = lng;
        return map;
    }
}

class Driver {
    int? id;
    String? name;
    String? email;
    String? username;
    String? phone;
    String? avatar;
    String? status;
    String? emailVerifiedAt;
    String? createdAt;
    String? updatedAt;
    String? deletedAt;
    int? countryId;
    int? regionId;
    int? cityId;

    Driver({
        this.id,
        this.name,
        this.email,
        this.username,
        this.phone,
        this.avatar,
        this.status,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.countryId,
        this.regionId,
        this.cityId,
    });

    Driver.fromJson(Map<String, dynamic> json) {
        id = json['id'] as int?;
        name = json['name'] as String?;
        email = json['email'] as String?;
        username = json['username'] as String?;
        phone = json['phone'] as String?;
        avatar = json['avatar'] as String?;
        status = json['status'] as String?;
        emailVerifiedAt = json['email_verified_at'] as String?;
        createdAt = json['created_at'] as String?;
        updatedAt = json['updated_at'] as String?;
        deletedAt = json['deleted_at'] as String?;
        countryId = json['country_id'] as int?;
        regionId = json['region_id'] as int?;
        cityId = json['city_id'] as int?;
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> map = {};
        map['id'] = id;
        map['name'] = name;
        map['email'] = email;
        map['username'] = username;
        map['phone'] = phone;
        map['avatar'] = avatar;
        map['status'] = status;
        map['email_verified_at'] = emailVerifiedAt;
        map['created_at'] = createdAt;
        map['updated_at'] = updatedAt;
        map['deleted_at'] = deletedAt;
        map['country_id'] = countryId;
        map['region_id'] = regionId;
        map['city_id'] = cityId;
        return map;
    }
}

class Passengers {
    int? id;
    int? tripId;
    int? seatId;
    String? name;
    String? phone;
    String? nationalId;
    String? passportNumber;
    String? gender;
    int? age;
    String? nationality;
    String? emergencyContactName;
    String? emergencyContactPhone;
    String? boardingLocation;
    String? destinationLocation;
    String? ticketNumber;
    String? status;
    String? boardingTime;
    String? disembarkationTime;
    String? notes;
    String? photo;
    String? createdAt;
    String? updatedAt;
    String? deletedAt;

    Passengers({
        this.id,
        this.tripId,
        this.seatId,
        this.name,
        this.phone,
        this.nationalId,
        this.passportNumber,
        this.gender,
        this.age,
        this.nationality,
        this.emergencyContactName,
        this.emergencyContactPhone,
        this.boardingLocation,
        this.destinationLocation,
        this.ticketNumber,
        this.status,
        this.boardingTime,
        this.disembarkationTime,
        this.notes,
        this.photo,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    Passengers.fromJson(Map<String, dynamic> json) {
        id = json['id'] as int?;
        tripId = json['trip_id'] as int?;
        seatId = json['seat_id'] as int?;
        name = json['name'] as String?;
        phone = json['phone'] as String?;
        nationalId = json['national_id'] as String?;
        passportNumber = json['passport_number'] as String?;
        gender = json['gender'] as String?;
        age = json['age'] as int?;
        nationality = json['nationality'] as String?;
        emergencyContactName = json['emergency_contact_name'] as String?;
        emergencyContactPhone = json['emergency_contact_phone'] as String?;
        boardingLocation = json['boarding_location'] as String?;
        destinationLocation = json['destination_location'] as String?;
        ticketNumber = json['ticket_number'] as String?;
        status = json['status'] as String?;
        boardingTime = json['boarding_time'] as String?;
        disembarkationTime = json['disembarkation_time'] as String?;
        notes = json['notes'] as String?;
        photo = json['photo'] as String?;
        createdAt = json['created_at'] as String?;
        updatedAt = json['updated_at'] as String?;
        deletedAt = json['deleted_at'] as String?;
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> map = {};
        map['id'] = id;
        map['trip_id'] = tripId;
        map['seat_id'] = seatId;
        map['name'] = name;
        map['phone'] = phone;
        map['national_id'] = nationalId;
        map['passport_number'] = passportNumber;
        map['gender'] = gender;
        map['age'] = age;
        map['nationality'] = nationality;
        map['emergency_contact_name'] = emergencyContactName;
        map['emergency_contact_phone'] = emergencyContactPhone;
        map['boarding_location'] = boardingLocation;
        map['destination_location'] = destinationLocation;
        map['ticket_number'] = ticketNumber;
        map['status'] = status;
        map['boarding_time'] = boardingTime;
        map['disembarkation_time'] = disembarkationTime;
        map['notes'] = notes;
        map['photo'] = photo;
        map['created_at'] = createdAt;
        map['updated_at'] = updatedAt;
        map['deleted_at'] = deletedAt;
        return map;
    }
}

class Seats {
    int? id;
    int? tripId;
    String? seatNumber;
    int? rowNumber;
    int? columnNumber;
    String? seatType;
    String? status;
    int? passengerId;
    double? price;
    bool? isPremium;
    String? notes;
    String? createdAt;
    String? updatedAt;
    String? deletedAt;

    Seats({
        this.id,
        this.tripId,
        this.seatNumber,
        this.rowNumber,
        this.columnNumber,
        this.seatType,
        this.status,
        this.passengerId,
        this.price,
        this.isPremium,
        this.notes,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    Seats.fromJson(Map<String, dynamic> json) {
        id = json['id'] as int?;
        tripId = json['trip_id'] as int?;
        seatNumber = json['seat_number'] as String?;
        rowNumber = json['row_number'] as int?;
        columnNumber = json['column_number'] as int?;
        seatType = json['seat_type'] as String?;
        status = json['status'] as String?;
        passengerId = json['passenger_id'] as int?;
        price = (json['price'] is num) ? (json['price'] as num?)?.toDouble() : null;
        isPremium = json['is_premium'] as bool?;
        notes = json['notes'] as String?;
        createdAt = json['created_at'] as String?;
        updatedAt = json['updated_at'] as String?;
        deletedAt = json['deleted_at'] as String?;
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> map = {};
        map['id'] = id;
        map['trip_id'] = tripId;
        map['seat_number'] = seatNumber;
        map['row_number'] = rowNumber;
        map['column_number'] = columnNumber;
        map['seat_type'] = seatType;
        map['status'] = status;
        map['passenger_id'] = passengerId;
        map['price'] = price;
        map['is_premium'] = isPremium;
        map['notes'] = notes;
        map['created_at'] = createdAt;
        map['updated_at'] = updatedAt;
        map['deleted_at'] = deletedAt;
        return map;
    }
}

class Links {
    String? url;
    String? label;
    bool? active;

    Links({this.url, this.label, this.active});

    Links.fromJson(Map<String, dynamic> json) {
        url = json['url'] as String?;
        label = json['label'] as String?;
        active = json['active'] as bool?;
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> map = {};
        map['url'] = url;
        map['label'] = label;
        map['active'] = active;
        return map;
    }
}
