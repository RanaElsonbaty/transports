import 'package:dartz/dartz.dart';
import 'package:transports/core/failure/failure.dart';
import 'package:transports/features/home/data/models/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure,ProfileModel>>getProfiles();
}