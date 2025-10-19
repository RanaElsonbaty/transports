import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transports/features/profile/data/model/update_vehicle_model.dart';
import 'update_vehicle_state.dart';

class UpdateVehicleCubit extends Cubit<UpdateVehicleState> {
  UpdateVehicleCubit() : super(UpdateVehicleInitial());

  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://my-bus.storage-te.com/api'));

  Future<void> updateVehicle({
    required int vehicleId,
    required String ownerName,
    required String ownerNationalId,
    required String plateNumber,
    required String vehicleModel,
    required int capacity,
    required String manufacturingYear,
    File? logo,
    File? stamp,
    String? companyPhone,
    String? companyTaxNumber,
    String? companyAddress,
    File? drivingLicensePhoto,
  }) async {
    emit(UpdateVehicleLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final formData = FormData.fromMap({
        "owner_name": ownerName,
        "owner_national_id": ownerNationalId,
        "plate_number": plateNumber,
        "vehicle_model": vehicleModel,
        "manufacturing_year": manufacturingYear,
        "capacity": capacity,
        if (logo != null)
          "logo_photo": await MultipartFile.fromFile(logo.path, filename: logo.path.split('/').last),
        if (stamp != null)
          "stamp_photo": await MultipartFile.fromFile(stamp.path, filename: stamp.path.split('/').last),
        if (drivingLicensePhoto != null)
          "driving_license_photo": await MultipartFile.fromFile(drivingLicensePhoto.path,
              filename: drivingLicensePhoto.path.split('/').last),
        if (companyPhone != null) "company_phone": companyPhone,
        if (companyTaxNumber != null) "company_tax_number": companyTaxNumber,
        if (companyAddress != null) "company_address": companyAddress,
      });
      log("🚀 Sending updateVehicle data: ${formData.fields}");

      final response = await _dio.post(
        '/driver/update-vehicles/$vehicleId',
        data: formData,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );
    log("UPDATE VEHICLE :${response.data}");
      if (response.statusCode == 200) {
        final model = UpdateVehicleModel.fromJson(response.data);
        emit(UpdateVehicleSuccess(model));
      } else {
        emit(UpdateVehicleFailure('Unexpected server response.'));
      }
    } on DioException catch (e) {
      String message = 'Network error';
      if (e.response != null) {
        message = e.response?.data['message'] ?? 'Request failed';
      }
      emit(UpdateVehicleFailure(message));
    } catch (e) {
      emit(UpdateVehicleFailure(e.toString()));
    }
  }
}
