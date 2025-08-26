part of 'distance_cubit.dart';

@immutable
abstract class DistanceState {}

class DistanceInitial extends DistanceState {}

class DistanceLoading extends DistanceState {}

class DistanceSuccess extends DistanceState {
  final DistanceModel distanceModel;
  DistanceSuccess(this.distanceModel);
}

class DistanceFailure extends DistanceState {
  final String error;
  DistanceFailure(this.error);
}
