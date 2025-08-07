import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:transports/core/helper_function/extension.dart';
import 'package:transports/core/routing/app_routing.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/styles.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  int remainingSeconds = 20;
  late Timer _timer;

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
    _timer.cancel(); // Don't forget to cancel the timer!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality( // RTL for Arabic
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),

              // Title
               Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'ادخل الرمز',
                  style: TextStyles.font30Black700Weight,
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'ادخل الرمز المرسل الي هاتفك المحمول',
                  style: TextStyles.font16Black400Weight,
                ),
              ),

              const SizedBox(height: 40),

              // OTP Field
              OtpTextField(
                numberOfFields: 5,
                borderColor: AppColors.greyColor,
                focusedBorderColor: AppColors.blackColor,
                fieldWidth: 50,
                borderRadius: BorderRadius.circular(8),
                showFieldAsBox: true,
                onSubmit: (code) {
                  print("OTP is => $code");
                },
              ),

              const SizedBox(height: 24),

              // Timer Text
              Text.rich(
                TextSpan(
                  text: 'ارسال الكود مره اخرى خلال ',
                  style: TextStyles.font16Black700Weight,
                  children: [
                    TextSpan(
                      text: '00:${remainingSeconds.toString().padLeft(2, '0')}',
                      style: TextStyles.font16Black400Weight.copyWith(color: AppColors.blackColor.withOpacity(.7)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Confirm Button
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
                    context.pushNamed(Routes.success);
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
                        'تأكيد الرمز',
                        style: TextStyles.font14White700Weight,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
