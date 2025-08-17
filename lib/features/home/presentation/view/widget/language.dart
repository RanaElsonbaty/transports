
import 'package:easy_localization/easy_localization.dart';
imort 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transports/core/helper_function/extension.dart';
import 'package:transports/core/locale_keys.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/styles.dart';

class ChangeLanguageView extends StatefulWidget {
  const ChangeLanguageView({super.key});

  @override
  State<ChangeLanguageView> createState() => _ChangeLanguageViewState();
}

class _ChangeLanguageViewState extends State<ChangeLanguageView> {
  String selectedLanguage = 'ar'; 

  void _changeLanguage(String langCode) {
    setState(() {
      selectedLanguage = langCode;
    });
    context.setLocale(Locale(langCode));
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
                    right: 0,
                    child: GestureDetector(
                      onTap: (){
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
                        child: BackButton()
                        
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
                name: 'العربيه',
                flag: '🇰🇼',
              ),
              SizedBox(height: 10.h),
              _buildLanguageOption(
                langCode: 'en',
                name: 'English (UK)',
                flag: '🇺🇸',
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