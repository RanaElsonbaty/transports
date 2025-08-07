import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transports/core/routing/app_routing.dart';
import 'package:transports/core/routing/routes.dart';

class TransportsApp extends StatefulWidget {
  final AppRoutes appRoutes;
  const TransportsApp({super.key, required this.appRoutes});
  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  State<TransportsApp> createState() => _TransportsAppState();
}

class _TransportsAppState extends State<TransportsApp> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        navigatorKey: TransportsApp.navKey,
        title: "Transports",
        theme: ThemeData(
           // fontFamily: AppFonts.neoSansArabic
        ),
        onGenerateRoute: widget.appRoutes.generateRoute,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splash,
      ),
    );
  }
}
