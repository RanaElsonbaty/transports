part of 'previous_trips_cubit.dart';

sealed class PreviousTripsState extends Equatable {
  const PreviousTripsState();

  @override
  List<Object> get props => [];
}

final class PreviousTripsInitial extends PreviousTripsState {}
final class PreviousTripsLoading extends PreviousTripsState {}
final class PreviousTripsSuccess extends PreviousTripsState {
  final List<Data1> trips;

  const PreviousTripsSuccess(this.trips);
}
final class PreviousTripsFailure extends PreviousTripsState {
  final String errorMessage ;

  const PreviousTripsFailure({required this.errorMessage});

}
