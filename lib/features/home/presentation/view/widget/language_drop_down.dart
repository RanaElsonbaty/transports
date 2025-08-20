import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:transports/core/service/service_locater.dart';
import 'package:transports/core/storage/shared_prefs.dart';
import 'package:transports/core/theming/styles.dart';

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  Future<void> _loadSelectedLanguage() async {
    final prefs = getIt<SharedPrefs>();
    final savedLang = await prefs.getSelectedLanguage();
    setState(() {
      _selectedLanguage = savedLang ?? context.locale.languageCode;
    });
  }

  Future<void> _changeLanguage(String langCode) async {
    final prefs = getIt<SharedPrefs>();
    await prefs.saveSelectedLanguage(langCode);

    setState(() {
      _selectedLanguage = langCode;
    });

    await context.setLocale(Locale(langCode));
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        icon: const Icon(Icons.language, color: Colors.black, size: 24),
        value: _selectedLanguage,
        items: [
          DropdownMenuItem(
            value: 'ar',
            child: Row(
              children: [
                Text('🇰🇼', style: TextStyle(fontSize: 20)),
                SizedBox(width: 8),
                Text('العربية',style: TextStyles.font14Black400Weight,),
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'en',
            child: Row(
              children: [
                Text('🇺🇸', style: TextStyle(fontSize: 20)),
                SizedBox(width: 8),
                Text('English (UK) ',style: TextStyles.font14Black400Weight,),
              ],
            ),
          ),
        ],
        onChanged: (value) {
          if (value != null) _changeLanguage(value);
        },
      ),
    );
  }
}
