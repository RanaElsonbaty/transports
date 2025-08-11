import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/core/validator/validator.dart';
import 'package:transports/features/auth/register/presentation/view/attachment_view.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/back_button.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/camera_banner.dart';
import 'package:transports/features/home/presentation/view/widget/start_your_trip.dart';

class DriverInfoScreen extends StatefulWidget {
  const DriverInfoScreen({super.key});

  @override
  State<DriverInfoScreen> createState() => _DriverInfoScreenState();
}

class _DriverInfoScreenState extends State<DriverInfoScreen> {
  final TextEditingController nameController=TextEditingController();
  final TextEditingController nationalIdController=TextEditingController();
  final TextEditingController nationalityController=TextEditingController();
final GlobalKey<FormState>globalKey=GlobalKey();
@override
  void dispose() {
nameController.dispose();
nationalityController.dispose();
nationalIdController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Form(
            key: globalKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackButtonWidget(),
                  const SizedBox(height: 16),
                  CameraBanner(),
                  const SizedBox(height: 30),
                  Text(
                    'بيانات السائق',
                    style: TextStyles.font24MainBlack500Weight,
                  ),
                  const SizedBox(height: 16),
                  buildInput('الاسم',nameController,(value)=>Validators.validateName(value!)),
                  buildInput('رقم الهوية',nationalIdController,(value)=>Validators.validateNationalId(value!)),
                  buildInput('الجنسية',nationalityController,(value)=>Validators.validateNationality(value!)),
                  SizedBox(height: 40.h,),
                  CustomPrimaryButton( text: 'التالي',
                    onPressed: (){
                      if(globalKey.currentState!.validate()){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AttachmentsView(nameController: nameController.text,nationalIdController: nationalIdController.text,)));

                      }
                    },),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInput(String hint,TextEditingController controller,String? Function(String?)? validator) {
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
    );
  }
}
