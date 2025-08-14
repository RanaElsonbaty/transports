part of 'creating_trip_cubit.dart';

sealed class CreatingTripState extends Equatable {
  const CreatingTripState();

  @override
  List<Object> get props => [];
}

final class CreatingTripInitial extends CreatingTripState {}
final class CreatingTripLoading extends CreatingTripState {}
final class CreatingTripSuccess extends CreatingTripState {
  final CreatingTripModel trips;
  const CreatingTripSuccess(this.trips);
}
final class CreatingTripFailure extends CreatingTripState {
  final String errorMessage;

  const CreatingTripFailure({required this.errorMessage});

}
