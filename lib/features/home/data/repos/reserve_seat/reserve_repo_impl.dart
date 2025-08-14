import 'package:dartz/dartz.dart';
import 'package:transports/core/constant/end_point.dart';
import 'package:transports/core/failure/failure.dart';
import 'package:transports/core/service/api_service.dart';
import 'package:transports/core/storage/shared_prefs.dart';
import 'package:transports/features/home/data/models/reserve_model.dart';
import 'package:transports/features/home/data/repos/reserve_seat/reserve_repo.dart';

class ReserveRepoImpl  extends ReserveRepo{
  ApiService apiService;
  SharedPrefs sharedPrefs;
ReserveRepoImpl(this.apiService,this.sharedPrefs);
  @override
  @override
Future<Either<Failure, ReservingData>> reserveSeat(String tripId, String seatId) async {
  final token = await sharedPrefs.getToken();
  try {
    final response = await apiService.post(
      EndPoints.reserveSeat(tripId, seatId),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print(response);

    final reservingData = ReservingData.fromJson(response["data"]);
    return right(reservingData);
  } on Failure catch (e) {
    return left(ServerFailure(e.errorMessage));
  } catch (e) {
    return left(ServerFailure(e.toString()));
  }
}

  


}