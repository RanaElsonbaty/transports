import 'package:dartz/dartz.dart';
import 'package:transports/core/constant/end_point.dart';
import 'package:transports/core/failure/failure.dart';
import 'package:transports/core/service/api_service.dart';
import 'package:transports/core/storage/shared_prefs.dart';
import 'package:transports/features/home/data/models/seats_model.dart';
import 'package:transports/features/home/data/repos/seats/seats_repo.dart';

class SeatsRepoImpl  extends SeatsRepo{
  ApiService apiService;
  SharedPrefs sharedPrefs;
  SeatsRepoImpl(this.apiService,this.sharedPrefs);
  @override
  Future<Either<Failure,List<Seats>>> fetchSeats(String busType)async {
final token=await sharedPrefs.getToken();
 try {
  final response =await apiService.get("${EndPoints.seats}/$busType",headers: {
    "Authorization":"Bearer $token",
  });
  print(response);
  final seatList = (response["data"]["seats"] as List)
      .map((item) => Seats.fromJson(item))
      .toList();
  return right(seatList);
} on Failure catch (e) {
return left(ServerFailure(e.errorMessage));
}catch(e){
  return left(ServerFailure(e.toString()));
}
  }

}