import 'package:equatable/equatable.dart';
import 'package:transports/features/profile/data/model/update_vehicle_model.dart';

abstract class UpdateVehicleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateVehicleInitial extends UpdateVehicleState {}

class UpdateVehicleLoading extends UpdateVehicleState {}

class UpdateVehicleSuccess extends UpdateVehicleState {
  final UpdateVehicleModel updateVehicleModel;

  UpdateVehicleSuccess(this.updateVehicleModel);

  @override
  List<Object?> get props => [updateVehicleModel];
}

class UpdateVehicleFailure extends UpdateVehicleState {
  final String errorMessage;

  UpdateVehicleFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
