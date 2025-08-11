import 'package:dartz/dartz.dart';
import 'package:transports/core/constant/constant.dart';
import 'package:transports/core/constant/end_point.dart';
import 'package:transports/core/failure/failure.dart';
import 'package:transports/core/service/api_service.dart';
import 'package:transports/core/storage/shared_prefs.dart';
import 'package:transports/features/auth/data/models/otp/resend_otp_model.dart';
import 'package:transports/features/auth/data/models/otp/send_otp_model.dart';
import 'package:transports/features/auth/data/models/otp/verify_otp_model.dart';
import 'package:transports/features/auth/data/repos/otp_repo.dart';

class OtpRepoImpl  extends OtpRepo{
    final SharedPrefs sharedPrefService;

  ApiService apiService;
  OtpRepoImpl( {required this.apiService,required this.sharedPrefService,});
  @override
  Future<Either<Failure, SendingOtpModel>> sendOtp({required String phoneNumber})async {
 try {
  final response = await apiService.post(EndPoints.sendOtp, data: {
     "phone":phoneNumber,
      "country_code":Constant.countryCode,
  });
  
  final otp=  SendingOtpModel.fromJson(response);
print('OTP Code: ${otp.data!.otp}');
  return right(otp);
} on Failure catch (e) {
return left(ServerFailure(e.errorMessage));
} catch(e){
return left(ServerFailure(e.toString()));
}
  }
  
  @override
  Future<Either<Failure, VerifyingOtpModel>> verifyOtp({required String phoneNumber, required String otpCode})async {
  
  try {
  final response=await apiService.post(EndPoints.verifyOtp, data: {
   "phone":phoneNumber,
  "country_code":Constant.countryCode,
    "otp_code":otpCode
  });
   final result= VerifyingOtpModel.fromJson(response);
  final token= await sharedPrefService.saveToken(result.data!.token!);
print("tokenSaved");
  return right(result);
} on Failure catch (e) {
  return left(ServerFailure(e.errorMessage));
}catch(e){
  return left(ServerFailure(e.toString()));
}
  }
  
  @override
  Future<Either<Failure, ResendOtpModel>> resendOtp({required String phoneNumber}) async{

  try {
  final response=await apiService.post(EndPoints.resendOtp, data: {
   "phone":phoneNumber,
  "country_code":Constant.countryCode,
  });
   final result= ResendOtpModel.fromJson(response);
  return right(result);
} on Failure catch (e) {
  return left(ServerFailure(e.errorMessage));
}catch(e){
  return left(ServerFailure(e.toString()));
}


  }

}