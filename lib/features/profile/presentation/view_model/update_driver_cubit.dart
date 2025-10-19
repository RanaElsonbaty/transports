import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transports/features/profile/data/model/update_driver_model.dart';
import 'update_driver_state.dart';

class UpdateDriverCubit extends Cubit<UpdateDriverState> {
  UpdateDriverCubit() : super(UpdateDriverInitial());

  final Dio _dio = Dio(BaseOptions(baseUrl: "https://my-bus.storage-te.com/api"));

  Future<void> updateDriverProfile({
    required String driverName,
    required String nationalId,
    required String nationality,
    File? nationalIdPhoto,
    File? avatar,
  }) async {
    emit(UpdateDriverLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      final formData = FormData.fromMap({
        "driver_name": driverName,
        "national_id": nationalId,
        "nationality": nationality,
        if (nationalIdPhoto != null)
          "national_id_photo": await MultipartFile.fromFile(nationalIdPhoto.path),
        if (avatar != null)
          "avatar": await MultipartFile.fromFile(avatar.path),
      });

      final response = await _dio.post(
        "/driver/update-profile",
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
      log("RESPONSE OF UPDATE DRIVER PROFILE: ${response.data}");
      final model = UpdateDriverModel.fromJson(response.data);
      emit(UpdateDriverSuccess(model));
    } on DioException catch (e) {
      String errorMsg = "حدث خطأ أثناء تحديث البيانات";
      if (e.response != null && e.response?.data != null) {
        errorMsg = e.response?.data["message"] ?? errorMsg;
        log("error message: $errorMsg");
      }
      emit(UpdateDriverFailure(errorMsg));
    } catch (e) {
      log("error message: $e");
      emit(UpdateDriverFailure("Unexpected error: $e"));
    }
  }
}
