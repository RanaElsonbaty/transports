import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:transports/core/constant/end_point.dart';
import 'package:transports/core/failure/failure.dart';
import 'package:transports/core/service/api_service.dart';
import 'package:transports/core/storage/shared_prefs.dart';
import 'package:transports/features/home/data/models/creating_trip.dart';
import 'package:transports/features/home/data/repos/create_trip/create_trip_repo.dart';

class CreateTripRepoImpl extends CreateTripRepo {
  ApiService apiService;
  SharedPrefs sharedPrefs;
  CreateTripRepoImpl(this.apiService, this.sharedPrefs);

  @override
  Future<Either<Failure, CreatingTripModel>> createTrip({
    required String departureLocation,
    required String destinationLocation,
    required int maxPassengers,
    required double distanceKm,
    required List<Map<String, dynamic>> passengers,
    List<Map<String, dynamic>>? drivers, // optional
  }) async {
    final token = await sharedPrefs.getToken();

    try {
      final data = {
        "departure_location": departureLocation,
        "destination_location": destinationLocation,
        "max_passengers": maxPassengers,
        "passengers": passengers,
        "distance_km": distanceKm,
        "trip_drivers": drivers ?? [],
      };

      final response = await apiService.post(
        EndPoints.createTrip,
        headers: {"Authorization": "Bearer $token"},
        data: data,
      );
      log("TRIP DATA : $data");
      final trip = CreatingTripModel.fromJson(response);
      return right(trip);
    } on Failure catch (e) {
      return left(ServerFailure(e.errorMessage));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
