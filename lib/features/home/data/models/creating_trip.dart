
class CreatingTripModel {
    bool? success;
    String? message;
    Data? data;
    dynamic errors;

    CreatingTripModel({this.success, this.message, this.data, this.errors});

    CreatingTripModel.fromJson(Map<String, dynamic> json) {
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
    Trip? trip;
    User? user;
    List<Vehicle>? vehicle;
    String? pdfUrl;

    Data({this.trip, this.user, this.vehicle, this.pdfUrl});

    Data.fromJson(Map<String, dynamic> json) {
        trip = json["trip"] == null ? null : Trip.fromJson(json["trip"]);
        user = json["user"] == null ? null : User.fromJson(json["user"]);
        vehicle = json["vehicle"] == null ? null : (json["vehicle"] as List).map((e) => Vehicle.fromJson(e)).toList();
        pdfUrl = json["pdf_url"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(trip != null) {
            _data["trip"] = trip?.toJson();
        }
        if(user != null) {
            _data["user"] = user?.toJson();
        }
        if(vehicle != null) {
            _data["vehicle"] = vehicle?.map((e) => e.toJson()).toList();
        }
        _data["pdf_url"] = pdfUrl;
        return _data;
    }
}

class Vehicle {
    int? id;
    int? driverId;
    String? ownerName;
    String? ownerNationalId;
    String? plateNumber;
    String? vehicleModel;
    int? manufacturingYear;
    String? vehicleType;
    int? capacity;
    String? color;
    String? registrationNumber;
    String? registrationExpiry;
    String? insuranceNumber;
    String? insuranceExpiry;
    dynamic vehiclePhoto;
    dynamic registrationPhoto;
    dynamic insurancePhoto;
    String? status;
    String? notes;
    String? createdAt;
    String? updatedAt;
    dynamic deletedAt;
    dynamic stampPhoto;
    dynamic logoPhoto;

    Vehicle({this.id, this.driverId, this.ownerName, this.ownerNationalId, this.plateNumber, this.vehicleModel, this.manufacturingYear, this.vehicleType, this.capacity, this.color, this.registrationNumber, this.registrationExpiry, this.insuranceNumber, this.insuranceExpiry, this.vehiclePhoto, this.registrationPhoto, this.insurancePhoto, this.status, this.notes, this.createdAt, this.updatedAt, this.deletedAt, this.stampPhoto, this.logoPhoto});

    Vehicle.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        driverId = json["driver_id"];
        ownerName = json["owner_name"];
        ownerNationalId = json["owner_national_id"];
        plateNumber = json["plate_number"];
        vehicleModel = json["vehicle_model"];
        manufacturingYear = json["manufacturing_year"];
        vehicleType = json["vehicle_type"];
        capacity = json["capacity"];
        color = json["color"];
        registrationNumber = json["registration_number"];
        registrationExpiry = json["registration_expiry"];
        insuranceNumber = json["insurance_number"];
        insuranceExpiry = json["insurance_expiry"];
        vehiclePhoto = json["vehicle_photo"];
        registrationPhoto = json["registration_photo"];
        insurancePhoto = json["insurance_photo"];
        status = json["status"];
        notes = json["notes"];
        createdAt = json["created_at"];
        updatedAt = json["updated_at"];
        deletedAt = json["deleted_at"];
        stampPhoto = json["stamp_photo"];
        logoPhoto = json["logo_photo"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["driver_id"] = driverId;
        _data["owner_name"] = ownerName;
        _data["owner_national_id"] = ownerNationalId;
        _data["plate_number"] = plateNumber;
        _data["vehicle_model"] = vehicleModel;
        _data["manufacturing_year"] = manufacturingYear;
        _data["vehicle_type"] = vehicleType;
        _data["capacity"] = capacity;
        _data["color"] = color;
        _data["registration_number"] = registrationNumber;
        _data["registration_expiry"] = registrationExpiry;
        _data["insurance_number"] = insuranceNumber;
        _data["insurance_expiry"] = insuranceExpiry;
        _data["vehicle_photo"] = vehiclePhoto;
        _data["registration_photo"] = registrationPhoto;
        _data["insurance_photo"] = insurancePhoto;
        _data["status"] = status;
        _data["notes"] = notes;
        _data["created_at"] = createdAt;
        _data["updated_at"] = updatedAt;
        _data["deleted_at"] = deletedAt;
        _data["stamp_photo"] = stampPhoto;
        _data["logo_photo"] = logoPhoto;
        return _data;
    }
}

class User {
    int? id;
    String? name;
    String? email;
    String? username;
    String? phone;
    dynamic avatar;
    String? status;
    dynamic emailVerifiedAt;
    String? createdAt;
    String? updatedAt;
    dynamic deletedAt;
    dynamic countryId;
    dynamic regionId;
    dynamic cityId;
    DriverProfile? driverProfile;
    List<Vehicles>? vehicles;

    User({this.id, this.name, this.email, this.username, this.phone, this.avatar, this.status, this.emailVerifiedAt, this.createdAt, this.updatedAt, this.deletedAt, this.countryId, this.regionId, this.cityId, this.driverProfile, this.vehicles});

    User.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        name = json["name"];
        email = json["email"];
        username = json["username"];
        phone = json["phone"];
        avatar = json["avatar"];
        status = json["status"];
        emailVerifiedAt = json["email_verified_at"];
        createdAt = json["created_at"];
        updatedAt = json["updated_at"];
        deletedAt = json["deleted_at"];
        countryId = json["country_id"];
        regionId = json["region_id"];
        cityId = json["city_id"];
        driverProfile = json["driver_profile"] == null ? null : DriverProfile.fromJson(json["driver_profile"]);
        vehicles = json["vehicles"] == null ? null : (json["vehicles"] as List).map((e) => Vehicles.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["name"] = name;
        _data["email"] = email;
        _data["username"] = username;
        _data["phone"] = phone;
        _data["avatar"] = avatar;
        _data["status"] = status;
        _data["email_verified_at"] = emailVerifiedAt;
        _data["created_at"] = createdAt;
        _data["updated_at"] = updatedAt;
        _data["deleted_at"] = deletedAt;
        _data["country_id"] = countryId;
        _data["region_id"] = regionId;
        _data["city_id"] = cityId;
        if(driverProfile != null) {
            _data["driver_profile"] = driverProfile?.toJson();
        }
        if(vehicles != null) {
            _data["vehicles"] = vehicles?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class Vehicles {
    int? id;
    int? driverId;
    String? ownerName;
    String? ownerNationalId;
    String? plateNumber;
    String? vehicleModel;
    int? manufacturingYear;
    String? vehicleType;
    int? capacity;
    String? color;
    String? registrationNumber;
    String? registrationExpiry;
    String? insuranceNumber;
    String? insuranceExpiry;
    dynamic vehiclePhoto;
    dynamic registrationPhoto;
    dynamic insurancePhoto;
    String? status;
    String? notes;
    String? createdAt;
    String? updatedAt;
    dynamic deletedAt;
    dynamic stampPhoto;
    dynamic logoPhoto;

    Vehicles({this.id, this.driverId, this.ownerName, this.ownerNationalId, this.plateNumber, this.vehicleModel, this.manufacturingYear, this.vehicleType, this.capacity, this.color, this.registrationNumber, this.registrationExpiry, this.insuranceNumber, this.insuranceExpiry, this.vehiclePhoto, this.registrationPhoto, this.insurancePhoto, this.status, this.notes, this.createdAt, this.updatedAt, this.deletedAt, this.stampPhoto, this.logoPhoto});

    Vehicles.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        driverId = json["driver_id"];
        ownerName = json["owner_name"];
        ownerNationalId = json["owner_national_id"];
        plateNumber = json["plate_number"];
        vehicleModel = json["vehicle_model"];
        manufacturingYear = json["manufacturing_year"];
        vehicleType = json["vehicle_type"];
        capacity = json["capacity"];
        color = json["color"];
        registrationNumber = json["registration_number"];
        registrationExpiry = json["registration_expiry"];
        insuranceNumber = json["insurance_number"];
        insuranceExpiry = json["insurance_expiry"];
        vehiclePhoto = json["vehicle_photo"];
        registrationPhoto = json["registration_photo"];
        insurancePhoto = json["insurance_photo"];
        status = json["status"];
        notes = json["notes"];
        createdAt = json["created_at"];
        updatedAt = json["updated_at"];
        deletedAt = json["deleted_at"];
        stampPhoto = json["stamp_photo"];
        logoPhoto = json["logo_photo"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["driver_id"] = driverId;
        _data["owner_name"] = ownerName;
        _data["owner_national_id"] = ownerNationalId;
        _data["plate_number"] = plateNumber;
        _data["vehicle_model"] = vehicleModel;
        _data["manufacturing_year"] = manufacturingYear;
        _data["vehicle_type"] = vehicleType;
        _data["capacity"] = capacity;
        _data["color"] = color;
        _data["registration_number"] = registrationNumber;
        _data["registration_expiry"] = registrationExpiry;
        _data["insurance_number"] = insuranceNumber;
        _data["insurance_expiry"] = insuranceExpiry;
        _data["vehicle_photo"] = vehiclePhoto;
        _data["registration_photo"] = registrationPhoto;
        _data["insurance_photo"] = insurancePhoto;
        _data["status"] = status;
        _data["notes"] = notes;
        _data["created_at"] = createdAt;
        _data["updated_at"] = updatedAt;
        _data["deleted_at"] = deletedAt;
        _data["stamp_photo"] = stampPhoto;
        _data["logo_photo"] = logoPhoto;
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
    dynamic drivingLicensePhoto;
    dynamic nationalIdPhoto;
    dynamic profilePhoto;
    String? status;
    dynamic rejectionReason;
    String? createdAt;
    String? updatedAt;
    dynamic deletedAt;

    DriverProfile({this.id, this.userId, this.nationalId, this.nationality, this.drivingLicenseNumber, this.drivingLicenseExpiry, this.drivingLicensePhoto, this.nationalIdPhoto, this.profilePhoto, this.status, this.rejectionReason, this.createdAt, this.updatedAt, this.deletedAt});

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

class Trip {
    int? driverId;
    String? departureLocation;
    String? destinationLocation;
    String? departureTime;
    int? maxPassengers;
    String? notes;
    dynamic routeCoordinates;
    String? status;
    String? updatedAt;
    String? createdAt;
    int? id;
    int? totalPassengers;
    List<Seats>? seats;
    List<Passengers>? passengers;

    Trip({this.driverId, this.departureLocation, this.destinationLocation, this.departureTime, this.maxPassengers, this.notes, this.routeCoordinates, this.status, this.updatedAt, this.createdAt, this.id, this.totalPassengers, this.seats, this.passengers});

    Trip.fromJson(Map<String, dynamic> json) {
        driverId = json["driver_id"];
        departureLocation = json["departure_location"];
        destinationLocation = json["destination_location"];
        departureTime = json["departure_time"];
        maxPassengers = json["max_passengers"];
        notes = json["notes"];
        routeCoordinates = json["route_coordinates"];
        status = json["status"];
        updatedAt = json["updated_at"];
        createdAt = json["created_at"];
        id = json["id"];
        totalPassengers = json["total_passengers"];
        seats = json["seats"] == null ? null : (json["seats"] as List).map((e) => Seats.fromJson(e)).toList();
        passengers = json["passengers"] == null ? null : (json["passengers"] as List).map((e) => Passengers.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["driver_id"] = driverId;
        _data["departure_location"] = departureLocation;
        _data["destination_location"] = destinationLocation;
        _data["departure_time"] = departureTime;
        _data["max_passengers"] = maxPassengers;
        _data["notes"] = notes;
        _data["route_coordinates"] = routeCoordinates;
        _data["status"] = status;
        _data["updated_at"] = updatedAt;
        _data["created_at"] = createdAt;
        _data["id"] = id;
        _data["total_passengers"] = totalPassengers;
        if(seats != null) {
            _data["seats"] = seats?.map((e) => e.toJson()).toList();
        }
        if(passengers != null) {
            _data["passengers"] = passengers?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class Passengers {
    int? id;
    int? tripId;
    int? seatId;
    String? name;
    String? phone;
    String? nationalId;
    dynamic passportNumber;
    dynamic gender;
    dynamic age;
    String? nationality;
    dynamic emergencyContactName;
    dynamic emergencyContactPhone;
    dynamic boardingLocation;
    dynamic destinationLocation;
    dynamic ticketNumber;
    String? status;
    dynamic boardingTime;
    dynamic disembarkationTime;
    dynamic notes;
    dynamic photo;
    String? createdAt;
    String? updatedAt;
    dynamic deletedAt;

    Passengers({this.id, this.tripId, this.seatId, this.name, this.phone, this.nationalId, this.passportNumber, this.gender, this.age, this.nationality, this.emergencyContactName, this.emergencyContactPhone, this.boardingLocation, this.destinationLocation, this.ticketNumber, this.status, this.boardingTime, this.disembarkationTime, this.notes, this.photo, this.createdAt, this.updatedAt, this.deletedAt});

    Passengers.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        tripId = json["trip_id"];
        seatId = json["seat_id"];
        name = json["name"];
        phone = json["phone"];
        nationalId = json["national_id"];
        passportNumber = json["passport_number"];
        gender = json["gender"];
        age = json["age"];
        nationality = json["nationality"];
        emergencyContactName = json["emergency_contact_name"];
        emergencyContactPhone = json["emergency_contact_phone"];
        boardingLocation = json["boarding_location"];
        destinationLocation = json["destination_location"];
        ticketNumber = json["ticket_number"];
        status = json["status"];
        boardingTime = json["boarding_time"];
        disembarkationTime = json["disembarkation_time"];
        notes = json["notes"];
        photo = json["photo"];
        createdAt = json["created_at"];
        updatedAt = json["updated_at"];
        deletedAt = json["deleted_at"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["trip_id"] = tripId;
        _data["seat_id"] = seatId;
        _data["name"] = name;
        _data["phone"] = phone;
        _data["national_id"] = nationalId;
        _data["passport_number"] = passportNumber;
        _data["gender"] = gender;
        _data["age"] = age;
        _data["nationality"] = nationality;
        _data["emergency_contact_name"] = emergencyContactName;
        _data["emergency_contact_phone"] = emergencyContactPhone;
        _data["boarding_location"] = boardingLocation;
        _data["destination_location"] = destinationLocation;
        _data["ticket_number"] = ticketNumber;
        _data["status"] = status;
        _data["boarding_time"] = boardingTime;
        _data["disembarkation_time"] = disembarkationTime;
        _data["notes"] = notes;
        _data["photo"] = photo;
        _data["created_at"] = createdAt;
        _data["updated_at"] = updatedAt;
        _data["deleted_at"] = deletedAt;
        return _data;
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
    dynamic price;
    bool? isPremium;
    dynamic notes;
    String? createdAt;
    String? updatedAt;
    dynamic deletedAt;

    Seats({this.id, this.tripId, this.seatNumber, this.rowNumber, this.columnNumber, this.seatType, this.status, this.passengerId, this.price, this.isPremium, this.notes, this.createdAt, this.updatedAt, this.deletedAt});

    Seats.fromJson(Map<String, dynamic> json) {
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