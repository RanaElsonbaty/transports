import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transports/features/auth/data/models/otp/send_otp_model.dart';
import 'package:transports/features/auth/data/repos/otp_repo.dart';

part 'sending_otp_state.dart';

class SendingOtpCubit extends Cubit<SendingOtpState> {
  SendingOtpCubit({required this.otpRepo}) : super(SendingOtpInitial());
  OtpRepo otpRepo;
  Future<void>sendOtp({required String phoneNumber})async{
    emit(SendingOtpLoading());
final result=await otpRepo.sendOtp(phoneNumber: phoneNumber);
result.fold((fail)=>emit( SendingOtpFailure(errorMessage: fail.errorMessage)), (data)=>emit(SendingOtpSuccess(data)));
  }
}
