// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:transports/core/helper_function/extension.dart';
// import 'package:transports/core/locale_keys.dart';
// import 'package:transports/core/service/service_locater.dart';
// import 'package:transports/core/storage/shared_prefs.dart';
// import 'package:transports/core/theming/colors.dart';
// import 'package:transports/core/theming/styles.dart';
// import 'package:transports/features/auth/register/presentation/view/widgets/back_button.dart';

// class ChangeLanguageView extends StatefulWidget {
//   const ChangeLanguageView({super.key});

//   @override
//   State<ChangeLanguageView> createState() => _ChangeLanguageViewState();
// }

// class _ChangeLanguageViewState extends State<ChangeLanguageView> {
//   String? selectedLanguage;

//   @override
//   void initState() {
//     super.initState();
//     _loadSelectedLanguage();
//   }

//   Future<void> _loadSelectedLanguage() async {
//     final prefs = getIt<SharedPrefs>();
//     final savedLang = await prefs.getSelectedLanguage();
//     setState(() {
//       selectedLanguage = savedLang ?? context.locale.languageCode;
//     });
//   }

//   Future<void> _changeLanguage(String langCode) async {
//     final prefs = getIt<SharedPrefs>();
//     await prefs.saveSelectedLanguage(langCode);

//     setState(() {
//       selectedLanguage = langCode;
//     });

//     await context.setLocale(Locale(langCode));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Center(
//                     child: Text(
//                       context.tr(LocaleKeys.language),
//                       style: TextStyles.font20Black700Weight,
//                     ),
//                   ),
//                   Positioned(
//   right: context.locale.languageCode == 'ar' ? 0 : null,
//   left: context.locale.languageCode != 'ar' ? 0 : null,                    child: GestureDetector(
//                       onTap: () {
//                         context.pop();
//                       },
//                       child: Container(
//                         width: 24,
//                         height: 24,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black12,
//                               blurRadius: 3,
//                               offset: Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: BackButtonWidget(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 30.h),
//               Text(
//                 context.tr(LocaleKeys.changeLanguage),
//                 style: TextStyles.font18MainBlack500Weight,
//               ),
//               SizedBox(height: 20.h),
//               _buildLanguageOption(
//                 langCode: 'ar',
//                 name: 'العربية',
//                 flag: '🇰🇼',
//               ),
//               SizedBox(height: 10.h),
//               _buildLanguageOption(
//                 langCode: 'en',
//                 name: 'English (UK)',
//                 flag: '🇺🇸',
//               ),
//                SizedBox(height: 10.h),
//               _buildLanguageOption(
//                 langCode: 'ar_JO',
//                 name: 'الاردنية',
//                 flag: '🇯🇴',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLanguageOption({
//     required String langCode,
//     required String name,
//     required String flag,
//   }) {
//     return InkWell(
//       onTap: () => _changeLanguage(langCode),
//       child: Row(
//         children: [
//           Radio<String>(
//             fillColor: WidgetStatePropertyAll(AppColors.primaryColor),
//             value: langCode,
//             groupValue: selectedLanguage,
//             onChanged: (value) {
//               if (value != null) _changeLanguage(value);
//             },
//             activeColor: Colors.blue,
//           ),
//           Spacer(),
//           Text(name, style: TextStyles.font14Black400Weight),
//           SizedBox(width: 8.w),
//           Text(flag, style: TextStyle(fontSize: 20.sp)),
//         ],
//       ),
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transports/core/helper_function/extension.dart';
import 'package:transports/core/locale_keys.dart';
import 'package:transports/core/service/service_locater.dart';
import 'package:transports/core/storage/shared_prefs.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/back_button.dart';

class ChangeLanguageView extends StatefulWidget {
  const ChangeLanguageView({super.key});

  @override
  State<ChangeLanguageView> createState() => _ChangeLanguageViewState();
}

class _ChangeLanguageViewState extends State<ChangeLanguageView> {
  String? selectedLanguage;

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  Future<void> _loadSelectedLanguage() async {
    final prefs = getIt<SharedPrefs>();
    final savedLang = await prefs.getSelectedLanguage();

    String normalizedLang;
    if (savedLang == 'ar_JO') {
      normalizedLang = 'ar-JO';
    } else if (savedLang == 'en_US') {
      normalizedLang = 'en';
    } else {
      normalizedLang = savedLang ?? context.locale.languageCode;
    }

    setState(() {
      selectedLanguage = normalizedLang;
    });

    print("🔵 SavedLang: $savedLang");
    print("🔵 Normalized: $selectedLanguage");
    print("🔵 Current locale: ${context.locale}");
  }

  Future<void> _changeLanguage(String langCode) async {
    final prefs = getIt<SharedPrefs>();
    await prefs.saveSelectedLanguage(langCode);

    setState(() {
      selectedLanguage = langCode;
    });

    if (langCode == 'ar-JO') {
      await context.setLocale(const Locale('ar', 'JO'));
    } else {
      await context.setLocale(Locale(langCode));
    }

    print("🟢 Changed to: $langCode");
    print("🟢 Current locale after set: ${context.locale}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Text(
                      context.tr(LocaleKeys.language),
                      style: TextStyles.font20Black700Weight,
                    ),
                  ),
                  
                  Positioned(
                    left: context.locale.languageCode == 'ar' ? 0 : null,
                    right :context.locale.languageCode != 'ar' ? 0 : null,
                    child: GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 3,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Transform(
                            alignment: Alignment.center,
  transform: Matrix4.rotationY(
    context.locale.languageCode == 'en' ? 3.1416 : 0),
                          child: BackButtonWidget()),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Text(
                context.tr(LocaleKeys.changeLanguage),
                style: TextStyles.font18MainBlack500Weight,
              ),
              SizedBox(height: 20.h),
              _buildLanguageOption(
                langCode: 'ar',
                name: 'العربية',
                flag: '🇸🇦',
              ),
              SizedBox(height: 10.h),
              _buildLanguageOption(
                langCode: 'en',
                name: 'English (UK)',
                flag: '🇺🇸',
              ),
              SizedBox(height: 10.h),
              _buildLanguageOption(
                langCode: 'ar-JO',
                name: 'اُردُو',
                flag: '🇵🇰',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required String langCode,
    required String name,
    required String flag,
  }) {
    return InkWell(
      onTap: () => _changeLanguage(langCode),
      child: Row(
        children: [
          Radio<String>(
            fillColor: WidgetStatePropertyAll(AppColors.primaryColor),
            value: langCode,
            groupValue: selectedLanguage,
            onChanged: (value) {
              if (value != null) _changeLanguage(value);
            },
            activeColor: Colors.blue,
          ),
          Spacer(),
          Text(name, style: TextStyles.font14Black400Weight),
          SizedBox(width: 8.w),
          Text(flag, style: TextStyle(fontSize: 20.sp)),
        ],
      ),
    );
  }
}
