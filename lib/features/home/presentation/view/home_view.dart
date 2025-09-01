import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transports/core/helper_function/snack_bar.dart';
import 'package:transports/core/service/service_locater.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/icons.dart';
import 'package:transports/core/theming/images.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/core/validator/validator.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/camera_banner.dart';
import 'package:transports/features/home/data/models/seats_model.dart';
import 'package:transports/features/home/presentation/view/bus_seat_selection_view.dart';
import 'package:transports/features/home/presentation/view/widget/custom_drawer.dart';
import 'package:transports/features/home/presentation/view/widget/empty_widgets.dart';
import 'package:transports/features/home/presentation/view/widget/top_widget.dart';
import 'package:transports/features/home/presentation/view/widget/trip_details_widget.dart';
import 'package:transports/features/home/presentation/view_model/create_trip/creating_trip_cubit.dart';
import 'package:transports/features/home/presentation/view_model/pick_data/extract_image_cubit.dart';
import 'package:transports/features/home/presentation/view_model/seats_cubit/seats_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<String> reservedSeats = ["C2", "D4", "E4", "G4"];
  bool miniBusSelected = false;
  List<Map<String, String>> currentMiniBusPassengers = [];
List<Map<String, String>> currentBigBusPassengers = [];

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

  // final Set<String> selectedSeats = {};
  List<String> selectedBusSeats = [];
  List<String> selectedMiniBusSeats = [];
  bool _showTripDetails = false;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController seatIdController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey();
  List<Map<String, dynamic>> miniBusPassengersData = [];
  List<Map<String, dynamic>> bigBusPassengersData = [];

  void toggleSeat(String seat, {required bool isMiniBus}) {
    if (reservedSeats.contains(seat)) return;
    setState(() {
      if (isMiniBus) {
        if (selectedMiniBusSeats.contains(seat)) {
          selectedMiniBusSeats.remove(seat);
        } else {
          selectedMiniBusSeats.add(seat);
        }
      } else {
        if (selectedBusSeats.contains(seat)) {
          selectedBusSeats.remove(seat);
        } else {
          selectedBusSeats.add(seat);
        }
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
//   void _openSeatBottomSheet(String seatNumber, String seatId,String tripId) {
//   final existingPassengerIndex =
//       passengersData.indexWhere((p) => p['seat_number'] == seatNumber);

//   if (existingPassengerIndex != -1) {
//     final existingData = passengersData[existingPassengerIndex];
//     nameController.text = existingData['name'];
//     phoneController.text = existingData['phone'];
//     seatIdController.text = existingData['seat_number'];
//     nationalIdController.text = existingData['national_id'];
//     nationalityController.text = existingData['nationality'];
//   } else {
//     nameController.clear();
//     phoneController.clear();
//     seatIdController.text = seatNumber;
//     nationalIdController.clear();
//     nationalityController.clear();
//   }

//   showModalBottomSheet(
//     context: context,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     isScrollControlled: true,
//     builder: (context) {
//       return Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//           left: 20,
//           right: 20,
//           top: 20,
//         ),
//         child: SingleChildScrollView(
//           child: Form(
//             key: globalKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text('Selected Seat $seatNumber'),
//                 const SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: nameController,
//                   hint: 'Enter Name',
//                   validator: (value) => Validators.validateName(value!),
//                 ),
//                 const SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: phoneController,
//                   hint: 'Enter Phone',
//                   keyboardType: TextInputType.phone,
//                   validator: (value) => Validators.validatePhoneNumber(value!),
//                 ),
//                 const SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: seatIdController,
//                   hint: 'Seat Number',
//                   enabled: false,
//                   validator: (value) => Validators.validateSeatId(value!),
//                 ),
//                 const SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: nationalIdController,
//                   hint: 'National ID',
//                   validator: (value) => Validators.validateNationalId(value),
//                 ),
//                 const SizedBox(height: 16),
//                 CustomTextFormField(
//                   controller: nationalityController,
//                   hint: 'Nationality',
//                   validator: (value) => Validators.validateNationality(value!),
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: AppColors.whiteColor,
//                     minimumSize: const Size(double.infinity, 40),
//                     backgroundColor: AppColors.primaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onPressed: () {
//                     if (globalKey.currentState!.validate()) {
//                       final passenger = {
//                         "name": nameController.text,
//                         "phone": phoneController.text,
//                         "seat_number": seatIdController.text,
//                         "national_id": nationalIdController.text,
//                         "nationality": nationalityController.text,
//                       };

//                       if (existingPassengerIndex != -1) {
//                         passengersData[existingPassengerIndex] = passenger;
//                       } else {
//                         passengersData.add(passenger);
//                       }

//                       // استدعاء API الحجز
//                       context
//                           .read<ReserveSeatCubit>()
//                           .reserveSeats(tripId, seatId);

//                       // استماع لنجاح الحجز
//                       context.read<ReserveSeatCubit>().stream.listen((state) {
//                         if (state is ReserveSeatSucces) {
//                           setState(() {
//                             // تحديث حالة المقعد في الواجهة
//                             final seatObj = context.read<SeatsCubit>().state is SeatsSuccess
//                                 ? (context.read<SeatsCubit>().state as ReserveSeatSucces).reservingData.firstWhere((s) => s.seatId == seatId, orElse: () => null)
//                                 : null;
//                             if (seatObj != null) {
//                               seatObj.status = "reserved";
//                             }
//                           });
//                         }
//                       });

//                       Navigator.pop(context);
//                     }
//                   },
//                   child: const Text('Confirm'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
  Set<String> occupiedMiniBusSeats = {};
  Set<String> occupiedBigBusSeats = {};

  bool isOccupied(String seatNumber, {required bool isMiniBus}) {
    return reservedSeats.contains(seatNumber) ||
        (isMiniBus
            ? occupiedMiniBusSeats.contains(seatNumber)
            : occupiedBigBusSeats.contains(seatNumber));
  }

  Color seatColor(bool isMiniBus, String seatNumber, String status) {
    if (isMiniBus) {
      if (occupiedMiniBusSeats.contains(seatNumber))
        return Colors.black; 
      if (selectedMiniBusSeats.contains(seatNumber))
        return AppColors.primarySeatColor; 
    } else {
      if (occupiedBigBusSeats.contains(seatNumber)) return Colors.black;
      if (selectedBusSeats.contains(seatNumber))
        return AppColors.primarySeatColor;
    }

    if (status != "available") return AppColors.primarySeatColor;

    return AppColors.primarySeatColor.withOpacity(0.1);
  }

  void _openSeatBottomSheet(String seatNumber) {
    final currentPassengersData =
    miniBusSelected ? miniBusPassengersData : bigBusPassengersData;

    // Check if seat already has passenger data
    final existingPassengerIndex =
    currentPassengersData.indexWhere((p) => p['seat_number'] == seatNumber);

    if (existingPassengerIndex != -1) {
      final existingData = currentPassengersData[existingPassengerIndex];
      nameController.text = existingData['name'];
      seatIdController.text = existingData['seat_number'];
      nationalIdController.text = existingData['national_id'];
      nationalityController.text = existingData['nationality'];
    } else {
      nameController.clear();
      seatIdController.text = seatNumber;
      nationalIdController.clear();
      nationalityController.clear();
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (ctx) {
        return BlocProvider.value(
          value: context.read<ExtractImageCubit>(),
          child: MultiBlocListener(
            listeners: [
              BlocListener<ExtractImageCubit, ExtractImageState>(
                listener: (context, state) {
                  if (state is ExtractImageLoading) {
                    showAppSnackBar(
                      context: context,
                      message: "جارٍ استخراج البيانات...",
                    );
                  } else if (state is ExtractImageSuccess) {
                    final extracted = state.model.data?.extractedData;
                    if (extracted != null) {
                      setState(() {
                        nameController.text = extracted.fullNameAr ?? '';
                        nationalIdController.text = extracted.nationalId ?? '';
                        nationalityController.text = extracted.nationalityAr ?? '';
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
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: globalKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Upload ID Image
                      CameraBanner(
                        isPassengerText: true,
                        title: "رفع صورة لاستخراج البيانات",
                        onTap: () async {
                          final ImageSource? source = await showModalBottomSheet<ImageSource>(
                            context: context,
                            builder: (context) {
                              return SafeArea(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.camera_alt),
                                      title: const Text('التقاط صورة بالكاميرا'),
                                      onTap: () => Navigator.pop(context, ImageSource.camera),
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.photo_library),
                                      title: const Text('اختيار صورة من المعرض'),
                                      onTap: () => Navigator.pop(context, ImageSource.gallery),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );

                          // لو المستخدم أغلق الـ BottomSheet بدون اختيار أي شيء
                          if (source == null) return;

                          try {
                            final pickedFile = await ImagePicker().pickImage(source: source);
                            if (pickedFile != null) {
                              final selectedImage = File(pickedFile.path);
                              context.read<ExtractImageCubit>().extractImageData(selectedImage);
                            }
                          } catch (e) {
                            debugPrint("Image selection error: $e");
                            showAppSnackBar(
                              context: context,
                              message: "تعذر الوصول إلى ${source == ImageSource.camera ? "الكاميرا" : "المعرض"}",
                              backgroundColor: AppColors.red,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      /// Name Field
                      CustomTextFormField(
                        controller: nameController,
                        hint: 'fullName'.tr(),
                        validator: (value) => Validators.validateName(value!),
                      ),
                      const SizedBox(height: 16),

                      /// Seat ID Field
                      CustomTextFormField(
                        controller: seatIdController,
                        hint: 'Seat ID',
                        enabled: false,
                        validator: (value) => Validators.validateSeatId(value!),
                      ),
                      const SizedBox(height: 16),

                      /// National ID Field
                      CustomTextFormField(
                        controller: nationalIdController,
                        hint: 'national_id'.tr(),
                        validator: (value) => Validators.validateNationalId(value),
                      ),
                      const SizedBox(height: 16),

                      /// Nationality Field
                      CustomTextFormField(
                        controller: nationalityController,
                        hint: 'nationality'.tr(),
                        validator: (value) =>
                            Validators.validateNationality(value!),
                      ),
                      const SizedBox(height: 16),

                      /// Confirm Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.whiteColor,
                          minimumSize: const Size(double.infinity, 40),
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (globalKey.currentState!.validate()) {
                            final passenger = {
                              "name": nameController.text,
                              "seat_number": seatIdController.text,
                              "national_id": nationalIdController.text,
                              "nationality": nationalityController.text,
                            };

                            // Update or Add passenger to the correct bus data
                            if (existingPassengerIndex != -1) {
                              currentPassengersData[existingPassengerIndex] =
                                  passenger;
                            } else {
                              currentPassengersData.add(passenger);
                              if (miniBusSelected) {
                                currentMiniBusPassengers.add(passenger);
                                occupiedMiniBusSeats.add(seatIdController.text);
                              } else {
                                currentBigBusPassengers.add(passenger);
                                occupiedBigBusSeats.add(seatIdController.text);
                              }
                            }

                            setState(() {});
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Confirm'),
                      ),
                    ],
                  ),
                ),
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

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt.get<CreatingTripCubit>(),
        ),
        BlocProvider(
          create: (context) => ExtractImageCubit(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        drawer:  CustomDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<SeatsCubit, SeatsState>(
                builder: (context, state) {
                  String miniMax = "12";
                  String bigMax = "50";

                  if (state is SeatsSuccess) {
                    final seatsData = state.seatsSuccess;
                    miniMax = (seatsData.length <= 13 ? seatsData.length : "12")
                        .toString();
                    bigMax = (seatsData.length > 13 ? seatsData.length : "50")
                        .toString();
                  }

                  return TopWidget(
                    onMiniBusTap: () => _onBusCardTapped(false),
                    onBigBusTap: () => _onBusCardTapped(true),
                    miniBusMaxPassengers: miniMax,
                    bigBusMaxPassengers: bigMax,
                  );
                },
              ),
              //               SizedBox(height: 20.h),

              // Container( margin: EdgeInsets.symmetric(horizontal: 20.w), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14), decoration: BoxDecoration( color: AppColors.whiteColor, borderRadius: BorderRadius.circular(8), boxShadow: [ BoxShadow( color: Colors.black.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 3), ), ], ), alignment: Alignment.centerRight, child: Row( children: [ Text( 'عدد الركاب الآن:', style: TextStyles.font16Black700Weight, textAlign: TextAlign.right, ), const Spacer(), Text('09', style: TextStyles.font16LightPrimary700Weight), ], ), ),
              // SizedBox(height: 20.h),
              // Row( mainAxisAlignment: MainAxisAlignment.center, children: [ Container( width: 20, height: 20, decoration: BoxDecoration( color: AppColors.seatBlackColor, borderRadius: BorderRadius.circular(4), ), ), const SizedBox(width: 8),
              //  Text('محجوز',style: TextStyles.font10SeatBlack500Weight,),
              //   const SizedBox(width: 32),
              //    Container( width: 20, height: 20, decoration: BoxDecoration( color: AppColors.primarySeatColor.withOpacity(.1), borderRadius: BorderRadius.circular(4), ), ), const SizedBox(width: 8), Text('متاح',style: TextStyles.font10SeatBlack500Weight), ], ), const SizedBox(height: 40), Row( mainAxisAlignment: MainAxisAlignment.end, children: [ SvgPicture.asset(AppIcons.busSeat), 
              //    SizedBox(width: 95.w,), ], ),
              if (!isBusSelected)
               EmptyWidget()
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
                            
                            SizedBox(height: 20.h),

              Container( margin: EdgeInsets.symmetric(horizontal: 20.w), 
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14), 
              decoration: BoxDecoration( color: AppColors.whiteColor,
               borderRadius: BorderRadius.circular(8), 
               boxShadow: [ BoxShadow( color: Colors.black.withOpacity(0.1),
                blurRadius: 6, offset: const Offset(0, 3), ), ], ), 
                alignment: Alignment.centerRight,
                 child: Row( children: [ Text( 'current_passengers'.tr(), style: TextStyles.font16Black700Weight, textAlign: TextAlign.right, ), const Spacer(), 
                 Text( miniBusSelected
      ? currentMiniBusPassengers.length.toString()
      : currentBigBusPassengers.length.toString(), style: TextStyles.font16LightPrimary700Weight), ], ), ),
              SizedBox(height: 20.h),
              Row( mainAxisAlignment: MainAxisAlignment.center, children: [ Container( width: 20, height: 20, decoration: BoxDecoration( color: AppColors.seatBlackColor, borderRadius: BorderRadius.circular(4), ), ), const SizedBox(width: 8),
               Text('reserved'.tr(),style: TextStyles.font10SeatBlack500Weight,),
                const SizedBox(width: 32),
                 Container( width: 20, height: 20, decoration: BoxDecoration( color: AppColors.primarySeatColor.withOpacity(.1), borderRadius: BorderRadius.circular(4), ), ), const SizedBox(width: 8),
                  Text('available'.tr(),style: TextStyles.font10SeatBlack500Weight), ], ), 
                 const SizedBox(height: 40), 
                // //  Row( mainAxisAlignment: MainAxisAlignment.end, children: [ SvgPicture.asset(AppIcons.busSeat), 
                //  SizedBox(width: 95.w,), ], ),
Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    /// أيقونة الكرسي فوق لو باص عادي
    if (!miniBusSelected)
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(AppIcons.busSeat),
          SizedBox(width: 120.w),
        ],
      ),
    SizedBox(height: 12),

    /// 🚌 الميني باص
   /// 🚌 الميني باص
if (miniBusSelected) ...[
  Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      /// الصف الأول (كرسيين + السواق)
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...seatMatrix[0].take(2).map((seat) {
            if (seat == null) return const SizedBox(width: 40, height: 40);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: GestureDetector(
                onTap: () {
                  if (seat.status != "available" ||
                      isOccupied(seat.seatNumber.toString(), isMiniBus: true)) {
                    return;
                  }
                  toggleSeat(seat.seatNumber.toString(), isMiniBus: true);
                  if (selectedMiniBusSeats.contains(seat.seatNumber.toString())) {
                    _openSeatBottomSheet(seat.seatNumber.toString());
                  }
                },
                child: SeatBox(
                  label: seat.seatNumber.toString(),
                  isReserved: seat.status != "available",
                  isSelected: selectedMiniBusSeats.contains(seat.seatNumber.toString()),
                  color: seatColor(true, seat.seatNumber.toString(), seat.status!),
                ),
              ),
            );
          }).toList(),

          const SizedBox(width: 12),
          SvgPicture.asset(AppIcons.busSeat), // أيقونة السواق
        ],
      ),
      const SizedBox(height: 16),

      /// ✨ باقي الصفوف (كل صف فيه 3 كراسي جنب بعض)
      ...seatMatrix.skip(1).map((row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.take(3).map((seat) {
              if (seat == null) return const SizedBox(width: 40, height: 40);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: GestureDetector(
                  onTap: () {
                    if (seat.status != "available" ||
                        isOccupied(seat.seatNumber.toString(), isMiniBus: true)) {
                      return;
                    }
                    toggleSeat(seat.seatNumber.toString(), isMiniBus: true);
                    if (selectedMiniBusSeats.contains(seat.seatNumber.toString())) {
                      _openSeatBottomSheet(seat.seatNumber.toString());
                    }
                  },
                  child: SeatBox(
                    label: seat.seatNumber.toString(),
                    isReserved: seat.status != "available",
                    isSelected: selectedMiniBusSeats.contains(seat.seatNumber.toString()),
                    color: seatColor(true, seat.seatNumber.toString(), seat.status!),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    ],
  ),
]

 /// 🚌 الباص العادي (2 شمال + ممر + 2 يمين)
else ...[
  /// 🚌 الباص العادي (2 شمال + ممر + 2 يمين)
  ...seatMatrix.asMap().entries.map((entry) {
    final row = entry.value;

    // ✨ تأكد أن الصف فيه 4 عناصر
    final fixedRow = [
      ...row,
      ...List.filled(4 - row.length, null), // لو أقل من 4 يكمل null
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // أول عمودين شمال
          ...fixedRow.take(2).map((seat) {
            if (seat == null) return const SizedBox(width: 40, height: 40);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: GestureDetector(
                onTap: () {
                  toggleSeat(seat.seatNumber.toString(), isMiniBus: false);
                  if (selectedBusSeats.contains(seat.seatNumber.toString())) {
                    _openSeatBottomSheet(seat.seatNumber.toString());
                  }
                },
                child: SeatBox(
                  label: seat.seatNumber.toString(),
                  isReserved: seat.status != "available",
                  isSelected: selectedBusSeats.contains(seat.seatNumber.toString()),
                  color: seatColor(false, seat.seatNumber.toString(), seat.status!),
                ),
              ),
            );
          }).toList(),

          const SizedBox(width: 50), 

          ...fixedRow.skip(2).take(2).map((seat) {
            if (seat == null) return const SizedBox(width: 40, height: 40);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: GestureDetector(
                onTap: () {
                  toggleSeat(seat.seatNumber.toString(), isMiniBus: false);
                  if (selectedBusSeats.contains(seat.seatNumber.toString())) {
                    _openSeatBottomSheet(seat.seatNumber.toString());
                  }
                },
                child: SeatBox(
                  label: seat.seatNumber.toString(),
                  isReserved: seat.status != "available",
                  isSelected: selectedBusSeats.contains(seat.seatNumber.toString()),
                  color: seatColor(false, seat.seatNumber.toString(), seat.status!),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }).toList(),
],


  ],
)
,
                        

                   


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
                                        'tripdetails'.tr(),
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
                                        TripDetailsWidget(
                                          passengersData: miniBusSelected
                                              ? miniBusPassengersData
                                              : bigBusPassengersData,
                                        ),
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
    this.enabled,
  });
  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? enabled;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
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
