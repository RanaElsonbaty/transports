import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:transports/core/helper_function/extension.dart';
import 'package:transports/core/helper_function/snack_bar.dart';
import 'package:transports/core/routing/app_routing.dart';
import 'package:transports/core/service/service_locater.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/features/auth/register/presentation/view_model/cubits/resend_otp/resend_otp_cubit.dart';
import 'package:transports/features/auth/register/presentation/view_model/cubits/verify_otp/verifying_otp_cubit.dart';
import 'dart:ui' as ui;

import 'package:transports/features/home/presentation/view/widget/language_drop_down.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  int remainingSeconds = 120;
  late Timer _timer;
  String otpCode = '';

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          remainingSeconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
textDirection: context.locale.languageCode == 'ar'
    ? ui.TextDirection.rtl
    :ui.TextDirection.ltr,
        child: BlocProvider(
          create: (context) => getIt.get<VerifyingOtpCubit>(),
          child: BlocConsumer<VerifyingOtpCubit, VerifyingOtpState>(
            listener: (context, state) {
              if (state is VerifyingOtpSuccess) {
                showAppSnackBar(
                    backgroundColor: AppColors.primaryDarkGradientColor,
                    context: context,
                    message: state.verifyingOtpModel.message ?? "no message");
                context.pushNamed(Routes.attachmentInfo);
              } else if (state is VerifyingOtpFailure) {
                showAppSnackBar(
                    context: context,
                    message: state.errorMessage,
                    backgroundColor: AppColors.red);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        LanguageRowSelector()
                      ],
                    ),
                    const SizedBox(height: 100),

                    // Title
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'enter_code'.tr(),
                        style: TextStyles.font30Black700Weight,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Subtitle
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'enter_code_subtitle'.tr(),
                        style: TextStyles.font16Black400Weight,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // OTP Field
                    Directionality(
                textDirection: ui.TextDirection.ltr,
                      child: OtpTextField(
                        numberOfFields: 6,
                        borderColor: AppColors.greyColor,
                        focusedBorderColor: AppColors.blackColor,
                        fieldWidth: 45,

                        borderRadius: BorderRadius.circular(8),
                        showFieldAsBox: true,
                        onSubmit: (code) {
                          setState(() {
                            otpCode = code;
                          });
                          print("OTP is => $code");
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Timer Text
                    CustomResendOtpTextButton(
                        remainingSeconds: remainingSeconds, phoneNumber: widget.phoneNumber,),

                    const SizedBox(height: 40),

state is VerifyingOtpLoading?Center(child: CircularProgressIndicator(),):
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () {
                          context.read<VerifyingOtpCubit>().verifyingOtp(
                              phoneNumber: widget.phoneNumber,
                              otpCode: otpCode);
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.primaryLightGradientColor,
                                AppColors.primaryDarkGradientColor
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'confirm_code'.tr(),
                              style: TextStyles.font14White700Weight,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CustomResendOtpTextButton extends StatelessWidget {
  const CustomResendOtpTextButton({
    super.key,
    required this.remainingSeconds, required this.phoneNumber,
  });

  final int remainingSeconds;
final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<ResendOtpCubit>(),
      child: BlocConsumer<ResendOtpCubit, ResendOtpState>(
        listener: (context, state) {
          if(state is ResendOtpSuccess){
            showAppSnackBar(context: context, message: state.resendOtpModel.message??"",backgroundColor: AppColors.primaryColor);

          }else if(state is ResendOtpFailure){
                    showAppSnackBar(context: context, message: state.errorMessage,backgroundColor: AppColors.red);

          }
        },
        builder: (context, state) {
          return InkWell(
            onTap: () {
            context.read<ResendOtpCubit>().resendOtp(phoneNumber: phoneNumber);

            },
            child: Text.rich(
              TextSpan(
  text: "resend_otp".tr() ,
style: TextStyles.font16Black700Weight,
                children: [
                  TextSpan(
                    text:
                        ' ${(remainingSeconds ~/ 60).toString().padLeft(2, '0')}:${(remainingSeconds % 60).toString().padLeft(2, '0')}',
                    style: TextStyles.font16Black400Weight
                        .copyWith(color: AppColors.blackColor.withOpacity(.7)),
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
