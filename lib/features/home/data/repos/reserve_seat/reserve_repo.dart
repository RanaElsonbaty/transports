import 'package:dartz/dartz.dart';
import 'package:transports/core/failure/failure.dart';
import 'package:transports/features/home/data/models/reserve_model.dart';

abstract class ReserveRepo {
  Future<Either<Failure,ReservingData>>reserveSeat(String tripId,String seatId);
}