import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transports/features/auth/data/models/vehicle_info_model.dart';
import 'package:transports/features/auth/data/repos/vehicle/vehicle_repo.dart';

part 'vehicle_info_state.dart';

class VehicleInfoCubit extends Cubit<VehicleInfoState> {
  VehicleInfoCubit(this.vehicleRepo) : super(VehicleInfoInitial());
 VehicleRepo vehicleRepo;
  Future<void>addVehicleInfo({required String ownerName, required String ownerNationalId, required String plateNumber, required String vehicleModel, required String manufacturingYear, required String logo,required String stamp})async{
    emit(VehicleInfoLoading());
final otp= await vehicleRepo.addVehicleInfo(ownerName: ownerName, ownerNationalId: ownerNationalId, plateNumber: plateNumber, vehicleModel:vehicleModel , manufacturingYear:manufacturingYear, stamp: stamp, logo: logo );
  otp.fold((fail)=>emit(VehicleInfoFailure(errorMessage: fail.errorMessage)), (data)=>emit(VehicleInfoSuccess(data)));
  }
}
