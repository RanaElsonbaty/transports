import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:transports/features/home/data/models/extract_image_model.dart';
import 'package:transports/core/storage/shared_prefs.dart';
part 'extract_image_state.dart';

class ExtractImageCubit extends Cubit<ExtractImageState> {
  ExtractImageCubit() : super(ExtractImageInitial());

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://my-bus.storage-te.com/api/",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
    ),
  );

  Future<void> extractImageData(File imageFile) async {
    emit(ExtractImageLoading());

    try {
      final token = await SharedPrefs().getToken();
      log("Token: $token");

      if (token == null || token.isEmpty) {
        emit(ExtractImageFailure(
            "التوكن غير موجود. يرجى تسجيل الدخول مرة أخرى."));
        return;
      }

      // ✅ حساب حجم الصورة
      final sizeInBytes = await imageFile.length();
      final sizeInKB = sizeInBytes / 1024;
      final sizeInMB = sizeInKB / 1024;
      log("📷 Image Size: ${sizeInBytes} bytes | ${sizeInKB.toStringAsFixed(2)} KB | ${sizeInMB.toStringAsFixed(2)} MB");

      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.uri.pathSegments.last,
        ),
      });

      final response = await _dio.post(
        'extract-images',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      log("Status Code: ${response.statusCode}");
      log("Response Data: ${response.data}");

      if (response.statusCode == 200 && response.data['success'] == true) {
        final model = ExtractImageModel.fromJson(response.data);
        emit(ExtractImageSuccess(model));
      } else if (response.statusCode == 401) {
        emit(ExtractImageFailure(
            "انتهت صلاحية التوكن. يرجى تسجيل الدخول مجددًا."));
      } else if (response.statusCode == 422) {
        emit(ExtractImageFailure(response.data['message']));
      } else {
        emit(ExtractImageFailure("خطأ بالخادم: ${response.statusCode}"));
      }
    } on DioException catch (dioError, s) {
      log("Dio Error: ${dioError.response?.data}\n$dioError\n$s");
      emit(ExtractImageFailure(
          "فشل الاتصال بالسيرفر: ${dioError.response?.data ?? dioError.message}"));
    } catch (e, s) {
      log("Unexpected Error: $e\n$s");
      emit(ExtractImageFailure("حدث خطأ غير متوقع: $e"));
    }
  }
}
