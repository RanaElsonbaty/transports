part of 'update_trip_cubit.dart';

abstract class UpdateTripState extends Equatable {
  const UpdateTripState();

  @override
  List<Object?> get props => [];
}

class UpdateTripInitial extends UpdateTripState {}

class UpdateTripLoading extends UpdateTripState {}

class UpdateTripSuccess extends UpdateTripState {
  final String message;

  const UpdateTripSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class UpdateTripFailure extends UpdateTripState {
  final String errorMessage;

  const UpdateTripFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
