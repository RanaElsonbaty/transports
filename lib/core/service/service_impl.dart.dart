import 'dart:async';

import 'package:dio/dio.dart';
import 'package:transports/core/constant/end_point.dart';
import 'package:transports/core/failure/failure.dart';
import 'package:transports/core/service/api_service.dart';

class ApiServiceImpl extends ApiService {
  final Dio _dio;

  ApiServiceImpl(this._dio);

  @override
  Future<dynamic> post(
      String endPoint, {
        dynamic data,
        Map<String, dynamic>? headers,
        bool isFormData = false,
      }) async {
    try {
      print("➡️ POST to: ${EndPoints.baseUrl + endPoint}");
      print("🧾 Data: $data");
      print("🧠 Headers: $headers");

      final response = await _dio
          .post(
        EndPoints.baseUrl + endPoint,
        // data: isFormData ? FormData.fromMap(data) : data,
        options: Options(
          headers: headers,
          receiveTimeout: const Duration(seconds: 15),
          sendTimeout: const Duration(seconds: 15),
        ),
      )
          .timeout(const Duration(seconds: 20)); // حماية إضافية من التجميد

      print("✅ ApiServiceImpl POST response.data: ${response.data}");
      return response.data;
    } on DioException catch (e) {
      // التعامل مع كل أنواع الأخطاء الممكنة
      final message = e.response?.data?['message'] ??
          e.message ??
          "حدث خطأ غير معروف أثناء الاتصال بالسيرفر";
      print("❌ ApiServiceImpl POST DioException: $message");
      throw ServerFailure(message);
    } on TimeoutException {
      print("⏰ ApiServiceImpl POST Timeout Exception");
      throw ServerFailure("انتهى وقت الانتظار، تحقق من الاتصال بالإنترنت");
    } catch (e) {
      print("💥 ApiServiceImpl POST Unknown Exception: $e");
      throw ServerFailure(e.toString());
    }
  }



  @override
  Future<dynamic> get(String endPoint,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.get(
        EndPoints.baseUrl + endPoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure(e.response?.data['message'] ?? "Unknown error");
    }
  }

  @override
  Future<dynamic> put(String endPoint,
      {required Map<String, dynamic> data,
      Map<String, dynamic>? headers,
      bool isFormData = false}) async {
    try {
      final response = await _dio.put(
        EndPoints.baseUrl + endPoint,
        data: isFormData ? FormData.fromMap(data) : data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure(e.response?.data['message'] ?? "Unknown error");
    }
  }

  @override
  Future<dynamic> patch(String endPoint,
      {required Map<String, dynamic> data,
      Map<String, dynamic>? headers,
      bool isFormData = false}) async {
    try {
      final response = await _dio.patch(
        EndPoints.baseUrl + endPoint,
        data: isFormData ? FormData.fromMap(data) : data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure(e.response?.data['message'] ?? "Unknown error");
    }
  }

  @override
  Future<dynamic> delete(String endPoint,
      {Object? data,
      Map<String, dynamic>? headers,
      bool isFormData = false}) async {
    try {
      final response = await _dio.delete(
        EndPoints.baseUrl + endPoint,
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure(e.response?.data['message'] ?? "Unknown error");
    }
  }
}
