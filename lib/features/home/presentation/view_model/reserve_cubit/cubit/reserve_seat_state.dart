part of 'reserve_seat_cubit.dart';

sealed class ReserveSeatState extends Equatable {
  const ReserveSeatState();

  @override
  List<Object> get props => [];
}

final class ReserveSeatInitial extends ReserveSeatState {}
final class ReserveSeatLoading extends ReserveSeatState {}
final class ReserveSeatSucces extends ReserveSeatState {
  final ReservingData reservingData;

  const ReserveSeatSucces(this.reservingData);

}
final class ReserveSeatFailure extends ReserveSeatState {
  final String errorMessage;

  const ReserveSeatFailure({required this.errorMessage});

}
