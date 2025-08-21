import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transports/core/routing/routes.dart';
import 'dart:ui' as ui;

class TransportsApp extends StatefulWidget {
  final AppRoutes appRoutes;
  final String initialRoute;
  const TransportsApp({super.key, required this.appRoutes, required this.initialRoute});
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

  //   return ScreenUtilInit(
  //     designSize: const Size(375, 812),
  //     minTextAdapt: true,
  //     child: MaterialApp(
  //       localizationsDelegates: context.localizationDelegates,
  //       supportedLocales: context.supportedLocales,
  //       locale: context.locale,
  //       navigatorKey: TransportsApp.navKey,
  //       title: "Transports",
  //       theme: ThemeData(
  //          // fontFamily: AppFonts.neoSansArabic
  //       ),
        
  //       onGenerateRoute: widget.appRoutes.generateRoute,
  //       debugShowCheckedModeBanner: false,
  //       initialRoute: Routes.splash,
  //     ),
  //   );
  // }
  return ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    builder: (context, child) {
      return MaterialApp(
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
        initialRoute:  widget.initialRoute,
        builder: (context, child) {
          return Directionality(
            textDirection: context.locale.languageCode == 'ar'
                ? ui.TextDirection.rtl
                : ui.TextDirection.ltr,
            child: child!,
          );
        },
      );
    },
  );
  }
}
