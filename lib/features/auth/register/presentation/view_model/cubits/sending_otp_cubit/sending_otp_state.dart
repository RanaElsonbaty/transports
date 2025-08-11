part of 'sending_otp_cubit.dart';

sealed class SendingOtpState extends Equatable {
  const SendingOtpState();

  @override
  List<Object> get props => [];
}

final class SendingOtpInitial extends SendingOtpState {}
final class SendingOtpLoading extends SendingOtpState {}
final class SendingOtpSuccess extends SendingOtpState {
  final SendingOtpModel otpModel;

  const SendingOtpSuccess(this.otpModel);
}
final class SendingOtpFailure extends SendingOtpState {
  final String errorMessage;

  const SendingOtpFailure({required this.errorMessage});

}
