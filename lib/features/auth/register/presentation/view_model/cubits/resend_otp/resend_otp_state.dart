part of 'resend_otp_cubit.dart';

sealed class ResendOtpState extends Equatable {
  const ResendOtpState();

  @override
  List<Object> get props => [];
}

final class ResendOtpInitial extends ResendOtpState {}

final class ResendOtpLoading extends ResendOtpState {}

final class ResendOtpSuccess extends ResendOtpState {
  final ResendOtpModel resendOtpModel;

  const ResendOtpSuccess(this.resendOtpModel);
}

final class ResendOtpFailure extends ResendOtpState {
  final String errorMessage;

  const ResendOtpFailure({required this.errorMessage});
}
