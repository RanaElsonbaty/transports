part of 'driver_info_cubit.dart';

sealed class DriverInfoState extends Equatable {
  const DriverInfoState();

  @override
  List<Object> get props => [];
}

final class DriverInfoInitial extends DriverInfoState {}
final class DriverInfoLoading extends DriverInfoState {}
final class DriverInfoSuccess extends DriverInfoState {
  final DriverInfoModel driverInfoModel;

  const DriverInfoSuccess(this.driverInfoModel);
}
final class DriverInfoFailure extends DriverInfoState {
  final String errorMessage;

  const DriverInfoFailure({required this.errorMessage});
}
