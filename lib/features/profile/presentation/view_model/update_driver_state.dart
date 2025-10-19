import 'package:equatable/equatable.dart';
import 'package:transports/features/profile/data/model/update_driver_model.dart';

abstract class UpdateDriverState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateDriverInitial extends UpdateDriverState {}

class UpdateDriverLoading extends UpdateDriverState {}

class UpdateDriverSuccess extends UpdateDriverState {
  final UpdateDriverModel model;
  UpdateDriverSuccess(this.model);
  @override
  List<Object?> get props => [model];
}

class UpdateDriverFailure extends UpdateDriverState {
  final String message;
  UpdateDriverFailure(this.message);
  @override
  List<Object?> get props => [message];
}
