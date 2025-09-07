import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transports/features/home/presentation/view_model/update_passenger_cubit/update_passenger_state.dart';

class UpdatePassengerCubit extends Cubit<UpdatePassengerState> {
  UpdatePassengerCubit() : super(UpdatePassengerInitial());

  final Dio _dio = Dio();

  Future<void> updatePassenger({
    required int tripId,
    required int passengerId,
    required Map<String, dynamic> body,
  }) async {
    emit(UpdatePassengerLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final response = await _dio.put(
        "https://my-bus.storage-te.com/api/trips/$tripId/passengers/$passengerId",
        data: body,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );

      log("UPDATE PASSENGER RESPONSE => ${response.data}");

      if (response.statusCode == 200 && response.data['success'] == true) {
        emit(UpdatePassengerSuccess(
          response.data['message'] ?? "تم التحديث بنجاح",
          response.data['data'], // بيانات الراكب بعد التحديث
        ));
      } else {
        emit(UpdatePassengerFailure(
          response.data['message'] ?? "فشل التحديث",
        ));
      }
    } catch (e, st) {
      log("UPDATE PASSENGER ERROR => $e", stackTrace: st);
      emit(UpdatePassengerFailure(e.toString()));
    }
  }
}
