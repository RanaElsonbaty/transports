import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transports/features/auth/data/models/otp/resend_otp_model.dart';
import 'package:transports/features/auth/data/repos/otp/otp_repo.dart';

part 'resend_otp_state.dart';

class ResendOtpCubit extends Cubit<ResendOtpState> {
  ResendOtpCubit(this.otpRepo) : super(ResendOtpInitial());
  OtpRepo otpRepo;
  Future<void>resendOtp({required String phoneNumber})async{
    emit(ResendOtpLoading());
final result=await otpRepo.resendOtp(phoneNumber: phoneNumber);
result.fold((fail)=>emit( ResendOtpFailure(errorMessage: fail.errorMessage)), (data)=>emit(ResendOtpSuccess(data)));
  }


}
