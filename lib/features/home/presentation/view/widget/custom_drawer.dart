import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            ListTile(
              leading: SvgPicture.asset(AppIcons.language),
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'اللغه ',
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
              onTap: () {},
            ),
            ListTile(
              leading: SvgPicture.asset(AppIcons.note),
              title: Text('الرحلات السابقة', textAlign: TextAlign.right,style: TextStyles.font16DarkGrey400Weight),
              trailing: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios,color: AppColors.arrowColor,size: 16,)),
              onTap: () {},
            ),
            ListTile(
              leading: SvgPicture.asset(AppIcons.closeCircle),
              title: Text('حذف الحساب', textAlign: TextAlign.right,style: TextStyles.font16DarkGrey400Weight),
              trailing: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios,color: AppColors.arrowColor,size: 16,)),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}