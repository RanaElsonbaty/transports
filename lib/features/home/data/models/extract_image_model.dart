class ExtractImageModel {
  final bool? success;
  final String? message;
  final Data? data;
  final dynamic errors;

  ExtractImageModel({
    this.success,
    this.message,
    this.data,
    this.errors,
  });

  factory ExtractImageModel.fromJson(Map<String, dynamic> json) {
    return ExtractImageModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      errors: json['errors'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
      'errors': errors,
    };
  }
}

class Data {
  final ExtractedData? extractedData;

  Data({this.extractedData});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      extractedData: json['extracted_data'] != null
          ? ExtractedData.fromJson(json['extracted_data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'extracted_data': extractedData?.toJson(),
    };
  }
}

class ExtractedData {
  final String? fullName;
  final String? nationality;
  final String? nationalId;
  final dynamic plateNumber;
  final dynamic vehicleModel;
  final dynamic manufacturingYear;
  final int? capacity;
  final String? ownerName;

  ExtractedData({
    this.fullName,
    this.nationality,
    this.nationalId,
    this.plateNumber,
    this.vehicleModel,
    this.manufacturingYear,
    this.capacity,
    this.ownerName,
  });

  factory ExtractedData.fromJson(Map<String, dynamic> json) {
    return ExtractedData(
      fullName: json['full_name'] as String?,
      nationality: json['nationality'] as String?,
      nationalId: json['national_id'] as String?,
      plateNumber: json['plate_number'],
      vehicleModel: json['vehicle_model'],
      manufacturingYear: json['manufacturing_year'],
      capacity: json['capacity'],
      ownerName: json['owner_name']as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'nationality': nationality,
      'national_id': nationalId,
      'plate_number': plateNumber,
      'vehicle_model': vehicleModel,
      'manufacturing_year': manufacturingYear,
      'capacity': capacity,
      'owner_name': ownerName,
    };
  }
}
