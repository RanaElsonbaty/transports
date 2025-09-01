// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:transports/core/service/service_locater.dart';
// import 'package:transports/core/storage/shared_prefs.dart';
// import 'package:transports/core/theming/styles.dart';
//
// class LanguageDropdown extends StatefulWidget {
//   const LanguageDropdown({super.key});
//
//   @override
//   State<LanguageDropdown> createState() => _LanguageDropdownState();
// }
//
// class _LanguageDropdownState extends State<LanguageDropdown> {
//   String? _selectedLanguage;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadSelectedLanguage();
//   }
//
// //   Future<void> _loadSelectedLanguage() async {
// //     final prefs = getIt<SharedPrefs>();
// //     final savedLang = await prefs.getSelectedLanguage();
// //     print("SavedLang: $savedLang");
// // print("Current locale: ${context.locale}");
// // print("Supported: ${context.supportedLocales}");
//
// //     setState(() {
// // _selectedLanguage = savedLang ?? context.locale.toString();
// //     });
// //   }
//
// //   Future<void> _changeLanguage(String langCode) async {
// //     final prefs = getIt<SharedPrefs>();
// //     await prefs.saveSelectedLanguage(langCode);
//
// //     setState(() {
// //       _selectedLanguage = langCode;
// //     });
// //   if (langCode == 'ar-JO') {
// //     await context.setLocale(const Locale('ar', 'JO'));
// //   } else {
// //     await context.setLocale(Locale(langCode));
// //   }
// //   }
// Future<void> _loadSelectedLanguage() async {
//   final prefs = getIt<SharedPrefs>();
//   final savedLang = await prefs.getSelectedLanguage();
//
//   // Convert to dropdown values
//   String normalizedLang;
//   if (savedLang == 'ar_JO') {
//     normalizedLang = 'ar-JO';
//   } else if (savedLang == 'en_US') {
//     normalizedLang = 'en';
//   } else {
//     normalizedLang = savedLang ?? context.locale.languageCode;
//   }
//
//   setState(() {
//     _selectedLanguage = normalizedLang;
//   });
//
//   print("🔵 SavedLang: $savedLang");
//   print("🔵 Normalized: $_selectedLanguage");
//   print("🔵 Current locale: ${context.locale}");
// }
//
// Future<void> _changeLanguage(String langCode) async {
//   final prefs = getIt<SharedPrefs>();
//   await prefs.saveSelectedLanguage(langCode);
//
//   setState(() {
//     _selectedLanguage = langCode;
//   });
//
//   if (langCode == 'ar-JO') {
//     await context.setLocale(const Locale('ar', 'JO'));
//   } else {
//     await context.setLocale(Locale(langCode));
//   }
//
//   print("🟢 Changed to: $langCode");
//   print("🟢 Current locale after set: ${context.locale}");
// }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton<String>(
//         icon: const Icon(Icons.language, color: Colors.black, size: 24),
//         value: _selectedLanguage,
//         items: [
//           DropdownMenuItem(
//             value: 'ar',
//             child: Row(
//               children: [
//                 Text('🇸🇦', style: TextStyle(fontSize: 20)),
//                 SizedBox(width: 8),
//                 Text('العربية',style: TextStyles.font14Black400Weight,),
//               ],
//             ),
//           ),
//            DropdownMenuItem(
//             value: 'ar-JO',
//             child: Row(
//               children: [
//                 Text('🇵🇰', style: TextStyle(fontSize: 20)),
//                 SizedBox(width: 8),
//                 Text('اُردُو',style: TextStyles.font14Black400Weight,),
//               ],
//             ),
//           ),
//           DropdownMenuItem(
//             value: 'en',
//             child: Row(
//               children: [
//                 Text('🇺🇸', style: TextStyle(fontSize: 20)),
//                 SizedBox(width: 8),
//                 Text('English (UK) ',style: TextStyles.font14Black400Weight,),
//               ],
//             ),
//           ),
//         ],
//         onChanged: (value) {
//           if (value != null) _changeLanguage(value);
//         },
//       ),
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:transports/core/service/service_locater.dart';
import 'package:transports/core/storage/shared_prefs.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/styles.dart';

class LanguageRowSelector extends StatefulWidget {
  const LanguageRowSelector({super.key});

  @override
  State<LanguageRowSelector> createState() => _LanguageRowSelectorState();
}

class _LanguageRowSelectorState extends State<LanguageRowSelector> {
  String? _selectedLanguage;

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
      _selectedLanguage = normalizedLang;
    });
  }

  Future<void> _changeLanguage(String langCode) async {
    final prefs = getIt<SharedPrefs>();
    await prefs.saveSelectedLanguage(langCode);

    setState(() {
      _selectedLanguage = langCode;
    });

    if (langCode == 'ar-JO') {
      await context.setLocale(const Locale('ar', 'JO'));
    } else {
      await context.setLocale(Locale(langCode));
    }
  }

  Widget _buildLanguageItem(String langCode, String flag, String name) {
    return GestureDetector(
      onTap: () => _changeLanguage(langCode),
      child: Row(
        children: [
          Checkbox(
            value: _selectedLanguage == langCode,
            onChanged: (_) => _changeLanguage(langCode),
            activeColor: AppColors.primaryColor,
          ),
          Text(flag, style: const TextStyle(fontSize: 16)),
          Text(name, style: TextStyles.font14Black400Weight),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          _buildLanguageItem('ar', '🇸🇦', 'العربية'),
          const SizedBox(width: 2),
          _buildLanguageItem('ar-JO', '🇵🇰', 'اُردُو'),
          const SizedBox(width: 2),
          _buildLanguageItem('en', '🇺🇸', 'English'),
        ],
      ),
    );
  }
}
