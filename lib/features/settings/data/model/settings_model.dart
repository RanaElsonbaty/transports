class SettingsModel {
  final bool success;
  final String message;
  final SettingsData? data;

  SettingsModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? SettingsData.fromJson(json['data']) : null,
    );
  }
}

class SettingsData {
  final String? contactPhone;
  final String? contactEmail;

  SettingsData({this.contactPhone, this.contactEmail});

  factory SettingsData.fromJson(Map<String, dynamic> json) {
    return SettingsData(
      contactPhone: json['contact_phone'],
      contactEmail: json['contact_email'],
    );
  }
}
