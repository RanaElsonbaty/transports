import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/icons.dart';
import 'package:transports/core/theming/images.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/core/validator/validator.dart';
import 'package:transports/features/home/presentation/view/bus_seat_selection_view.dart';
import 'package:transports/features/home/presentation/view/widget/custom_drawer.dart';
import 'package:transports/features/home/presentation/view/widget/top_widget.dart';
import 'package:transports/features/home/presentation/view/widget/trip_details_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<String> reservedSeats = ["C2", "D4", "E4", "G4"];

  final Set<String> selectedSeats = {};
  bool _showTripDetails = false;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController seatIdController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey();
  void toggleSeat(String seat) {
    if (reservedSeats.contains(seat)) return;

    setState(() {
      if (selectedSeats.contains(seat)) {
        selectedSeats.remove(seat);
      } else {
        selectedSeats.add(seat);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    seatIdController.dispose();
    nameController.dispose();
    nationalIdController.dispose();
    nationalityController.dispose();
  }

  void _openSeatBottomSheet(String seatId) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Form(
          key: globalKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Selected Seat $seatId',
                    style: TextStyles.font16Black700Weight,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    validator: (value) => Validators.validateName(value!),
                    controller: nameController,
                    hint: 'Enter Your Name',
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    keyboardType: TextInputType.phone,
                    validator: (value) =>
                        Validators.validatePhoneNumber(value!),
                    controller: phoneController,
                    hint: 'Enter Your Phone',
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    validator: (value) => Validators.validateSeatId(value!),
                    controller: seatIdController,
                    hint: 'Enter your Seat ID',
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    validator: (value) => Validators.validateNationlId(value!),
                    controller: nationalIdController,
                    hint: 'Enter Your National ID',
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    validator: (value) =>
                        Validators.validateNationality(value!),
                    controller: nationalityController,
                    hint: "Enter Your Nationality",
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (globalKey.currentState!.validate()) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Confirm',
                      style:
                          TextStyle(color: AppColors.whiteColor, fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TopWidget(),
            SizedBox(height: 8.h),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              alignment: Alignment.centerRight,
              child: Row(
                children: [
                  Text(
                    'عدد الركاب الآن:',
                    style: TextStyles.font16Black700Weight,
                    textAlign: TextAlign.right,
                  ),
                  const Spacer(),
                  Text('09', style: TextStyles.font16LightPrimary700Weight),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.seatBlackColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 8),
                Text('محجوز', style: TextStyles.font10SeatBlack500Weight),
                const SizedBox(width: 32),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.primarySeatColor.withOpacity(.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 8),
                Text('متاح', style: TextStyles.font10SeatBlack500Weight),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(AppIcons.busSeat),
                SizedBox(width: 95.w),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var row in [
                  ["A1", "A2", "A3", "A4"],
                  ["B1", "B2", "B3", "B4"],
                  ["C1", "C2", "C3", "C4"],
                  ["D1", "D2", "D3", "D4"],
                  ["E1", "E2", "E3", "E4"],
                  ["F1", "F2", "F3", "F4"],
                  ["G1", "G2", "G3", "G4"],
                ])
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0; i < 2; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: GestureDetector(
                              onTap: () {
                                if (reservedSeats.contains(row[i])) return;
                                toggleSeat(row[i]);
                                if (selectedSeats.contains(row[i])) {
                                  _openSeatBottomSheet(row[i]);
                                }
                              },
                              child: SeatBox(
                                label: row[i],
                                isReserved: reservedSeats.contains(row[i]),
                                isSelected: selectedSeats.contains(row[i]),
                              ),
                            ),
                          ),
                        const SizedBox(width: 40),
                        for (var i = 2; i < 4; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: GestureDetector(
                              onTap: () {
                                if (reservedSeats.contains(row[i])) return;
                                toggleSeat(row[i]);
                                if (selectedSeats.contains(row[i])) {
                                  _openSeatBottomSheet(row[i]);
                                }
                              },
                              child: SeatBox(
                                label: row[i],
                                isReserved: reservedSeats.contains(row[i]),
                                isSelected: selectedSeats.contains(row[i]),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showTripDetails = !_showTripDetails;
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'تفاصيل الرحلة',
                      style: TextStyles.font16Black700Weight,
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(width: 8),
                    AnimatedRotation(
                      turns: _showTripDetails ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: _showTripDetails
                  ? Stack(
                      key: const ValueKey("TripDetails"),
                      children: [
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              AppImages.line,
                              width: double.infinity,
                              height: 800,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        TripDetailsWidget(),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hint,
    this.validator,
    this.keyboardType = TextInputType.text,
  });
  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
            fontSize: 16, color: AppColors.lightBlackColor.withOpacity(.5)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
