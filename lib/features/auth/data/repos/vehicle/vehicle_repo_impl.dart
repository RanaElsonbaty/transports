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
  Future<Either<Failure, VehicleInfoModel>> addVehicleInfo({
    required String ownerName,
    required String ownerNationalId,
    required String plateNumber,
    required String vehicleModel,
    required String manufacturingYear,
    String? logo,
    String? stamp,
    String? companyPhone,
    String? companyTaxNumber,
    String? companyAddress,
  }) async {
    try {
      final token = await sharedPrefs.getToken();

      /// Build form data dynamically
      final Map<String, dynamic> formDataMap = {
        "owner_name": ownerName,
        "owner_national_id": ownerNationalId,
        "plate_number": plateNumber,
        "vehicle_model": vehicleModel,
        "manufacturing_year": manufacturingYear,
      };

      /// Add optional fields if provided
      if (stamp != null && stamp.isNotEmpty) {
        formDataMap["stamp_photo"] =
        await MultipartFile.fromFile(stamp, filename: "stamp.jpg");
      }

      if (logo != null && logo.isNotEmpty) {
        formDataMap["logo_photo"] =
        await MultipartFile.fromFile(logo, filename: "logo.jpg");
      }

      if (companyPhone != null && companyPhone.isNotEmpty) {
        formDataMap["company_phone"] = companyPhone;
      }

      if (companyTaxNumber != null && companyTaxNumber.isNotEmpty) {
        formDataMap["company_tax_number"] = companyTaxNumber;
      }

      if (companyAddress != null && companyAddress.isNotEmpty) {
        formDataMap["company_address"] = companyAddress;
      }

      /// Convert map to FormData
      final formData = FormData.fromMap(formDataMap);

      /// Make API request
      final response = await apiService.post(
        headers: {"Authorization": "Bearer $token"},
        isFormData: true,
        EndPoints.addVehicleInfo,
        data: formData,
      );

      final result = VehicleInfoModel.fromJson(response);
      return right(result);
    } on Failure catch (e) {
      return left(ServerFailure(e.errorMessage));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
