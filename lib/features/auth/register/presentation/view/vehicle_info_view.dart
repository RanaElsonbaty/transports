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
import 'package:transports/features/auth/register/presentation/view/register_view.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/back_button.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/camera_banner.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/upload_image.dart';
import 'package:transports/features/auth/register/presentation/view_model/cubits/vehicle_info/vehicle_info_cubit.dart';
import 'package:transports/features/home/presentation/view/widget/language_drop_down.dart';
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
  final TextEditingController vehicleModelController = TextEditingController();
  final TextEditingController companyPhoneController = TextEditingController();
  final TextEditingController companyTaxNumberController = TextEditingController();
  final TextEditingController companyAddressController = TextEditingController();
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
    vehicleModelController.dispose();
    manufacturingYearController.dispose();
    super.dispose();
  }

  Future<void> _pickAndExtract(BuildContext context) async {
    final ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text('camera'.tr()),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text('gallery'.tr()),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );

    if (source == null) return;

    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile == null) return;

      setState(() => isLoadingImage = true);
      extractionImage = File(pickedFile.path);

      context.read<ExtractImageCubit>().extractImageData(extractionImage!);
    } catch (e) {
      debugPrint("Image selection error: $e");
      showAppSnackBar(
        context: context,
        message: "تعذر الوصول إلى ${source == ImageSource.camera ? "الكاميرا" : "المعرض"}",
        backgroundColor: AppColors.red,
      );
    }
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
                    vehicleModelController.text = data.vehicleModel ?? '';
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
                      horizontal: 12, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          LanguageRowSelector()
                        ],
                      ),
                      const SizedBox(height: 16),
                      BackButtonWidget(),
                      const SizedBox(height: 16),
                      CameraBanner(
                        title: "add_vehicle_data".tr(),
                        onTap: () => _pickAndExtract(context),
                      ),

                      if (isLoadingImage &&
                          ownerNameController.text.isEmpty &&
                          ownerIdController.text.isEmpty &&
                          plateNumberController.text.isEmpty &&
                          vehicleModelController.text.isEmpty &&
                          manufacturingYearController.text.isEmpty)
                         Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                              SizedBox(width: 12),
                              Text(
                                "extract_data_from_image".tr(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        )
                      else if (extractionImage != null)
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
                      buildInput('vehicle_model'.tr(), vehicleModelController,
                              (value) => Validators.validateVehicleModel(value!)),
                      buildInput(
                          'manufacturing_year'.tr(),
                          manufacturingYearController,
                              (value) =>
                              Validators.validateManufacturingYear(value!)),
                      Text(
                        'attachments_if_any'.tr(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20.h),
                      UploadPhotosView(
                        onImagesSelected: (File? stamp, File? logo) {
                          setState(() {
                            stampImage = stamp;
                            boardImage = logo;
                          });
                        },
                      ),
                      SizedBox(height: 20.h),
                      buildInput('company_number'.tr(), companyPhoneController,null),
                      buildInput('company_tax_number'.tr(), companyTaxNumberController,null),
                      buildInput('company_address'.tr(), companyAddressController,null),
                      SizedBox(height: 20.h),
                      BlocBuilder<VehicleInfoCubit, VehicleInfoState>(
                        builder: (context, state) {
                          return state is VehicleInfoLoading
                              ? const Center(child: CircularProgressIndicator())
                              : CustomPrimaryButton(
                            text: 'confirm'.tr(),
                            onPressed: () {
                              if (globalKey.currentState!.validate()) {
                                // if (boardImage == null ||
                                //     stampImage == null) {
                                //   showAppSnackBar(
                                //     context: context,
                                //     message:
                                //     "upload_stamp_and_plate".tr(),
                                //     backgroundColor: AppColors.red,
                                //   );
                                //   return;
                                // }
                                context.read<VehicleInfoCubit>().addVehicleInfo(
                                  ownerName: ownerNameController.text,
                                  ownerNationalId: ownerIdController.text,
                                  plateNumber: plateNumberController.text,
                                  vehicleModel: vehicleModelController.text,
                                  manufacturingYear: manufacturingYearController.text,
                                  logo: boardImage?.path, // optional
                                  stamp: stampImage?.path, // optional
                                  companyPhone: companyPhoneController.text.isNotEmpty
                                      ? companyPhoneController.text
                                      : null,
                                  companyTaxNumber: companyTaxNumberController.text.isNotEmpty
                                      ? companyTaxNumberController.text
                                      : null,
                                  companyAddress: companyAddressController.text.isNotEmpty
                                      ? companyAddressController.text
                                      : null,
                                );

                              }
                            },
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: () {
                          ContactUtils.openWhatsApp('0556742234');
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/svgs/whatsapp_icon.png',
                              height: 36,
                              width: 36,
                            ),
                            SizedBox(width: 5.w,),
                            Text('Support'.tr(),style:TextStyles.font16Black700Weight,)
                          ],
                        ),
                      )
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
