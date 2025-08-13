import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transports/features/auth/data/models/otp/verify_otp_model.dart';
import 'package:transports/features/auth/data/repos/otp/otp_repo.dart';

part 'verifying_otp_state.dart';

class VerifyingOtpCubit extends Cubit<VerifyingOtpState> {
  VerifyingOtpCubit({required this.otpRepo}) : super(VerifyingOtpInitial());
  OtpRepo otpRepo;
  Future<void>verifyingOtp({required String phoneNumber,required  String otpCode})async{
    emit(VerifyingOtpLoading());
final otp= await otpRepo.verifyOtp(phoneNumber: phoneNumber, otpCode: otpCode);
  otp.fold((fail)=>emit(VerifyingOtpFailure(errorMessage: fail.errorMessage)), (data)=>emit(VerifyingOtpSuccess(data)));
  }
}
