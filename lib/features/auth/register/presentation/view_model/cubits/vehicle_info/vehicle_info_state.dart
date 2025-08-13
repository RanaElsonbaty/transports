part of 'vehicle_info_cubit.dart';

sealed class VehicleInfoState extends Equatable {
  const VehicleInfoState();

  @override
  List<Object> get props => [];
}

final class VehicleInfoInitial extends VehicleInfoState {}
final class VehicleInfoLoading extends VehicleInfoState {}
final class VehicleInfoSuccess extends VehicleInfoState {
  final VehicleInfoModel vehicleInfoModel;

   const VehicleInfoSuccess(this.vehicleInfoModel);
  
}
final class VehicleInfoFailure extends VehicleInfoState {
  final String errorMessage;

  const VehicleInfoFailure({required this.errorMessage});

}
