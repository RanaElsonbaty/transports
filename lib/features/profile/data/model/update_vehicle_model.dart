class UpdateVehicleModel {
  final bool? success;
  final String? message;
  final VehicleData? data;

  UpdateVehicleModel({this.success, this.message, this.data});

  factory UpdateVehicleModel.fromJson(Map<String, dynamic> json) {
    return UpdateVehicleModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? VehicleData.fromJson(json['data']) : null,
    );
  }
}

class VehicleData {
  final int? id;
  final int? driverId;
  final String? ownerName;
  final String? ownerNationalId;
  final String? plateNumber;
  final String? vehicleModel;
  final int? manufacturingYear;
  final String? vehicleType;
  final int? capacity;
  final String? color;
  final String? registrationNumber;
  final String? registrationExpiry;
  final String? insuranceNumber;
  final String? insuranceExpiry;
  final String? status;
  final String? notes;
  final String? createdAt;
  final String? updatedAt;
  final String? stampPhoto;
  final String? logoPhoto;
  final String? companyPhone;
  final String? companyTaxNumber;
  final String? companyAddress;

  VehicleData({
    this.id,
    this.driverId,
    this.ownerName,
    this.ownerNationalId,
    this.plateNumber,
    this.vehicleModel,
    this.manufacturingYear,
    this.vehicleType,
    this.capacity,
    this.color,
    this.registrationNumber,
    this.registrationExpiry,
    this.insuranceNumber,
    this.insuranceExpiry,
    this.status,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.stampPhoto,
    this.logoPhoto,
    this.companyPhone,
    this.companyTaxNumber,
    this.companyAddress,
  });

  factory VehicleData.fromJson(Map<String, dynamic> json) {
    return VehicleData(
      id: json['id'],
      driverId: json['driver_id'],
      ownerName: json['owner_name'],
      ownerNationalId: json['owner_national_id'],
      plateNumber: json['plate_number'],
      vehicleModel: json['vehicle_model'],
      manufacturingYear: json['manufacturing_year'],
      vehicleType: json['vehicle_type'],
      capacity: json['capacity'],
      color: json['color'],
      registrationNumber: json['registration_number'],
      registrationExpiry: json['registration_expiry'],
      insuranceNumber: json['insurance_number'],
      insuranceExpiry: json['insurance_expiry'],
      status: json['status'],
      notes: json['notes'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      stampPhoto: json['stamp_photo'],
      logoPhoto: json['logo_photo'],
      companyPhone: json['company_phone'],
      companyTaxNumber: json['company_tax_number'],
      companyAddress: json['company_address'],
    );
  }
}
