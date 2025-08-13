import 'package:flutter/material.dart';
import 'package:transports/core/theming/images.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/back_button.dart';
import 'package:transports/features/home/presentation/view/widget/start_your_trip.dart';
import 'package:transports/features/profile/presentation/view/widget/custom_text-field.dart';

class MyProfileView extends StatelessWidget {
  const MyProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButtonWidget(),
                  Text(
                    "الملف الشخصي",
                    style: TextStyles.font20Black700Weight,
                  ),
                  const SizedBox(width: 40), // spacing for symmetry
                ],
              ),
              const SizedBox(height: 30),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Image.asset(
                    AppImages.avatar,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: "الاسم بالكامل",
                hint: "مثال: احمد مصطفى بودي",
              ),
              const SizedBox(height: 15),
              CustomTextField(
                label: "البريد الإلكتروني",
                hint: "اكتب بريدك الالكتروني",
              ),
              const SizedBox(height: 15),
              CustomTextField(
                label: "رقم الهاتف",
                hint: "01226513003",
              ),
              const SizedBox(height: 15),
              CustomTextField(
                label: "رقم لوحة السيارة",
                hint: "513003",
              ),
              const SizedBox(height: 15),
              CustomTextField(
                label: "سنة الصنع",
                hint: "2022",
              ),
              const SizedBox(height: 30),
              CustomPrimaryButton(text: "حفظ")
            ],
          ),
        ),
      ),
    );
  }
}
