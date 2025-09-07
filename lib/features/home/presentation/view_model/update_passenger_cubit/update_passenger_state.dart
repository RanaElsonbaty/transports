abstract class UpdatePassengerState {}

class UpdatePassengerInitial extends UpdatePassengerState {}

class UpdatePassengerLoading extends UpdatePassengerState {}

class UpdatePassengerSuccess extends UpdatePassengerState {
  final String message;
  final Map<String, dynamic> passenger;

  UpdatePassengerSuccess(this.message, this.passenger);
}

class UpdatePassengerFailure extends UpdatePassengerState {
  final String errorMessage;

  UpdatePassengerFailure(this.errorMessage);
}
