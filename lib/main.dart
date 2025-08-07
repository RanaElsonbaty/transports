import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:transports/core/routing/routes.dart';
import 'package:transports/transports_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(
          supportedLocales: const [Locale('ar'), Locale('en')],
          path: 'assets/translations',
          startLocale: const Locale('ar'),
          fallbackLocale: const Locale('ar'),
          child: TransportsApp(appRoutes: AppRoutes())));
}