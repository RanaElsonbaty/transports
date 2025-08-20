import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transports/features/auth/data/repos/log_out/log_out_repo.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit(this.logOutRepo) : super(LogOutInitial());
  final LogOutRepo logOutRepo;
  Future<void>logOut()async{
    emit(LogOutLoading());
    final response= await logOutRepo.logOut();
response.fold((fail)=>emit(LogOutFailure(errorMessage: fail.errorMessage)), (success)=>emit(LogOutSuccess(success.message??"")));
  
  }
}
