import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:transports/core/constant/end_point.dart';
import 'package:transports/core/failure/failure.dart';
import 'package:transports/core/service/api_service.dart';
import 'package:transports/core/storage/shared_prefs.dart';
import 'package:transports/features/auth/data/models/driver_info_model.dart';
import 'package:transports/features/auth/data/repos/driver/driver_info_repo.dart';

class DriverInfoRepoImpl extends DriverInfoRepo {
  ApiService apiService;
  SharedPrefs sharedPrefs;

  DriverInfoRepoImpl(this.apiService, this.sharedPrefs);

  @override
  Future<Either<Failure, DriverInfoModel>> addDriverInfo({
    required String name,
    required String nationalId,
    required String nationality,
    File? avatar,
    File? nationalIdPhoto,
  }) async {
    try {
      final token = await sharedPrefs.getToken();

      final formData = FormData.fromMap({
        "national_id": nationalId,
        "driver_name": name,
        "nationality": nationality,
        if (avatar != null)
          "avatar": await MultipartFile.fromFile(
            avatar.path,
            filename: avatar.path.split('/').last,
          ),
        if (nationalIdPhoto != null)
          "national_id_photo": await MultipartFile.fromFile(
            nationalIdPhoto.path,
            filename: nationalIdPhoto.path.split('/').last,
          ),
      });

      final response = await apiService.post(
        EndPoints.addDriverInfo,
        headers: {"Authorization": "Bearer $token"},
        data: formData,
      );

      final result = DriverInfoModel.fromJson(response);
      return right(result);
    } on Failure catch (e) {
      return left(ServerFailure(e.errorMessage));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
