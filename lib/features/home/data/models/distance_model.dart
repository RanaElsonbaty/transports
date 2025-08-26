class DistanceModel {
  final bool? success;
  final String? message;
  final DistanceData? data;
  final dynamic errors;

  DistanceModel({
    this.success,
    this.message,
    this.data,
    this.errors,
  });

  factory DistanceModel.fromJson(Map<String, dynamic> json) {
    return DistanceModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null ? DistanceData.fromJson(json['data']) : null,
      errors: json['errors'],
    );
  }
}

class DistanceData {
  final City? fromCity;
  final City? toCity;
  final Distance? distance;
  final EstimatedTravelTime? estimatedTravelTime;

  DistanceData({
    this.fromCity,
    this.toCity,
    this.distance,
    this.estimatedTravelTime,
  });

  factory DistanceData.fromJson(Map<String, dynamic> json) {
    return DistanceData(
      fromCity:
      json['from_city'] != null ? City.fromJson(json['from_city']) : null,
      toCity: json['to_city'] != null ? City.fromJson(json['to_city']) : null,
      distance:
      json['distance'] != null ? Distance.fromJson(json['distance']) : null,
      estimatedTravelTime: json['estimated_travel_time'] != null
          ? EstimatedTravelTime.fromJson(json['estimated_travel_time'])
          : null,
    );
  }
}

class City {
  final int? id;
  final String? nameAr;
  final String? nameEn;
  final double? latitude;
  final double? longitude;

  City({
    this.id,
    this.nameAr,
    this.nameEn,
    this.latitude,
    this.longitude,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: int.tryParse(json['id'].toString()),
      nameAr: json['name_ar'] as String?,
      nameEn: json['name_en'] as String?,
      latitude: double.tryParse(json['latitude'].toString()),
      longitude: double.tryParse(json['longitude'].toString()),
    );
  }
}

class Distance {
  final double? kilometers;
  final double? meters;
  final double? miles;

  Distance({
    this.kilometers,
    this.meters,
    this.miles,
  });

  factory Distance.fromJson(Map<String, dynamic> json) {
    return Distance(
      kilometers: double.tryParse(json['kilometers'].toString()),
      meters: double.tryParse(json['meters'].toString()),
      miles: double.tryParse(json['miles'].toString()),
    );
  }
}

class EstimatedTravelTime {
  final TravelMode? car;
  final TravelMode? bus;
  final TravelMode? train;

  EstimatedTravelTime({
    this.car,
    this.bus,
    this.train,
  });

  factory EstimatedTravelTime.fromJson(Map<String, dynamic> json) {
    return EstimatedTravelTime(
      car: json['car'] != null ? TravelMode.fromJson(json['car']) : null,
      bus: json['bus'] != null ? TravelMode.fromJson(json['bus']) : null,
      train: json['train'] != null ? TravelMode.fromJson(json['train']) : null,
    );
  }
}

class TravelMode {
  final double? hours;
  final int? minutes;
  final String? formatted;
  final int? speedKmh;

  TravelMode({
    this.hours,
    this.minutes,
    this.formatted,
    this.speedKmh,
  });

  factory TravelMode.fromJson(Map<String, dynamic> json) {
    return TravelMode(
      hours: double.tryParse(json['hours'].toString()),
      minutes: int.tryParse(json['minutes'].toString()),
      formatted: json['formatted'] as String?,
      speedKmh: int.tryParse(json['speed_kmh'].toString()),
    );
  }
}
