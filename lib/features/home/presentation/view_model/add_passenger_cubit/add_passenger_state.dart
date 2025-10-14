import 'package:transports/features/home/data/models/add_passenger_model.dart';

abstract class AddPassengerState {}

class AddPassengerInitial extends AddPassengerState {}

class AddPassengerLoading extends AddPassengerState {}

class AddPassengerSuccess extends AddPassengerState {
  final AddPassengerModel model;
  AddPassengerSuccess(this.model);
}

class AddPassengerFailure extends AddPassengerState {
  final String error;
  AddPassengerFailure(this.error);
}
