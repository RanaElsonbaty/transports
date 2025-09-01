import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:transports/core/routing/app_routing.dart';
import 'package:transports/core/routing/routes.dart';
import 'package:transports/core/service/service_locater.dart';
import 'package:transports/core/storage/shared_prefs.dart';
import 'package:transports/transports_app.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  WebViewPlatform.instance = AndroidWebViewPlatform();

  await EasyLocalization.ensureInitialized();
  final prefs = getIt.get<SharedPrefs>();
  final String? token = await prefs.getToken();
  runApp(
    
      EasyLocalization(

          supportedLocales: const [Locale('ar'), Locale('en'),    Locale('ar', 'JO'), ],
          path: 'assets/translations',
          // startLocale: const Locale('ar'),
          fallbackLocale: const Locale('en'),

          child: TransportsApp(appRoutes: AppRoutes(), initialRoute:Routes.splash
          // (token != null && token.isNotEmpty) ? Routes.home : Routes.splash,
)));

}
