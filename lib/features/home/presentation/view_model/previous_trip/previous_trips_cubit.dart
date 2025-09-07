import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transports/features/home/data/models/previous_trips.dart';
import 'package:transports/features/home/data/repos/previous_trips/previous_trip_repo.dart';

part 'previous_trips_state.dart';

class PreviousTripsCubit extends Cubit<PreviousTripsState> {
  PreviousTripsCubit(this.tripsRepo) : super(PreviousTripsInitial());
  PreviousTripRepo tripsRepo;
  Future<void>getTrips()async{
    emit(PreviousTripsLoading());
final trips=  await tripsRepo.getTrips();
trips.fold((fail)=>emit(PreviousTripsFailure(errorMessage: fail.errorMessage)), (success)=>emit(PreviousTripsSuccess(success)));
  }
}
