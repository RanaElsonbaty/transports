import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transports/features/settings/data/model/settings_model.dart';
part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  final Dio _dio = Dio(BaseOptions(baseUrl: "https://my-bus.storage-te.com/api"));

  Future<void> getSettings() async {
    emit(SettingsLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final response = await _dio.get("/settings",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
      if (response.statusCode == 200 && response.data['success'] == true) {
        final settings = SettingsModel.fromJson(response.data
        );
        emit(SettingsSuccess(settings));
      } else {
        emit(SettingsError(response.data['message'] ?? 'حدث خطأ أثناء تحميل الإعدادات'));
      }
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }
}
