import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transports/features/home/data/models/add_passenger_model.dart';
import 'add_passenger_state.dart';

class AddPassengerCubit extends Cubit<AddPassengerState> {
  AddPassengerCubit() : super(AddPassengerInitial());

  final Dio _dio = Dio(
    BaseOptions(baseUrl: "https://my-bus.storage-te.com/api"),
  );

  Future<void> addPassenger({
    required int tripId,
    required String name,
    required String nationalId,
    required String nationality,
    required int seatId,
    String? image,
  }) async {
    emit(AddPassengerLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final formData = FormData.fromMap({
        "name": name,
        "national_id": nationalId,
        "nationality": nationality,
        "seat_id": seatId,
        if (image != null) "image": image,
      });

      final response = await _dio.post(
        "/trips/$tripId/passengers",
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        ),
      );

      log("🚀 AddPassenger Response: ${response.data}");

      final model = AddPassengerModel.fromJson(response.data);

      if (model.success) {
        emit(AddPassengerSuccess(model));
      } else {
        emit(AddPassengerFailure(model.message));
      }
    } on DioException catch (e) {
      log("❌ DioException: ${e.response?.data}");
      emit(AddPassengerFailure(e.response?.data['message'] ?? "حدث خطأ ما"));
    } catch (e) {
      emit(AddPassengerFailure("خطأ غير متوقع: $e"));
    }
  }
}
