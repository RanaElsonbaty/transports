import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:transports/core/failure/failure.dart';
import 'package:transports/features/auth/data/models/driver_info_model.dart';

abstract class DriverInfoRepo {
  Future<Either<Failure, DriverInfoModel>> addDriverInfo({
    required String name,
    required String nationalId,
    required String nationality,
    File? avatar,
    File? nationalIdPhoto,
  });
}
