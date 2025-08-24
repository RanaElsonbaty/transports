import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transports/features/auth/data/models/driver_info_model.dart';
import 'package:transports/features/auth/data/repos/driver/driver_info_repo.dart';

part 'driver_info_state.dart';

class DriverInfoCubit extends Cubit<DriverInfoState> {
  DriverInfoCubit({required this.driverInfoRepo}) : super(DriverInfoInitial());
  DriverInfoRepo driverInfoRepo;
  Future<void>addDriverInfo({required String name, required String nationalId, required String nationality, required String drivingLicenseNumber, required String drivingLicensExpiry})async{
emit(DriverInfoLoading());
final result=  await driverInfoRepo.addDriverInfo(name: name, nationalId: nationalId, nationality: nationality,  );
  result.fold((fail)=>emit(DriverInfoFailure(errorMessage: fail.errorMessage)), (data)=>emit(DriverInfoSuccess(data)));
  }
}
