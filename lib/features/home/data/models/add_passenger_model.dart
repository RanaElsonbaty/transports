class AddPassengerModel {
  final bool success;
  final String message;
  final PassengerData? data;

  AddPassengerModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory AddPassengerModel.fromJson(Map<String, dynamic> json) {
    return AddPassengerModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? PassengerData.fromJson(json['data']) : null,
    );
  }
}

class PassengerData {
  final int id;
  final int tripId;
  final int seatId;
  final String? name;
  final String? phone;
  final String? nationalId;
  final String? nationality;
  final String? status;
  final String? photo;

  PassengerData({
    required this.id,
    required this.tripId,
    required this.seatId,
    this.name,
    this.phone,
    this.nationalId,
    this.nationality,
    this.status,
    this.photo,
  });

  factory PassengerData.fromJson(Map<String, dynamic> json) {
    return PassengerData(
      id: json['id'],
      tripId: json['trip_id'],
      seatId: json['seat_id'],
      name: json['name'],
      phone: json['phone'],
      nationalId: json['national_id'],
      nationality: json['nationality'],
      status: json['status'],
      photo: json['photo'],
    );
  }
}
