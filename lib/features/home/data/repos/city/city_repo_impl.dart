import 'package:dartz/dartz.dart';
import 'package:transports/core/constant/end_point.dart';
import 'package:transports/core/failure/failure.dart';
import 'package:transports/core/service/api_service.dart';
import 'package:transports/core/storage/shared_prefs.dart';
import 'package:transports/features/home/data/models/city_model.dart';
import 'package:transports/features/home/data/repos/city/city_repo.dart';

class CityRepoImpl  extends CityRepo{
  ApiService apiService;
  SharedPrefs sharedPrefs;
  CityRepoImpl( {required this.apiService,required this.sharedPrefs});

  @override
  Future<Either<Failure,List<Data>>> getCities()async {
final token = await sharedPrefs.getToken();

try {
  final response= await apiService.get(EndPoints.cities,headers: {
    "Authorization":"Bearer $token",
  });
   final result= (response["data"] as List).map((e)=>Data.fromJson(e)).toList();
  return right(result);
} on Failure catch (e) {
return left(ServerFailure(e.errorMessage));
}catch(e){
return  left(ServerFailure(e.toString()));

}

  }

}