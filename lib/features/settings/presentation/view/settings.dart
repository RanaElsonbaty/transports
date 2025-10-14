import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/features/auth/register/presentation/view/register_view.dart';
import 'package:transports/features/settings/presentation/view_model/settings_cubit.dart';

class ContactSupportWidget extends StatelessWidget {
  const ContactSupportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SettingsSuccess) {
          final phone = state.settings.data?.contactPhone ?? '';
          return GestureDetector(
            onTap: () => ContactUtils.openWhatsApp(phone),
            child: Row(
              children: [
                Image.asset(
                  'assets/svgs/whatsapp_icon.png',
                  height: 24,
                  width: 24,
                ),
                SizedBox(width: 16.w),
                Text('support'.tr(), style: TextStyles.font16DarkGrey400Weight),
              ],
            ),
          );
        } else if (state is SettingsError) {
          return Text(
            '⚠️ ${state.message}',
            style: TextStyle(color: Colors.red),
          );
        } else {
          // لو أول مرة يعرض
          context.read<SettingsCubit>().getSettings();
          return const SizedBox.shrink();
        }
      },
    );
  }
}
