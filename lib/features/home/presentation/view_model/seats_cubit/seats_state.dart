part of 'seats_cubit.dart';

sealed class SeatsState extends Equatable {
  const SeatsState();

  @override
  List<Object> get props => [];
}

final class SeatsInitial extends SeatsState {}
final class SeatsLoading extends SeatsState {}
final class SeatsSuccess extends SeatsState 
{
  final List<Seats> seatsSuccess;

  const SeatsSuccess(this.seatsSuccess);
}
final class SeatsFailure extends SeatsState {
  final String errorMessage;

  const SeatsFailure({required this.errorMessage});
}
