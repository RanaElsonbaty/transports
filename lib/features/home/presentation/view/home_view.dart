import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transports/core/service/service_locater.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/images.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/core/validator/validator.dart';
import 'package:transports/features/home/data/models/seats_model.dart';
import 'package:transports/features/home/presentation/view/bus_seat_selection_view.dart';
import 'package:transports/features/home/presentation/view/widget/custom_drawer.dart';
import 'package:transports/features/home/presentation/view/widget/top_widget.dart';
import 'package:transports/features/home/presentation/view/widget/trip_details_widget.dart';
import 'package:transports/features/home/presentation/view_model/city_cubit/city_cubit.dart';
import 'package:transports/features/home/presentation/view_model/seats_cubit/seats_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<String> reservedSeats = ["C2", "D4", "E4", "G4"];
  bool miniBusSelected = false;
  bool isBigBusSelected = false;
  bool showDetails = false;
  void toggleDetails() {
    setState(() {
      showDetails = !showDetails;
    });
  }

  void _onBusCardTapped(bool isBigBus) {
    setState(() {
      miniBusSelected = !isBigBus;
      isBigBusSelected = isBigBus;
    });

    final busType = isBigBus ? "bus" : "minibus";
    context.read<SeatsCubit>().getSeats(busType);
  }

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
    final bool isBusSelected = miniBusSelected || isBigBusSelected;

    return BlocProvider(
      create: (context) => getIt.get<CityCubit>()..fetchCities(),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TopWidget(
                onMiniBusTap: () => _onBusCardTapped(false),
                onBigBusTap: () => _onBusCardTapped(true),
              ),
              SizedBox(height: 20.h),
              if (!isBusSelected)
                Container(
                  height: 300,
                )
              else
                BlocBuilder<SeatsCubit, SeatsState>(
                  builder: (context, state) {
                    if (state is SeatsLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is SeatsFailure) {
                      return Center(child: Text(state.errorMessage));
                    } else if (state is SeatsSuccess) {
                      final seats = state.seatsSuccess;

                      final maxRow = seats
                          .map((e) => e.rowNumber!)
                          .reduce((a, b) => a > b ? a : b);
                      final maxCol = seats
                          .map((e) => e.columnNumber!)
                          .reduce((a, b) => a > b ? a : b);

                      List<List<Seats?>> seatMatrix = List.generate(
                          maxRow, (_) => List.filled(maxCol, null));

                      for (var seat in seats) {
                        seatMatrix[seat.rowNumber! - 1]
                            [seat.columnNumber! - 1] = seat;
                      }

                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, 0.05),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: seatMatrix.map((row) {
                                final leftSeats =
                                    row.take(maxCol ~/ 2).toList();
                                final rightSeats =
                                    row.skip(maxCol ~/ 2).toList();

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: (maxCol ~/ 2) * 60.0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: leftSeats.map((seat) {
                                            if (seat == null) {
                                              return SizedBox(
                                                  width: 40, height: 40);
                                            }
                                            bool isReserved =
                                                seat.status != "available";
                                            return GestureDetector(
                                              onTap: () {
                                                if (isReserved) return;
                                                toggleSeat(
                                                    seat.seatNumber.toString());
                                                if (selectedSeats.contains(seat
                                                    .seatNumber
                                                    .toString())) {
                                                  _openSeatBottomSheet(seat
                                                      .seatNumber
                                                      .toString());
                                                }
                                              },
                                              child: SeatBox(
                                                label:
                                                    seat.seatNumber.toString(),
                                                isReserved: isReserved,
                                                isSelected: selectedSeats
                                                    .contains(seat.seatNumber
                                                        .toString()),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      SizedBox(width: 20.w),
                                      SizedBox(
                                        width: (maxCol ~/ 2) * 60.0,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: rightSeats.map((seat) {
                                            if (seat == null)
                                              return const SizedBox(
                                                  width: 40, height: 40);
                                            bool isReserved =
                                                seat.status != "available";
                                            return GestureDetector(
                                              onTap: () {
                                                if (isReserved) return;
                                                toggleSeat(
                                                    seat.seatNumber.toString());
                                                if (selectedSeats.contains(seat
                                                    .seatNumber
                                                    .toString())) {
                                                  _openSeatBottomSheet(seat
                                                      .seatNumber
                                                      .toString());
                                                }
                                              },
                                              child: SeatBox(
                                                label:
                                                    seat.seatNumber.toString(),
                                                isReserved: isReserved,
                                                isSelected: selectedSeats
                                                    .contains(seat.seatNumber
                                                        .toString()),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20.w, top: 20.h),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: toggleDetails,
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
                                        turns: showDetails ? 0.5 : 0.0,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: const Icon(
                                            Icons.keyboard_arrow_down),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 400),
                              child: showDetails
                                  ? Stack(
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
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
            ],
          ),
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
