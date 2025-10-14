import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transports/core/helper_function/extension.dart';
import 'package:transports/core/helper_function/snack_bar.dart';
import 'package:transports/core/routing/app_routing.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/icons.dart';
import 'package:transports/features/auth/register/presentation/view/register_view.dart';
import 'package:transports/features/home/presentation/view/widget/custom_dialoge.dart';
import 'package:transports/features/home/presentation/view/widget/language_drop_down.dart';
import 'package:transports/features/home/presentation/view_model/logout_cubit/log_out_cubit.dart';
import 'package:transports/features/home/presentation/view_model/profile_cubit/profile_cubit.dart';
import '../../../../../core/theming/styles.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SafeArea(
          child: BlocConsumer<LogOutCubit, LogOutState>(
            listener: (context, state) {
if(state  is LogOutSuccess){
   showAppSnackBar(context: context, message:state. logOutSuccess) ;
  Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.splash, (route) => false);

}else if(state is LogOutFailure){
    return showAppSnackBar(context: context, message:state.errorMessage) ;

}
            },
            builder: (context, state) {
              return Column(
                children: [
                  LanguageRowSelector(),
                  Builder(
                    builder: (context) {
                      final state = context.watch<ProfileCubit>().state;

                      if (state is ProfileSuccess) {
                        final profile = state.profile.data?.user;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 30),
                          child: Row(
                            children: [
                              Text(
                                profile?.name ?? "",
                                style: TextStyles.font14Black700Weight,
                              ),
                            ],
                          ),
                        );
                      }
                      return Text(
                        "",
                        style: TextStyles.font14Black700Weight,
                      );
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      AppIcons.userCircle,
                      colorFilter: ColorFilter.mode(
                          AppColors.blackColor, BlendMode.srcIn),
                    ),
                    title: Text('profile'.tr(),
                        textAlign: TextAlign.right,
                        style: TextStyles.font16DarkGrey400Weight),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.arrowColor,
                      size: 16,
                    ),
                    onTap: () {
                      context.pushNamed(Routes.myProfile);
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(AppIcons.note),
                    title: Text('previous trips'.tr(),
                        textAlign: TextAlign.right,
                        style: TextStyles.font16DarkGrey400Weight),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.arrowColor,
                      size: 16,
                    ),
                    onTap: () {
                      context.pushNamed(Routes.previousTrip);

                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.payment_outlined),
                    title: Text('payment'.tr(),
                        textAlign: TextAlign.right,
                        style: TextStyles.font16DarkGrey400Weight),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.arrowColor,
                      size: 16,
                    ),
                    onTap: () {

                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.directions_bus),
                    title: Text('add_new_vehicle'.tr(),
                        textAlign: TextAlign.right,
                        style: TextStyles.font16DarkGrey400Weight),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.arrowColor,
                      size: 16,
                    ),
                    onTap: () {
                      context.pushNamed(Routes.vehicleInfo);
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(AppIcons.closeCircle),
                    title: Text('logout'.tr(),
                        textAlign: TextAlign.right,
                        style: TextStyles.font16DarkGrey400Weight),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.arrowColor,
                      size: 16,
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (dialogecontext) => CustomDialog(
                                textButton: "text_button".tr(),
                                title: "title".tr(),
                                content: const SizedBox(),
                                onOkPressed: () {
                                  context.read<LogOutCubit>().logOut();
                                },
                              ));
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/svgs/whatsapp_icon.png',
                      height: 24,
                      width: 24,
                    ),
                    title: Text("support".tr(),
                        textAlign: TextAlign.right,
                        style: TextStyles.font16DarkGrey400Weight),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.arrowColor,
                      size: 16,
                    ),
                    onTap: () {
                      ContactUtils.openWhatsApp('0556742234');
                    },
                  ),
                ],
              );
            },
          ),
        ),
      );

  }
}
