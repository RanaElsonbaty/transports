import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/images.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/back_button.dart';
import 'package:transports/features/home/presentation/view_model/profile_cubit/profile_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {

            if (state is ProfileSuccess) {
              final profile=state.profile.data?.user;
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
               BackButtonWidget(),
              SizedBox(width: 80.w),
              Text(
                "profile".tr(),
                style: TextStyles.font20Black700Weight,
              )
            ],
          ),
        ),
      //  CachedNetworkImage(imageUrl:state.profile.data?.user?.avatarUrl??"", height: 85, width: 85,
      // placeholder: (context,url)=>CircularProgressIndicator(),
      //  errorWidget: (context,url,error)=>Icon(Icons.error, color: Colors.red),
      //   ),
      Image.asset(AppImages.avatar,height: 85, width: 85),
        const SizedBox(height: 12),
        _buildListTile(
          title: 'phone'.tr(),
          subtitle: profile?.phone??"No PhoneNummber",
          icon: Icons.phone,
        ),
        const Divider(),
        _buildListTile(
          title: 'email'.tr(),
          subtitle: profile?.email??"No email",
          icon: Icons.email,
        ),
        const Divider(),
        _buildListTile(
          title: 'fullName'.tr(),
          subtitle: profile?.name??"No Name",
          icon: Icons.person,
        ),
        const Divider(),
        _buildListTile(
          title: 'plateNumber'.tr(),
          subtitle: profile?.plateNumber??"",
          icon: Icons.directions_car,
        ),
        const Divider(),
        _buildListTile(
          title: 'year'.tr(),
          subtitle: profile?.manufacturingYear.toString()??"",
          icon: Icons.calendar_today,
        ),
      ],
    ),
  );
}else if(state is ProfileFailure){
  return Center(child: Text(state.errorMessage,style: TextStyle(fontSize: 30,color: AppColors.red),),);

}else{
  return Center(child: CircularProgressIndicator());
}
          },
        ),
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryColor),
      title: Text(
        title,
        style: TextStyles.font14Black400Weight,
      ),
      subtitle: Text(
        subtitle,
        style: TextStyles.font16Black400Weight
            .copyWith(color: AppColors.blackColor.withOpacity(.7)),
      ),
    );
  }
}
