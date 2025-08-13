import 'package:dartz/dartz.dart';
import 'package:transports/core/failure/failure.dart';
import 'package:transports/features/home/data/models/seats_model.dart';

abstract class SeatsRepo {
  Future<Either<Failure,List<Seats>>>fetchSeats(String busType);
}