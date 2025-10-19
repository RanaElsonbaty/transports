class UpdateDriverModel {
  final bool? success;
  final String? message;
  final DriverData? data;

  UpdateDriverModel({this.success, this.message, this.data});

  factory UpdateDriverModel.fromJson(Map<String, dynamic> json) {
    return UpdateDriverModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? DriverData.fromJson(json['data']) : null,
    );
  }
}

class DriverData {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? avatarUrl;
  final DriverProfile? driverProfile;

  DriverData({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.avatarUrl,
    this.driverProfile,
  });

  factory DriverData.fromJson(Map<String, dynamic> json) {
    return DriverData(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
      driverProfile: json['driver_profile'] != null
          ? DriverProfile.fromJson(json['driver_profile'])
          : null,
    );
  }
}

class DriverProfile {
  final int? id;
  final int? userId;
  final String? nationalId;
  final String? nationality;
  final String? nationalIdPhoto;
  final String? profilePhoto;
  final String? status;

  DriverProfile({
    this.id,
    this.userId,
    this.nationalId,
    this.nationality,
    this.nationalIdPhoto,
    this.profilePhoto,
    this.status,
  });

  factory DriverProfile.fromJson(Map<String, dynamic> json) {
    return DriverProfile(
      id: json['id'],
      userId: json['user_id'],
      nationalId: json['national_id'],
      nationality: json['nationality'],
      nationalIdPhoto: json['national_id_photo'],
      profilePhoto: json['profile_photo'],
      status: json['status'],
    );
  }
}
