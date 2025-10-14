import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transports/features/home/data/models/creating_trip.dart';
import 'package:transports/features/home/data/repos/create_trip/create_trip_repo.dart';

part 'creating_trip_state.dart';

class CreatingTripCubit extends Cubit<CreatingTripState> {
  CreatingTripCubit(this.createTripRepo) : super(CreatingTripInitial());
  final CreateTripRepo createTripRepo;
  void reset() {
    emit(CreatingTripInitial());
  }
  Future<void> createTrip({
    required String departureLocation,
    required String destinationLocation,
    required int maxPassengers,
    required double distanceKm,
    required List<Map<String, dynamic>> passengers,
    List<Map<String, dynamic>>? drivers,
  }) async {
    emit(CreatingTripLoading());

    final trip = await createTripRepo.createTrip(
      departureLocation: departureLocation,
      destinationLocation: destinationLocation,
      maxPassengers: maxPassengers,
      distanceKm: distanceKm,
      passengers: passengers,
      drivers: drivers,
    );

    trip.fold(
          (fail) => emit(CreatingTripFailure(errorMessage: fail.errorMessage)),
          (data) => emit(CreatingTripSuccess(data)),
    );
  }
}
