import 'package:transports/features/home/data/models/delete_passenger_model.dart';

abstract class DeletePassengerState {}

class DeletePassengerInitial extends DeletePassengerState {}

class DeletePassengerLoading extends DeletePassengerState {}

class DeletePassengerSuccess extends DeletePassengerState {
  final DeletePassengerModel model;
  DeletePassengerSuccess(this.model);
}

class DeletePassengerFailure extends DeletePassengerState {
  final String error;
  DeletePassengerFailure(this.error);
}
