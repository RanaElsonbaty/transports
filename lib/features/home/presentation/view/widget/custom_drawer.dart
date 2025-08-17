import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transports/core/helper_function/extension.dart';
import 'package:transports/core/routing/app_routing.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/icons.dart';

import '../../../../../core/theming/styles.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 200.h,),
//             IconButton(
//   icon: const Icon(Icons.language),
//   onPressed: () {
//     if (context.locale.languageCode == 'ar') {
//       context.setLocale(const Locale('en'));
//     } else {
//       context.setLocale(const Locale('ar'));
//     }
//   },
// ),

            ListTile(
              leading: SvgPicture.asset(
                AppIcons.userCircle,
                colorFilter: ColorFilter.mode(AppColors.blackColor, BlendMode.srcIn),
              ),
                title: Text('profile'.tr(), textAlign: TextAlign.right,style: TextStyles.font16DarkGrey400Weight),
              trailing: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios,color: AppColors.arrowColor,size: 16,)),
              onTap: () {
                context.pushNamed(Routes.myProfile);
              },
            ),
            ListTile(
              leading: SvgPicture.asset(AppIcons.language),
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'language'.tr(),
                      style: TextStyles.font16DarkGrey400Weight,
                    ),
                    TextSpan(
                      text: '(العربية)',
                      style: TextStyles.font12DarkGrey400Weight,
                    ),
                  ],
                ),
                textAlign: TextAlign.right,
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_forward_ios, color: AppColors.arrowColor, size: 16),
              ),
              onTap: () {context.pushNamed(Routes.changeLanguage);},
            ),
            ListTile(
              leading: SvgPicture.asset(AppIcons.note),
              title: Text('previous trips'.tr(), textAlign: TextAlign.right,style: TextStyles.font16DarkGrey400Weight),
              trailing: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios,color: AppColors.arrowColor,size: 16,)),
              onTap: () {},
            ),
            ListTile(
              leading: SvgPicture.asset(AppIcons.closeCircle),
              title: Text('deleteAccount'.tr(), textAlign: TextAlign.right,style: TextStyles.font16DarkGrey400Weight),
              trailing: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios,color: AppColors.arrowColor,size: 16,)),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}