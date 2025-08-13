import 'package:dartz/dartz.dart';
import 'package:transports/core/failure/failure.dart';
import 'package:transports/features/home/data/models/city_model.dart';

abstract  class CityRepo {
  Future<Either<Failure,List <Data>>>getCities();
}