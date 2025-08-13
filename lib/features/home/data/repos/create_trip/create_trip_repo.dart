import 'package:dartz/dartz.dart';
import 'package:transports/core/failure/failure.dart';
import 'package:transports/features/home/data/models/creating_trip.dart';

abstract class CreateTripRepo {
  Future<Either<Failure,CreatingTripModel>>createTrip({required String departureLocation,
    required String destinationLocation,
    required int maxPassengers,
    required List<Map<String, dynamic>> passengers,});
}