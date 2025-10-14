class DeletePassengerModel {
  final bool success;
  final String message;

  DeletePassengerModel({
    required this.success,
    required this.message,
  });

  factory DeletePassengerModel.fromJson(Map<String, dynamic> json) {
    return DeletePassengerModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
