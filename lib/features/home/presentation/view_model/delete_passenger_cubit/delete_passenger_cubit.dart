import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transports/features/home/data/models/delete_passenger_model.dart';
import 'delete_passenger_state.dart';

class DeletePassengerCubit extends Cubit<DeletePassengerState> {
  DeletePassengerCubit() : super(DeletePassengerInitial());

  final Dio _dio = Dio(
    BaseOptions(baseUrl: "https://my-bus.storage-te.com/api"),
  );

  Future<void> deletePassenger({
    required int tripId,
    required int passengerId,
  }) async {
    emit(DeletePassengerLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final response = await _dio.delete(
        "/trips/$tripId/passengers/$passengerId",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );

      log("🚀 Delete response: ${response.data}");

      final model = DeletePassengerModel.fromJson(response.data);
      if (model.success) {
        emit(DeletePassengerSuccess(model));
      } else {
        emit(DeletePassengerFailure(model.message));
      }
    } on DioException catch (e) {
      emit(DeletePassengerFailure(
          e.response?.data['message'] ?? "حدث خطأ ما أثناء حذف الراكب"));
    } catch (e) {
      emit(DeletePassengerFailure("خطأ غير متوقع: $e"));
    }
  }
}
