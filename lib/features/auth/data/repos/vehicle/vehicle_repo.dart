import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:transports/core/failure/failure.dart';
import 'package:transports/features/auth/data/models/vehicle_info_model.dart';

abstract class VehicleRepo {
  Future<Either<Failure,VehicleInfoModel>>addVehicleInfo({required String ownerName,required String ownerNationalId,required String plateNumber,  required String vehicleModel ,required String manufacturingYear,required int capacity,
    String? stamp,
    String? logo,
    String? companyPhone,
    String? companyTaxNumber,
    String? companyAddress,
    File? drivingLicensePhoto});
}