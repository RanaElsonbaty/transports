part of 'city_cubit.dart';

sealed class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

final class CityInitial extends CityState {}
final class CityLoading extends CityState {}
final class CitySuccess extends CityState {
  final List<Data>cities;

  const CitySuccess(this.cities);
}
final class CityFailure extends CityState {
  final String errorMessage;

  const CityFailure({required this.errorMessage});
}
