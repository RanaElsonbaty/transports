import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'update_trip_state.dart';

class UpdateTripCubit extends Cubit<UpdateTripState> {
  UpdateTripCubit() : super(UpdateTripInitial());

  final Dio _dio = Dio();

  Future<void> updateTrip({
    required int tripId,
    required String departureLocation,
    required String destinationLocation,
    required double distanceKm,
  }) async {
    emit(UpdateTripLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final response = await _dio.put(
        "https://my-bus.storage-te.com/api/trips/$tripId",
        data: {
          "departure_location": departureLocation,
          "destination_location": destinationLocation,
          "distance_km": distanceKm,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
     log("UPDATED TRIP ${response.data}");
      if (response.data["success"] == true) {
        emit(UpdateTripSuccess(message: response.data["message"]));
      } else {
        emit(UpdateTripFailure(
          errorMessage: response.data["message"] ?? "Unknown error",
        ));
      }
    } catch (e) {
      emit(UpdateTripFailure(errorMessage: e.toString()));
    }
  }
}
