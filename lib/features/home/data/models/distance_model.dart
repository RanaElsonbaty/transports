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
  final double? distanceKm;
  final double? durationMin;
  final City? fromCity;
  final City? toCity;

  DistanceData({
    this.distanceKm,
    this.durationMin,
    this.fromCity,
    this.toCity,
  });

  factory DistanceData.fromJson(Map<String, dynamic> json) {
    return DistanceData(
      distanceKm: json['distance_km'] != null
          ? double.tryParse(json['distance_km'].toString())
          : null,
      durationMin: json['duration_min'] != null
          ? double.tryParse(json['duration_min'].toString())
          : null,
      fromCity:
      json['from_city'] != null ? City.fromJson(json['from_city']) : null,
      toCity: json['to_city'] != null ? City.fromJson(json['to_city']) : null,
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
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString())
          : null,
    );
  }
}
