import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/images.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/back_button.dart';
import 'package:transports/features/home/presentation/view/widget/start_your_trip.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController plateNumberController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    plateNumberController.dispose();
    yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    BackButtonWidget(),
                    SizedBox(width: 80.w,),
                    Text("الملف الشخصي",style: TextStyles.font20Black700Weight,)
                  ],
                ),
              ),
              Image.asset(AppImages.person,height: 85,width: 85,),
              const SizedBox(height: 12),
              _buildTextField(
                label: 'الاسم بالكامل',
                hint: 'مثال : احمد مصطفي بودى',
                controller: nameController,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'البريد الالكتروني',
                hint: 'اكتب بريدك الالكتروني',
                controller: emailController,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'رقم الهاتف',
                hint: '01226513003',
                controller: phoneController,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'رقم لوحه السياره',
                hint: '513003',
                controller: plateNumberController,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'سنه الصنع',
                hint: '2022',
                controller: yearController,
              ),
              const SizedBox(height: 30),
              CustomPrimaryButton(text: 'حفظ',onPressed: (){

              },)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyles.font14Black400Weight),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyles.font16Black400Weight.copyWith(color: AppColors.blackColor.withOpacity(.5)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.sp)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                  borderSide: BorderSide(color: AppColors.borderColor)
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                  borderSide: BorderSide(color: AppColors.greyColor)
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                  borderSide: BorderSide(color: AppColors.greyColor)
              )
          ),
        ),
      ],
    );
  }
}
