import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:transports/core/constant/end_point.dart';
import 'package:transports/core/failure/failure.dart';
import 'package:transports/core/service/api_service.dart';
import 'package:transports/core/storage/shared_prefs.dart';
import 'package:transports/features/home/data/models/profile_model.dart';
import 'package:transports/features/home/data/repos/profile/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo{
  ApiService apiService;
  SharedPrefs sharedPrefs;
  ProfileRepoImpl(this.apiService,this.sharedPrefs);

  @override
  Future<Either<Failure,ProfileModel>> getProfiles()async {
      final token=await sharedPrefs.getToken();
  try {
  final response= await apiService.get(EndPoints.profile,headers: {
    "Authorization":"Bearer $token"
  });
  final data =ProfileModel.fromJson(response);
  log("Profile data: ${data.toJson()}");
  // ✅ حفظ قيمة الـ capacity في SharedPreferences
  if (data.data != null &&
      data.data!.vehicles != null &&
      data.data!.vehicles!.isNotEmpty) {
    final capacity = data.data!.vehicles!.first.capacity;
    if (capacity != null) {
      await sharedPrefs.saveCapacity(capacity);
      log("✅ Capacity saved to SharedPrefs: $capacity");
    }
  }
// ✅ حفظ قيمة الـ vehicleType في SharedPreferences
    if (data.data != null &&
        data.data!.vehicles != null &&
        data.data!.vehicles!.isNotEmpty) {
      final vehicleType = data.data!.vehicles!.first.vehicleType;
      if (vehicleType != null) {
        await sharedPrefs.saveVehicleType(vehicleType);
        log("✅ vehicleType saved to SharedPrefs: $vehicleType");
      }
    }
  return right(data);
} on Failure catch (e) {
return left(ServerFailure(e.errorMessage));
}catch(e){
  return left(ServerFailure(e.toString()));
}

}

}