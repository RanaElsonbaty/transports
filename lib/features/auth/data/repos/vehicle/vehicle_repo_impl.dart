import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:transports/core/constant/end_point.dart';
import 'package:transports/core/failure/failure.dart';
import 'package:transports/core/service/api_service.dart';
import 'package:transports/core/storage/shared_prefs.dart';
import 'package:transports/features/auth/data/models/vehicle_info_model.dart';
import 'package:transports/features/auth/data/repos/vehicle/vehicle_repo.dart';

class VehicleRepoImpl extends VehicleRepo {
  ApiService apiService;
  SharedPrefs sharedPrefs;
  VehicleRepoImpl(this.apiService, this.sharedPrefs);
  @override
  Future<Either<Failure, VehicleInfoModel>> addVehicleInfo(
      {required String ownerName,
      required String ownerNationalId,
      required String plateNumber,
      required String vehicleModel,
      required String manufacturingYear,
      required String logo,
      required String stamp}) async {
    try {
      final token = await sharedPrefs.getToken();
      final formData = FormData.fromMap({
        "owner_name": ownerName,
        "owner_national_id": ownerNationalId,
        "plate_number": plateNumber,
        "vehicle_model": vehicleModel,
        "manufacturing_year": manufacturingYear,
        "stamp_photo":
            await MultipartFile.fromFile(stamp, filename: "stamp.jpg"),
        "logo_photo": await MultipartFile.fromFile(logo, filename: "logo.jpg"),
      });
      final response = await apiService.post(
          headers: {"Authorization": "Bearer $token"},
          isFormData: true,
          EndPoints.addVehicleInfo,
          data: formData);

      final result = VehicleInfoModel.fromJson(response);
      return right(result);
    } on Failure catch (e) {
      return left(ServerFailure(e.errorMessage));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
