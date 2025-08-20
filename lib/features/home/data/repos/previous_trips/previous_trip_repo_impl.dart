import 'package:dartz/dartz.dart';
import 'package:transports/core/constant/end_point.dart';
import 'package:transports/core/failure/failure.dart';
import 'package:transports/core/service/api_service.dart';
import 'package:transports/core/storage/shared_prefs.dart';
import 'package:transports/features/home/data/models/previous_trips.dart';
import 'package:transports/features/home/data/repos/previous_trips/previous_trip_repo.dart';

class PreviousTripRepoImpl  extends PreviousTripRepo{
  final ApiService apiService;
  final SharedPrefs sharedPreferences;

  PreviousTripRepoImpl({required this.apiService, required this.sharedPreferences});
  @override
  Future<Either<Failure, List<Data1>>> getTrips()async {
  try {
    final token=await sharedPreferences.getToken();
  final trips= await apiService.get(EndPoints.previousTrip,headers: {
    "Authorization":"Bearer $token"
  });
final List<dynamic> tripsJson = trips['data']['data'];
    final result = tripsJson.map((e) => Data1.fromJson(e)).toList();
  return right(result);
} on Failure catch (e) {
return left(ServerFailure(e.errorMessage));
}catch(e){
  return left(ServerFailure(e.toString()));
}
  }
}