import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:transports/core/routing/app_routing.dart';
import 'package:transports/core/routing/routes.dart';
import 'package:transports/core/service/service_locater.dart';
import 'package:transports/core/storage/shared_prefs.dart';
import 'package:transports/transports_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
                setupServiceLocator();
  await EasyLocalization.ensureInitialized();
  final prefs = getIt.get<SharedPrefs>();
  final String? token = await prefs.getToken();
  final String? savedLang = await prefs.getSelectedLanguage();
  final Locale startLocale = savedLang != null ? Locale(savedLang) : const Locale('ar');

  runApp(
    
      EasyLocalization(

          supportedLocales: const [Locale('ar'), Locale('en')],
          path: 'assets/translations',
          startLocale:startLocale,
          fallbackLocale: const Locale('en'),
          child: TransportsApp(appRoutes: AppRoutes(), initialRoute: (token != null && token.isNotEmpty) ? Routes.home : Routes.splash,
)));

}