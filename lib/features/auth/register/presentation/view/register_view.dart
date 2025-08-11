import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transports/core/helper_function/snack_bar.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/images.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/core/validator/validator.dart';
import 'package:transports/features/auth/register/presentation/view/otp_view.dart';
import 'package:transports/features/auth/register/presentation/view_model/cubits/sending_otp_cubit/sending_otp_cubit.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> globalKey = GlobalKey();
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SendingOtpCubit, SendingOtpState>(
        listener: (context, state) {
 if (state is SendingOtpSuccess) {
            showAppSnackBar(
              backgroundColor: AppColors.primaryDarkGradientColor,
                context: context, message: state.otpModel.data!.otp!);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpView(phoneNumber: phoneController.text,)));
          } else if (state is SendingOtpFailure) {
            showAppSnackBar(context: context, message: state.errorMessage,backgroundColor: AppColors.red);
          }
        },
        builder: (context, state) {
          return Form(
            key: globalKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),

                  // Title
                  Text(
                    'كشف الركاب',
                    style: TextStyles.font35Primary900Weight,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 70),

                  // Login Header
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'تسجيل الدخول',
                      style: TextStyles.font30Black700Weight,
                      textDirection: TextDirection.rtl,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Subtitle
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'ادخل رقم هاتفك لتسجيل الدخول',
                      style: TextStyles.font16Black400Weight,
                      textDirection: TextDirection.rtl,
                    ),
                  ),

                  SizedBox(height: 40.h),
                  Divider(
                    thickness: 1,
                    color: AppColors.greyColor,
                  ),
                  // Country Picker Row
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.flag,
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'السعودية',
                          style: TextStyles.font17Black400Weight,
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 1, color: AppColors.greyColor),
                  // Phone Number Field
                  Row(
                    children: [
                      // Country Code
                      Text(
                        '966+',
                        style: TextStyles.font17Black400Weight,
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        height: 26.w,
                        width: 1,
                        color: AppColors.greyColor,
                      ),
                      SizedBox(width: 16.w),
                      // Phone Input
                      Expanded(
                        child: TextFormField(
                          controller:   phoneController,
                          validator: (value) =>
                              Validators.validatePhoneNumber(value!),
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: '0 00 00 00 00',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets
                                .zero, // Optional: reduce default padding
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(thickness: 1, color: AppColors.greyColor),
                  const SizedBox(height: 60),
                  state is SendingOtpLoading?Center(child: CircularProgressIndicator(),):

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ).copyWith(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          return null; // Use decoration
                        }),
                      ),
                      onPressed: () {
                        if (globalKey.currentState!.validate()) {
 context.read<SendingOtpCubit>().sendOtp(phoneNumber: phoneController.text, );
                        }
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.primaryLightGradientColor,
                              AppColors.primaryDarkGradientColor
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'تسجيل الدخول',
                            style: TextStyles.font14White700Weight,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
