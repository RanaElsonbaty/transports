class ExtractImageModel {
  final bool? success;
  final String? message;
  final ExtractedData? data;

  ExtractImageModel({this.success, this.message, this.data});

  factory ExtractImageModel.fromJson(Map<String, dynamic> json) {
    return ExtractImageModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? ExtractedData.fromJson(json['data']['extracted_data'])
          : null,
    );
  }
}

class ExtractedData {
  final String? fullName;
  final String? fullNameAr;
  final String? firstName;
  final String? lastName;
  final String? nationality;
  final String? nationalId;
  final String? dateOfExpiry;

  ExtractedData({
    this.fullName,
    this.fullNameAr,
    this.firstName,
    this.lastName,
    this.nationality,
    this.nationalId,
    this.dateOfExpiry,
  });

  factory ExtractedData.fromJson(Map<String, dynamic> json) {
    return ExtractedData(
      fullName: json['full_name'],
      fullNameAr: json['full_name_ar'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      nationality: json['nationality'],
      nationalId: json['national_id'],
      dateOfExpiry: json['date_of_expiry'],
    );
  }
}
