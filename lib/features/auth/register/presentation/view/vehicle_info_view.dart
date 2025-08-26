import 'dart:io';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transports/core/helper_function/extension.dart';
import 'package:transports/core/helper_function/snack_bar.dart';
import 'package:transports/core/routing/app_routing.dart';
import 'package:transports/core/service/service_locater.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/core/validator/validator.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/back_button.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/camera_banner.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/upload_image.dart';
import 'package:transports/features/auth/register/presentation/view_model/cubits/vehicle_info/vehicle_info_cubit.dart';
import 'package:transports/features/home/presentation/view/widget/start_your_trip.dart';
import 'package:transports/features/home/presentation/view_model/pick_data/extract_image_cubit.dart';
import 'package:transports/features/home/data/models/extract_image_model.dart';

class VehicleInfoView extends StatefulWidget {
  const VehicleInfoView({super.key});

  @override
  State<VehicleInfoView> createState() => _VehicleInfoViewState();
}

class _VehicleInfoViewState extends State<VehicleInfoView> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController ownerIdController = TextEditingController();
  final TextEditingController plateNumberController = TextEditingController();
  final TextEditingController vehicleModelControler = TextEditingController();
  final TextEditingController manufacturingYearController =
  TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? extractionImage;
  File? stampImage;
  File? boardImage;
  bool isLoadingImage = false;

  @override
  void dispose() {
    ownerNameController.dispose();
    ownerIdController.dispose();
    plateNumberController.dispose();
    vehicleModelControler.dispose();
    manufacturingYearController.dispose();
    super.dispose();
  }

  Future<void> _pickAndExtract(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    setState(() => isLoadingImage = true);
    extractionImage = File(pickedFile.path);

    context.read<ExtractImageCubit>().extractImageData(extractionImage!);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt.get<VehicleInfoCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
          // استماع لحالات VehicleInfo
          BlocListener<VehicleInfoCubit, VehicleInfoState>(
            listener: (context, state) {
              if (state is VehicleInfoSuccess) {
                showAppSnackBar(
                  backgroundColor: AppColors.primaryDarkGradientColor,
                  context: context,
                  message: state.vehicleInfoModel.message ?? "No Message",
                );
                context.pushNamed(Routes.success);
              } else if (state is VehicleInfoFailure) {
                showAppSnackBar(
                  context: context,
                  message: state.errorMessage,
                  backgroundColor: AppColors.red,
                );
              }
            },
          ),
          // استماع لحالات استخراج البيانات
          BlocListener<ExtractImageCubit, ExtractImageState>(
            listener: (context, state) {
              setState(() => isLoadingImage = state is ExtractImageLoading);

              if (state is ExtractImageSuccess) {
                final ExtractedData? data = state.model.data?.extractedData;
                if (data != null) {
                  setState(() {
                    ownerNameController.text = data.ownerName ?? '';
                    ownerIdController.text = data.nationalId ?? '';
                    plateNumberController.text = data.plateNumber ?? '';
                    vehicleModelControler.text = data.vehicleModel ?? '';
                    manufacturingYearController.text =
                        data.manufacturingYear ?? '';
                  });
                }

                showAppSnackBar(
                  context: context,
                  message: state.model.message ?? "تم استخراج البيانات بنجاح",
                );
              } else if (state is ExtractImageFailure) {
                showAppSnackBar(
                  context: context,
                  message: state.message,
                );
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: Directionality(
            textDirection: context.locale.languageCode == 'ar'
                ? ui.TextDirection.rtl
                : ui.TextDirection.ltr,
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
                      CameraBanner(
                        title: "إضافة بيانات السيارة",
                        onTap: () => _pickAndExtract(context),
                      ),
                      if (extractionImage != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              extractionImage!,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      else if (isLoadingImage)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      const SizedBox(height: 30),
                      Text(
                        'vehicle_info'.tr(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      buildInput('owner_name'.tr(), ownerNameController,
                              (value) => Validators.validateName(value!)),
                      buildInput('owner_national_id'.tr(), ownerIdController,
                              (value) => Validators.validateNationalId(value!)),
                      buildInput('car_plate_number'.tr(), plateNumberController,
                              (value) => Validators.validatePlateNumber(value!)),
                      buildInput('vehicle_model'.tr(), vehicleModelControler,
                              (value) => Validators.validateVehicleModel(value!)),
                      buildInput(
                          'manufacturing_year'.tr(),
                          manufacturingYearController,
                              (value) =>
                              Validators.validateManufacturingYear(value!)),
                      UploadPhotosView(
                        onImagesSelected: (File? stamp, File? logo) {
                          setState(() {
                            stampImage = stamp;
                            boardImage = logo;
                          });
                        },
                      ),
                      SizedBox(height: 20.h),
                      BlocBuilder<VehicleInfoCubit, VehicleInfoState>(
                        builder: (context, state) {
                          return state is VehicleInfoLoading
                              ? const Center(child: CircularProgressIndicator())
                              : CustomPrimaryButton(
                            text: 'confirm'.tr(),
                            onPressed: () {
                              if (globalKey.currentState!.validate()) {
                                if (boardImage == null ||
                                    stampImage == null) {
                                  showAppSnackBar(
                                    context: context,
                                    message:
                                    "upload_stamp_and_plate".tr(),
                                    backgroundColor: AppColors.red,
                                  );
                                  return;
                                }
                                context.read<VehicleInfoCubit>().addVehicleInfo(
                                    ownerName: ownerNameController.text,
                                    ownerNationalId:
                                    ownerIdController.text,
                                    plateNumber:
                                    plateNumberController.text,
                                    vehicleModel:
                                    vehicleModelControler.text,
                                    manufacturingYear:
                                    manufacturingYearController.text,
                                    logo: boardImage!.path,
                                    stamp: stampImage!.path);
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInput(String hint, TextEditingController controller,
      String? Function(String?)? validator) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: validator,
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
            borderSide: BorderSide(color: AppColors.borderColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: BorderSide(color: AppColors.greyColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.sp),
            borderSide: BorderSide(color: AppColors.greyColor),
          ),
        ),
      ),
    );
  }
}
