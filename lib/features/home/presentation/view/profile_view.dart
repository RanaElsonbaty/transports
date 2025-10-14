import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/back_button.dart';
import 'package:transports/features/home/presentation/view/widget/language_drop_down.dart';
import 'package:transports/features/home/presentation/view_model/profile_cubit/profile_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {

          if (state is ProfileSuccess) {
            final profile = state.profile.data?.user;
            final vehicles = state.profile.data?.vehicles ?? [];

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      LanguageRowSelector()
                    ],
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: context.locale.languageCode == "ar"
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    child: BackButtonWidget(),
                  ),
                  SizedBox(height: 20.w),
                  Center(child: Text("profile".tr(), style: TextStyles.font20Black700Weight)),
                  const SizedBox(height: 20),

                  // صورة البروفايل
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 42, // نصف الـ height/width (85/2)
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: (profile?.avatarUrl != null && profile!.avatarUrl!.isNotEmpty)
                              ? NetworkImage(profile.avatarUrl!)
                              : null,
                          child: (profile?.avatarUrl == null || profile!.avatarUrl!.isEmpty)
                              ? const Icon(Icons.person, size: 40, color: Colors.grey)
                              : null,
                        ),
                        const SizedBox(height: 12),
                        Text(profile?.name ?? "No Name",
                            style: TextStyles.font16Black400Weight),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // بيانات المستخدم
                  _buildListTile(
                    title: 'phone'.tr(),
                    subtitle: profile?.phone ?? "No PhoneNumber",
                    icon: Icons.phone,
                  ),
                  const Divider(),
                  _buildListTile(
                    title: 'email'.tr(),
                    subtitle: profile?.email ?? "No email",
                    icon: Icons.email,
                  ),
                  const Divider(),
                  _buildListTile(
                    title: 'plateNumber'.tr(),
                    subtitle: profile?.plateNumber ?? "",
                    icon: Icons.directions_car,
                  ),
                  const Divider(),
                  _buildListTile(
                    title: 'year'.tr(),
                    subtitle: profile?.manufacturingYear?.toString() ?? "",
                    icon: Icons.calendar_today,
                  ),

                  const SizedBox(height: 30),
                  Text("vehicle_info".tr(),
                      style: TextStyles.font20Black700Weight),
                  const SizedBox(height: 10),

                  // بيانات العربيات
                  ...vehicles.map((v) => Card(
                    color: AppColors.whiteColor,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.directions_car,
                          color: AppColors.primaryColor),
                      title: Text(v.vehicleModel ?? "Unknown Model",
                          style: TextStyles.font16Black400Weight),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${'plateNumber'.tr()}: ${v.plateNumber ?? ''}"),
                          Text("${'year'.tr()}: ${v.manufacturingYear ?? ''}"),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            );
          }

          else if(state is ProfileFailure){
      return Center(child: Text(state.errorMessage,style: TextStyle(fontSize: 30,color: AppColors.red),),);

    }else{
      return _shimmerVehicleCard();
    }
        },
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
  Widget _shimmerListTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(height: 40, width: 40, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 14, width: 120, color: Colors.white),
                const SizedBox(height: 8),
                Container(height: 14, width: 200, color: Colors.white),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _shimmerVehicleCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(height: 40, width: 40, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 14, width: 120, color: Colors.white),
                const SizedBox(height: 8),
                Container(height: 14, width: 160, color: Colors.white),
              ],
            ),
          )
        ],
      ),
    );
  }
}
