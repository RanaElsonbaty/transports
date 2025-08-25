import 'package:dartz/dartz.dart';
import 'package:transports/core/constant/end_point.dart';
import 'package:transports/core/failure/failure.dart';
import 'package:transports/core/service/api_service.dart';
import 'package:transports/core/storage/shared_prefs.dart';
import 'package:transports/features/auth/data/models/log_out_model.dart';
import 'package:transports/features/auth/data/repos/log_out/log_out_repo.dart';

class LogOutRepoImpl extends LogOutRepo{
  final SharedPrefs sharedPrefService;
  final ApiService apiService;
  LogOutRepoImpl(this.apiService,this.sharedPrefService);
  @override
  Future<Either<Failure, LogOutModel>> logOut() async{
    try {
  final token=await sharedPrefService.getToken();
    final response= await apiService.post(EndPoints.logOut,headers: {
  'Authorization':"Bearer $token"
    });
    await sharedPrefService.removeToken();
  final data=  LogOutModel.fromJson(response);
    return right(data);
} on Failure catch (e) {
return left(ServerFailure(e.errorMessage));
}catch(e){
  return left(ServerFailure(e.toString()));

}
  
} 

}