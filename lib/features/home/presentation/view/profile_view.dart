import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transports/core/helper_function/extension.dart';
import 'package:transports/core/routing/app_routing.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/back_button.dart';
import 'package:transports/features/home/presentation/view/widget/language_drop_down.dart';
import 'package:transports/features/home/presentation/view_model/pick_data/extract_image_cubit.dart';
import 'package:transports/features/home/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:transports/features/profile/presentation/view/widget/update_vehicle_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileSuccess) {
            final user = state.profile.data?.user;
            final driver = state.profile.data?.profile;
            final vehicles = state.profile.data?.vehicles ?? [];

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(children: [LanguageRowSelector()]),
                  const SizedBox(height: 10),
                  Align(
                    alignment: context.locale.languageCode == "ar"
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    child: BackButtonWidget(),
                  ),
                  SizedBox(height: 20.w),
                  Center(
                    child: Text("profile".tr(),
                        style: TextStyles.font20Black700Weight),
                  ),
                  const SizedBox(height: 20),

                  /// صورة البروفايل
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 42,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: (user?.avatarUrl != null &&
                              user!.avatarUrl!.isNotEmpty)
                              ? NetworkImage(user.avatarUrl!)
                              : null,
                          child: (user?.avatarUrl == null ||
                              user!.avatarUrl!.isEmpty)
                              ? const Icon(Icons.person,
                              size: 40, color: Colors.grey)
                              : null,
                        ),
                        const SizedBox(height: 12),
                        Text(user?.name ?? "No Name",
                            style: TextStyles.font16Black400Weight),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// بيانات المستخدم الأساسية
                  _buildListTile(
                    title: 'phone'.tr(),
                    subtitle: user?.phone ?? "No PhoneNumber",
                    icon: Icons.phone,
                  ),
                  const Divider(),
                  _buildListTile(
                    title: 'email'.tr(),
                    subtitle: user?.email ?? "No email",
                    icon: Icons.email,
                  ),
                  const Divider(),
                  _buildListTile(
                    title: 'plateNumber'.tr(),
                    subtitle: user?.plateNumber ?? "",
                    icon: Icons.directions_car,
                  ),
                  const Divider(),
                  _buildListTile(
                    title: 'year'.tr(),
                    subtitle: user?.manufacturingYear?.toString() ?? "",
                    icon: Icons.calendar_today,
                  ),

                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Text("driver_info".tr(),
                          style: TextStyles.font20Black700Weight),
                      Spacer(),
                      Text("update".tr(),
                          style: TextStyles.font16Black700Weight),
                      IconButton(
                        onPressed: () async {
                          await context.pushNamed(Routes.updateDriver);
                          context.read<ProfileCubit>().getProfileInfo();
                        },
                        icon: const Icon(Icons.edit),
                      ),

                    ],
                  ),
                  const SizedBox(height: 10),

                  /// بيانات السائق داخل كارد
                  if (driver != null)
                    Card(
                      color: AppColors.whiteColor,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoRow('driver_name'.tr(), driver.driverName),
                            _infoRow('national_id'.tr(), driver.nationalId),
                            _infoRow('nationality'.tr(), driver.nationality),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text("vehicle_info".tr(),
                          style: TextStyles.font20Black700Weight),
                      Spacer(),
                      Text("update".tr(),
                          style: TextStyles.font16Black700Weight),
                      IconButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => ExtractImageCubit(),
                                child: UpdateVehicleView(vehicleId: vehicles.first.id ?? 0),
                              ),
                            ),
                          );
                          context.read<ProfileCubit>().getProfileInfo();
                          log("VEHICLE ID :${vehicles.first.id}");
                        },
                        icon: const Icon(Icons.edit),
                      ),

                    ],
                  ),
                  const SizedBox(height: 10),

                  /// بيانات العربيات داخل Cards
                  ...vehicles.map(
                        (v) => Card(
                      color: AppColors.whiteColor,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoRow("owner_name".tr(), v.ownerName),
                            _infoRow("owner_national_id".tr(), v.ownerNationalId),
                            _infoRow("vehicle_model".tr(), v.vehicleModel),
                            _infoRow("car_plate_number".tr(), v.plateNumber),
                            _infoRow("manufacturing_year".tr(), v.manufacturingYear?.toString()),
                            _infoRow("vehicle_type".tr(), v.vehicleType),
                            _infoRow("capacity".tr(), v.capacity?.toString()),
                            _infoRow("company_number".tr(), v.companyPhone),
                            _infoRow("company_tax_number".tr(), v.companyTaxNumber),
                            _infoRow("company_address".tr(), v.companyAddress),
                            SizedBox(height: 8,),
                            Row(
                              children: [
                                Expanded(child: Column(
                                  children: [
                                    Text("logo",style: TextStyles.font16Black700Weight,),
                                    SizedBox(height: 8,),
                                    CachedNetworkImage(imageUrl: v.logoPhoto!,
                                      placeholder: (context, url) => SizedBox(),
                                      errorWidget: (context, url, error) => SizedBox(),),
                                  ],
                                )),

                                Expanded(child: Column(
                                  children: [
                                   Text("stamp",style: TextStyles.font16Black700Weight,),
                                   SizedBox(height: 8,),
                                   CachedNetworkImage(imageUrl: v.stampPhoto!,
                                   placeholder: (context, url) => SizedBox(),
                                   errorWidget: (context, url, error) => SizedBox(),),
                                  ],
                                )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProfileFailure) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(fontSize: 30, color: AppColors.red),
              ),
            );
          } else {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(children: [LanguageRowSelector()]),
                  const SizedBox(height: 10),
                  Align(
                    alignment: context.locale.languageCode == "ar"
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    child: BackButtonWidget(),
                  ),
                  SizedBox(height: 20.w),
                  Center(
                    child: Text("profile".tr(),
                        style: TextStyles.font20Black700Weight),
                  ),
                  const SizedBox(height: 20),

                  // Profile photo shimmer
                  Center(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Column(
                        children: [
                          CircleAvatar(radius: 42, backgroundColor: Colors.white),
                          const SizedBox(height: 12),
                          Container(height: 16, width: 100, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // User info shimmer
                  ...List.generate(
                    4,
                        (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(height: 14, width: 150, color: Colors.white),
                                  const SizedBox(height: 8),
                                  Container(height: 14, width: 250, color: Colors.white),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Driver info shimmer section
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 20, width: 150, color: Colors.white),
                        const SizedBox(height: 10),
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Vehicle info shimmer section
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 20, width: 150, color: Colors.white),
                        const SizedBox(height: 10),
                        ...List.generate(
                          2,
                              (index) => Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 160,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

        },
      ),
    );
  }

  Widget _infoRow(String title, String? value) {
    if (value == null || value.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: TextStyles.font14Black400Weight
                .copyWith(color: AppColors.primaryColor),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyles.font14Black400Weight,
            ),
          ),
        ],
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
      title: Text(title, style: TextStyles.font14Black400Weight),
      subtitle: Text(
        subtitle,
        style: TextStyles.font16Black400Weight
            .copyWith(color: AppColors.blackColor.withOpacity(.7)),
      ),
    );
  }

}
