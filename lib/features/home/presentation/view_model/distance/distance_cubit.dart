import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:transports/core/storage/shared_prefs.dart';
import 'package:transports/features/home/data/models/distance_model.dart';
part 'distance_state.dart';

class DistanceCubit extends Cubit<DistanceState> {
  DistanceCubit() : super(DistanceInitial());

  final Dio _dio = Dio();
  void reset() {
    emit(DistanceInitial());
  }
  Future<void> calculateDistance({
    required int fromCityId,
    required int toCityId,
  }) async {
    emit(DistanceLoading());
    try {
      final token = await SharedPrefs().getToken();
      final response = await _dio.post(
        'https://my-bus.storage-te.com/api/cities/calculate-distance',
        data: {
          'from_city_id': fromCityId,
          'to_city_id': toCityId,
        },
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      log('Distance Response: ${response.data}');
      final distanceModel = DistanceModel.fromJson(response.data);
      emit(DistanceSuccess(distanceModel));
    } catch (e) {
      log('Distance Error: $e');
      emit(DistanceFailure('Failed to calculate distance'));
    }
  }
}
