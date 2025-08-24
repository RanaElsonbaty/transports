import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transports/core/helper_function/extension.dart';
import 'package:transports/core/helper_function/snack_bar.dart';
import 'package:transports/core/routing/app_routing.dart';
import 'package:transports/core/service/service_locater.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/core/validator/validator.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/back_button.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/camera_banner.dart';
import 'package:transports/features/auth/register/presentation/view_model/cubits/driver_info/driver_info_cubit.dart';
import 'package:transports/features/home/presentation/view/widget/start_your_trip.dart';
import 'dart:ui' as ui;

class AttachmentsView extends StatefulWidget {
  const AttachmentsView({
    super.key,
  });
  @override
  State<AttachmentsView> createState() => _AttachmentsViewState();
}

class _AttachmentsViewState extends State<AttachmentsView> {
  final TextEditingController drivingLicenseNumberController =
      TextEditingController();
  final TextEditingController drivingLicenseExpiryController =
      TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();

  @override
  void dispose() {
    nameController.dispose();
    nationalityController.dispose();
    nationalIdController.dispose();
    drivingLicenseExpiryController.dispose();
    drivingLicenseNumberController.dispose();
    nameController.dispose();
    nationalIdController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<DriverInfoCubit>(),
      child: BlocConsumer<DriverInfoCubit, DriverInfoState>(
        listener: (context, state) {
          if (state is DriverInfoSuccess) {
            showAppSnackBar(
                context: context, message: state.driverInfoModel.message ?? "");
            context.pushNamed(Routes.vehicleInfo);
          } else if (state is DriverInfoFailure) {
            showAppSnackBar(context: context, message: state.errorMessage);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.whiteColor,
            body: Directionality(
textDirection: context.locale.languageCode == 'ar'
    ? ui.TextDirection.rtl
    :ui.TextDirection.ltr,
              child: SingleChildScrollView(
                child: Form(
                  key: globalKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BackButtonWidget(),
                        const SizedBox(height: 16),
                        CameraBanner(title: "إضافة بيانات السائق",),
                        const SizedBox(height: 30),
                         Row(
                           children: [
                            Text(
                              'attachments'.tr(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                                                     ),
                                                     SizedBox(width:10),
                            Text(
                              '(بيانات السائق)',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                                                     ),
                             
                           ],
                         ),
                        const SizedBox(height: 16),
                        buildInput('nameForm'.tr(), nameController,
                            (value) => Validators.validateName(value!)),
                        buildInput('national_id'.tr(), nationalIdController,
                            (value) => Validators.validateNationalId(value!)),
                       
                       
                        buildInput('nationality'.tr(), nationalityController,
                            (value) => Validators.validateNationality(value!)),
                        SizedBox(
                          height: 60.h,
                        ),
                        state is DriverInfoLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : CustomPrimaryButton(
                                text: 'next'.tr(),
                                onPressed: () {
                                  if (globalKey.currentState!.validate()) {
                                    context
                                        .read<DriverInfoCubit>()
                                        .addDriverInfo(
                                            name: nameController.text,
                                            nationalId:
                                                nationalIdController.text,
                                            nationality:
                                                nationalityController.text,
                                            drivingLicenseNumber:
                                                drivingLicenseNumberController
                                                    .text,
                                            drivingLicensExpiry:
                                                drivingLicenseExpiryController
                                                    .text);
                                  }
                                },
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildInput(String hint, TextEditingController controller,
      String? Function(String?)? validator) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyles.font14Black700Weight,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.sp),
                borderSide: BorderSide(color: AppColors.borderColor)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.sp),
                borderSide: BorderSide(color: AppColors.greyColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.sp),
                borderSide: BorderSide(color: AppColors.greyColor))),
      ),
    );
  }
}
