import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transports/features/home/data/models/reserve_model.dart';
import 'package:transports/features/home/data/repos/reserve_seat/reserve_repo.dart';

part 'reserve_seat_state.dart';

class ReserveSeatCubit extends Cubit<ReserveSeatState> {
  ReserveSeatCubit(this.reserveRepo) : super(ReserveSeatInitial());

  ReserveRepo reserveRepo;
  Future<void>reserveSeats(String tripId,String seatId)async{
    emit(ReserveSeatLoading());
final result= await reserveRepo.reserveSeat(tripId,seatId);
result.fold((fail)=>emit(ReserveSeatFailure(errorMessage: fail.errorMessage)), (data)=>emit(ReserveSeatSucces(data)));
  }

}
