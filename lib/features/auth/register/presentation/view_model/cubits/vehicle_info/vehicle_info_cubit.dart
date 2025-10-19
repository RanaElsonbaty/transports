import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transports/features/auth/data/models/vehicle_info_model.dart';
import 'package:transports/features/auth/data/repos/vehicle/vehicle_repo.dart';

part 'vehicle_info_state.dart';

class VehicleInfoCubit extends Cubit<VehicleInfoState> {
  VehicleInfoCubit(this.vehicleRepo) : super(VehicleInfoInitial());
 VehicleRepo vehicleRepo;
  Future<void> addVehicleInfo({
    required String ownerName,
    required String ownerNationalId,
    required String plateNumber,
    required String vehicleModel,
    required int capacity,
    required String manufacturingYear,
    String? logo,
    String? stamp,
    String? companyPhone,
    String? companyTaxNumber,
    String? companyAddress,
    File? drivingLicensePhoto,
  }) async {
    emit(VehicleInfoLoading());

    final result = await vehicleRepo.addVehicleInfo(
      ownerName: ownerName,
      ownerNationalId: ownerNationalId,
      plateNumber: plateNumber,
      vehicleModel: vehicleModel,
      capacity: capacity,
      manufacturingYear: manufacturingYear,
      logo: logo,
      stamp: stamp,
      companyPhone: companyPhone,
      companyTaxNumber: companyTaxNumber,
      companyAddress: companyAddress,
      drivingLicensePhoto: drivingLicensePhoto
    );

    result.fold(
          (fail) => emit(VehicleInfoFailure(errorMessage: fail.errorMessage)),
          (data) => emit(VehicleInfoSuccess(data)),
    );
  }
}
