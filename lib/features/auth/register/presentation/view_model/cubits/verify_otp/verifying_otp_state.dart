part of 'verifying_otp_cubit.dart';

sealed class VerifyingOtpState extends Equatable {
  const VerifyingOtpState();

  @override
  List<Object> get props => [];
}

final class VerifyingOtpInitial extends VerifyingOtpState {}
final class VerifyingOtpLoading extends VerifyingOtpState {}
final class VerifyingOtpSuccess extends VerifyingOtpState {
  final VerifyingOtpModel verifyingOtpModel;

  const VerifyingOtpSuccess(this.verifyingOtpModel);
}
final class VerifyingOtpFailure extends VerifyingOtpState {
  final String errorMessage ;

  const VerifyingOtpFailure({required this.errorMessage});
  
}
