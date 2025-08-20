import 'package:dartz/dartz.dart';
import 'package:transports/core/failure/failure.dart';
import 'package:transports/features/auth/data/models/log_out_model.dart';

abstract class LogOutRepo {
Future<Either<Failure,LogOutModel>>logOut();

}