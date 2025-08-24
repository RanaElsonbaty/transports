import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:transports/features/home/data/models/extract_image_model.dart';
part 'extract_image_state.dart';

class ExtractImageCubit extends Cubit<ExtractImageState> {
  ExtractImageCubit() : super(ExtractImageInitial());

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://my-bus.storage-te.com/api/",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  Future<void> extractImageData(File imageFile) async {
    emit(ExtractImageLoading());
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path,
            filename: imageFile.path.split('/').last)
      });

      final response = await _dio.post('extract-images', data: formData);

      if (response.statusCode == 200) {
        final model = ExtractImageModel.fromJson(response.data);
        emit(ExtractImageSuccess(model));
      } else {
        emit(ExtractImageFailure("حدث خطأ أثناء الاتصال بالخادم"));
      }
    } catch (e) {
      emit(ExtractImageFailure("فشل في استخراج البيانات: $e"));
    }
  }
}
