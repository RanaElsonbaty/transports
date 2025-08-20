import 'package:dartz/dartz.dart';
import 'package:transports/core/failure/failure.dart';
import 'package:transports/features/home/data/models/previous_trips.dart';

abstract class PreviousTripRepo  {
Future<Either<Failure,List<Data1>>>getTrips();

}