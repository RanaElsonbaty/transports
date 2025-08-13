import 'package:dartz/dartz.dart';
import 'package:transports/core/failure/failure.dart';
import 'package:transports/features/auth/data/models/otp/resend_otp_model.dart';
import 'package:transports/features/auth/data/models/otp/send_otp_model.dart';
import 'package:transports/features/auth/data/models/otp/verify_otp_model.dart';

abstract class OtpRepo {
Future<Either<Failure,SendingOtpModel>>sendOtp({required String phoneNumber});
Future<Either<Failure,VerifyingOtpModel>>verifyOtp({required String phoneNumber,required String otpCode});
Future<Either<Failure,ResendOtpModel>>resendOtp({required String phoneNumber});

}