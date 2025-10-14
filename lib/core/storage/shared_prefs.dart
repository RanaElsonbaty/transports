import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:transports/features/auth/data/models/otp/verify_otp_model.dart';

class SharedPrefs {

  static const String _tokenKey = 'token';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  static const String _langKey = 'language';

  Future<void> saveSelectedLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, langCode);
  }

  Future<String?> getSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_langKey);
  }

  static const String _driverProfileKey = 'driver_profile';

  Future<void> saveDriverProfile(DriverProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(profile.toJson());
    await prefs.setString(_driverProfileKey, jsonString);
  }

  Future<DriverProfile?> getDriverProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_driverProfileKey);
    if (jsonString != null) {
      final Map<String, dynamic> map = jsonDecode(jsonString);
      return DriverProfile.fromJson(map);
    }
    return null;
  }


  Future<void> removeDriverProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_driverProfileKey);
  }
}


