import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          SizedBox(width: 4,),
          SizedBox(
            height: 12,
            width: 12,
            child: Checkbox(
              value: _selectedLanguage == langCode,
              onChanged: (_) => _changeLanguage(langCode),
              activeColor: AppColors.primaryColor,
            ),
          ),
          SizedBox(width: 8,),
          Text(flag, style: TextStyle(fontSize: 13.sp)),
          SizedBox(width: 4,),
          Text(name, style: TextStyles.font14Black400Weight),
          SizedBox(width: 8,),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildLanguageItem('ar', '🇸🇦', 'العربية'),
        _buildLanguageItem('ar-JO', '🇵🇰', 'اُردُو'),
        _buildLanguageItem('en', '🇺🇸', 'English'),
      ],
    );
  }
}
