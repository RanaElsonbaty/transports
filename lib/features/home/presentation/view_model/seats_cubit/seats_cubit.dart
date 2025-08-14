
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transports/features/home/data/models/seats_model.dart';
import 'package:transports/features/home/data/repos/seats/seats_repo.dart';

part 'seats_state.dart';

class SeatsCubit extends Cubit<SeatsState> {
  SeatsCubit(this.seatsRepo) : super(SeatsInitial());

  SeatsRepo seatsRepo;
  Future<void>getSeats(String busType)async{
    emit(SeatsLoading());
final result= await seatsRepo.fetchSeats(busType);
result.fold((fail)=>emit(SeatsFailure(errorMessage: fail.errorMessage)), (data)=>emit(SeatsSuccess(data)));
  }


}

