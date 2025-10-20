import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ticker_text/ticker_text.dart';
import 'package:transports/core/helper_function/snack_bar.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/icons.dart';
import 'package:transports/core/theming/images.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/core/validator/validator.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/back_button.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/camera_banner.dart';
import 'package:transports/features/home/data/models/previous_trips.dart';
import 'package:transports/features/home/presentation/view/widget/custom_text_form_field_passenger.dart';
import 'package:transports/features/home/presentation/view/widget/language_drop_down.dart';
import 'package:transports/features/home/presentation/view/widget/start_your_trip.dart';
import 'package:transports/features/home/presentation/view/widget/trip_details_widget.dart';
import 'package:transports/features/home/presentation/view_model/add_passenger_cubit/add_passenger_cubit.dart';
import 'package:transports/features/home/presentation/view_model/add_passenger_cubit/add_passenger_state.dart';
import 'package:transports/features/home/presentation/view_model/city_cubit/city_cubit.dart';
import 'package:transports/features/home/presentation/view_model/delete_passenger_cubit/delete_passenger_cubit.dart';
import 'package:transports/features/home/presentation/view_model/delete_passenger_cubit/delete_passenger_state.dart';
import 'package:transports/features/home/presentation/view_model/distance/distance_cubit.dart';
import 'package:transports/features/home/presentation/view_model/pick_data/extract_image_cubit.dart';
import 'package:transports/features/home/presentation/view_model/update_cities_cubit/update_trip_cubit.dart';
import 'package:transports/features/home/presentation/view_model/update_passenger_cubit/update_passenger_cubit.dart';
import 'package:transports/features/home/presentation/view_model/update_passenger_cubit/update_passenger_state.dart';

class UpdateTripDataView extends StatefulWidget {
  const UpdateTripDataView({
    super.key,
    required this.tripId,
    required this.trips,
  });

  final int tripId;
  final Data1 trips;

  @override
  State<UpdateTripDataView> createState() => _UpdateTripDataViewState();
}

class _UpdateTripDataViewState extends State<UpdateTripDataView> {
  void _handleFinalUpdate(BuildContext context) {
    final updateTripCubit = context.read<UpdateTripCubit>();
    final addPassengerCubit = context.read<AddPassengerCubit?>();
    final updatePassengerCubit = context.read<UpdatePassengerCubit?>();
    final deletePassengerCubit = context.read<DeletePassengerCubit?>();

    final bool allSuccess =
        (updateTripCubit.state is UpdateTripSuccess) &&
            (addPassengerCubit == null || addPassengerCubit.state is AddPassengerSuccess) &&
            (updatePassengerCubit == null || updatePassengerCubit.state is UpdatePassengerSuccess) &&
            (deletePassengerCubit == null || deletePassengerCubit.state is DeletePassengerSuccess);

    if (allSuccess) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: Text("تم تحديث الرحلة بنجاح"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(); // اغلاق البوب أب
                  Navigator.of(context).popUntil((route) => route.isFirst); // الخروج للشاشة الأولى
                },
                child: Text("حسناً", style: TextStyle(color: AppColors.primaryColor)),
              ),
            ],
          );
        },
      );
    } else {
      showAppSnackBar(
        context: context,
        message: "يرجى التأكد من نجاح جميع العمليات قبل التحديث النهائي",
        backgroundColor: Colors.orange,
      );
    }
  }

  List<Map<String, dynamic>> passengersData = [];
  String? selectedFromCity;
  String? selectedToCity;
  String? fromCity;
  String? toCity;
  int? fromCityId;
  int? toCityId;

  @override
  void initState() {
    super.initState();
    _loadTripData();
    context.read<CityCubit>().fetchCities();
  }

  void _loadTripData() {
    final trip = widget.trips;

    for (var seat in trip.seats ?? []) {
      final passenger = trip.passengers
          ?.firstWhere((p) => p.id == seat.passengerId, orElse: () => Passengers());

      passengersData.add({
        "id": passenger?.id,
        "seat_number": seat.seatNumber,
        "seat_id": seat.id,
        "status": seat.status, // available or occupied
        "name": passenger?.name,
        "national_id": passenger?.nationalId,
        "nationality": passenger?.nationality,
      });
      log("🪑 SEAT: ${seat.seatNumber}, passengerId: ${seat.passengerId}");
      log("👤 MATCHED PASSENGER: ${passenger?.name}, ID: ${passenger?.id}");

    }
      log("🚍 passengersData: $passengersData");

    selectedFromCity = trip.departureLocation;
    selectedToCity = trip.destinationLocation;

    fromCity = selectedFromCity;
    toCity = selectedToCity;

  }

  void _openPassengerBottomSheet(String seatNumber) {
    final passenger = passengersData.firstWhere(
          (p) => p['seat_number'] == seatNumber,
      orElse: () => {},
    );

    if (passenger.isEmpty) return;

    final isOccupied = passenger['status'] == "occupied";

    final nameController = TextEditingController(text: isOccupied ? passenger['name'] : '');
    final nationalIdController = TextEditingController(text: isOccupied ? passenger['national_id'] : '');
    final nationalityController = TextEditingController(text: isOccupied ? passenger['nationality'] : '');
    File? passengerImageForAdd;
    File? passengerImageForUpdate;


    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<ExtractImageCubit>()),
            if (isOccupied) BlocProvider(create: (_) => UpdatePassengerCubit()),
            if (isOccupied) BlocProvider(create: (_) => DeletePassengerCubit()),
            if (!isOccupied) BlocProvider(create: (_) => AddPassengerCubit()),
          ],
          child: MultiBlocListener(
            listeners: [
              BlocListener<ExtractImageCubit, ExtractImageState>(
                listener: (context, state) {
                  if (state is ExtractImageLoading) {
                    showAppSnackBar(
                      context: context,
                      message: "جارٍ استخراج البيانات...",
                    );
                  }
                  else if (state is ExtractImageSuccess) {
                    final extracted = state.model.data?.extractedData;
                    if (extracted != null) {
                      // ✅ تحديث القيم داخل setState لضمان إعادة بناء الواجهة بالبيانات الجديدة
                      setState(() {
                        nameController.text = extracted.fullName ?? '';
                        nationalIdController.text = extracted.nationalId ?? '';
                        nationalityController.text = extracted.nationality ?? '';
                      });
                    }

                    showAppSnackBar(
                      context: context,
                      message: state.model.message ?? "تم استخراج البيانات بنجاح",
                      backgroundColor: Colors.green,
                    );
                  }
                  else if (state is ExtractImageFailure) {
                    showAppSnackBar(
                      context: context,
                      message: state.message,
                      backgroundColor: Colors.red,
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Upload ID Image
                    CameraBanner(
                      isPassengerText: true,
                      title: "upload_image".tr(),
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
                          final pickedFile = await ImagePicker().pickImage(source: source);
                          if (pickedFile != null) {
                            final selectedImage = File(pickedFile.path);
                            if (isOccupied) {
                              passengerImageForUpdate = selectedImage;
                            } else {
                              passengerImageForAdd = selectedImage;
                            }
                            context.read<ExtractImageCubit>().extractImageData(selectedImage);
                          }

                        } catch (e) {
                          showAppSnackBar(
                            context: context,
                            message: "تعذر الوصول إلى ${source == ImageSource.camera ? "الكاميرا" : "المعرض"}",
                            backgroundColor: Colors.red,
                          );
                        }
                      },
                    ),

                    BlocBuilder<ExtractImageCubit, ExtractImageState>(
                      builder: (context, state) {
                        if (state is ExtractImageLoading) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "يتم استخراج البيانات من الصورة ...",
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),

                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: nameController,
                      hint: 'fullName'.tr(),
                      validator: (value) => Validators.validateName(value!),
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: nationalIdController,
                      hint: 'national_id'.tr(),
                      validator: (value) => Validators.validateNationalId(value!),
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: nationalityController,
                      hint: 'nationality'.tr(),
                      validator: (value) => Validators.validateNationality(value!),
                    ),
                    const SizedBox(height: 20),

                    if (isOccupied) ...[
                      /// Update
                      BlocConsumer<UpdatePassengerCubit, UpdatePassengerState>(
                        listener: (context, state) {
                          if (state is UpdatePassengerSuccess) {
                            final index = passengersData.indexWhere((p) => p['id'] == passenger['id']);
                            if (index != -1) {
                              passengersData[index] = {
                                ...passengersData[index],
                                "name": nameController.text,
                                "national_id": nationalIdController.text,
                                "nationality": nationalityController.text,
                              };
                              setState(() {});
                            }
                            Navigator.pop(context);
                            showAppSnackBar(
                              context: context,
                              message: state.message,
                              backgroundColor: Colors.green,
                            );
                          } else if (state is UpdatePassengerFailure) {
                            showAppSnackBar(
                              context: context,
                              message: state.errorMessage,
                              backgroundColor: Colors.red,
                            );
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 40),
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              final String? base64Image = passengerImageForUpdate != null
                                  ? base64Encode(passengerImageForUpdate!.readAsBytesSync())
                                  : null;
                              BlocProvider.of<UpdatePassengerCubit>(context).updatePassenger(
                                tripId: widget.tripId,
                                passengerId: passenger['id'],
                                body: {
                                  "name": nameController.text,
                                  "national_id": nationalIdController.text,
                                  "nationality": nationalityController.text,
                                  if (base64Image != null) "image": base64Image,
                                },
                              );
                            },
                            child: Text("update".tr()),
                          );
                        },
                      ),

                      const SizedBox(height: 10),

                      /// Delete
                      BlocConsumer<DeletePassengerCubit, DeletePassengerState>(
                        listener: (context, state) {
                          if (state is DeletePassengerSuccess) {
                            passengersData.removeWhere((p) => p['id'] == passenger['id']);
                            setState(() {});
                            Navigator.pop(context);
                            showAppSnackBar(
                              context: context,
                              message: state.model.message,
                              backgroundColor: Colors.green,
                            );
                          } else if (state is DeletePassengerFailure) {
                            showAppSnackBar(
                              context: context,
                              message: state.error,
                              backgroundColor: Colors.red,
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is DeletePassengerLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 40),
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              final passengerId = passenger['id'];
                              if (passengerId != null) {
                                context.read<DeletePassengerCubit>().deletePassenger(
                                  tripId: widget.tripId,
                                  passengerId: passengerId,
                                );
                              }
                            },
                            child: Text("delete".tr()),
                          );
                        },
                      ),
                    ] else ...[
                      /// Add
                      BlocConsumer<AddPassengerCubit, AddPassengerState>(
                        listener: (context, state) {
                          if (state is AddPassengerSuccess) {
                            passengersData.add({
                              "id": state.model.data?.id,
                              "seat_number": seatNumber,
                              "seat_id": state.model.data?.seatId,
                              "status": "occupied",
                              "name": nameController.text,
                              "national_id": nationalIdController.text,
                              "nationality": nationalityController.text,
                            });
                            setState(() {});
                            showAppSnackBar(
                              context: context,
                              message: state.model.message,
                              backgroundColor: Colors.green,
                            );
                            Navigator.pop(context);
                          } else if (state is AddPassengerFailure) {
                            showAppSnackBar(
                              context: context,
                              message: state.error,
                              backgroundColor: Colors.red,
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is AddPassengerLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 40),
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              final String? base64Image = passengerImageForAdd != null
                                  ? base64Encode(passengerImageForAdd!.readAsBytesSync())
                                  : null;


                              final seatId = passenger['seat_id'];

                              if (seatId != null) {
                                context.read<AddPassengerCubit>().addPassenger(
                                  tripId: widget.tripId,
                                  name: nameController.text,
                                  nationalId: nationalIdController.text,
                                  nationality: nationalityController.text,
                                  seatId: seatId,
                                  image: base64Image,
                                );
                              } else {
                                showAppSnackBar(
                                  context: context,
                                  message: "لم يتم اختيار مقعد للراكب",
                                  backgroundColor: Colors.red,
                                );
                              }
                            },
                            child: Text("add".tr()),
                          );
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  Color getSeatColor(String seatNumber) {
    final passenger = passengersData.firstWhere(
          (p) => p['seat_number'] == seatNumber,
      orElse: () => {"status": "available"},
    );

    if (passenger['status'] == "occupied") {
      return AppColors.blackColor;
    } else {
      return AppColors.primarySeatColor.withOpacity(0.1);
    }
  }

  Color getSeatTextColor(String seatNumber) {
    final passenger = passengersData.firstWhere(
          (p) => p['seat_number'] == seatNumber,
      orElse: () => {"status": "available"},
    );

    return passenger['status'] == "occupied" ? Colors.white : Colors.black;
  }

  Widget _seatBox(String seatNumber) {
    return GestureDetector(
      onTap: () => _openPassengerBottomSheet(seatNumber),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: getSeatColor(seatNumber),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black12),
        ),
        child: Text(
          seatNumber,
          style: TextStyle(
            color: getSeatTextColor(seatNumber),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  Widget _driverSeat() {
    return SvgPicture.asset(AppIcons.busSeat);
  }
  /// UI الميني باص (12)
  Widget _buildMiniBusLayout(int maxPassengers) {
    return Column(
      children: [
        // السواق + 2 قدام
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _seatBox("1"),
            const SizedBox(width: 8),
            _seatBox("2"),
            const SizedBox(width: 8),
            _driverSeat(), // مكان السواق
          ],
        ),
        const SizedBox(height: 20),
        // باقي الصفوف (3 كراسي × 3 صفوف)
        for (int row = 0; row < 3; row++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (col) {
                final seatNumber = (3 * row + col + 3).toString();
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _seatBox(seatNumber),
                );
              }),
            ),
          ),
      ],
    );
  }

  /// UI الحافلة (50)
  Widget _buildBigBusLayout(int maxPassengers) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 55),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _driverSeat(),// مكان السواق
            ],
          ),
        ),
        for (int row = 0; row < (maxPassengers / 4).ceil(); row++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 2 شمال
                if ((row * 4 + 1) <= maxPassengers)
                  _seatBox((row * 4 + 1).toString()),
                const SizedBox(width: 8),
                if ((row * 4 + 2) <= maxPassengers)
                  _seatBox((row * 4 + 2).toString()),

                const SizedBox(width: 40), // الممر

                // 2 يمين
                if ((row * 4 + 3) <= maxPassengers)
                  _seatBox((row * 4 + 3).toString()),
                const SizedBox(width: 8),
                if ((row * 4 + 4) <= maxPassengers)
                  _seatBox((row * 4 + 4).toString()),
              ],
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxPassengers = widget.trips.maxPassengers ?? 0;

    String busType = "";
    if (maxPassengers == 50) {
      busType = 'bus'.tr();
    } else if (maxPassengers == 12) {
      busType = 'minibus'.tr();
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    LanguageRowSelector()
                  ],
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: context.locale.languageCode == "ar"
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  child: BackButtonWidget(),
                ),
                SizedBox(height: 20.w),
                Center(child: Text("Edit_trip_data".tr(), style: TextStyles.font20Black700Weight)),
                const SizedBox(height: 20),

                if (busType.isNotEmpty) ...[
                  const SizedBox(height: 10),
          Container(
            height: 120.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.primaryLightGradientColor,
                  AppColors.primaryDarkGradientColor,
                ],
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Stack(
              children: [
                maxPassengers == 50?
                     Positioned(
                  bottom: 0,
                  left: 0,
                  child: Image.asset(AppImages.realBigBus, width: 110.w, height: 110.h),
                )
                    : Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(AppImages.realSmallBus, width: 110.w, height: 110.h),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        busType,
                        style: TextStyles.font16White500Weight,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: TickerText(
                          speed: 20,
                          primaryCurve: Curves.linear,
                          returnCurve: Curves.easeOut,
                          returnDuration: const Duration(milliseconds: 400),
                          startPauseDuration: const Duration(seconds: 1),
                          child: Text(
                            context.locale.languageCode == 'en'
                                ? '1 to $maxPassengers passenger${maxPassengers > 1 ? "s" : ""}'
                                : 'passenger_range'.tr(args: ["$maxPassengers"]),
                            style: TextStyles.font20White700Weight,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
          ],
                const SizedBox(height: 20),
                maxPassengers == 12
                    ? _buildMiniBusLayout(maxPassengers)
                    : _buildBigBusLayout(maxPassengers),
                const SizedBox(height: 20),
                Card(
                  color: AppColors.whiteColor,
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'tripdetails'.tr(),
                              style: TextStyles.font18MainBlack500Weight,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        /// Distance Display
                        BlocBuilder<DistanceCubit, DistanceState>(
                          builder: (context, state) {
                            if (state is DistanceLoading) {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is DistanceSuccess) {
                              final km = state.distanceModel.data?.distanceKm ?? 0;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'المسافة: ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${km.toInt()}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: ' كم',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else if (state is DistanceFailure) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'خطأ: ${state.error}',
                                  style: const TextStyle(fontSize: 16, color: Colors.red),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),

                        /// Route Line
                        TripArrowAnimation(tripStarted: true,),

                        /// Dropdowns for cities
                        BlocListener<UpdateTripCubit, UpdateTripState>(
                          listener: (context, state) {
                            if (state is UpdateTripSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.message),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } else if (state is UpdateTripFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.errorMessage),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: Row(
                            children: [
                              /// To City Dropdown
                              Expanded(
                                child: BlocBuilder<CityCubit, CityState>(
                                  builder: (context, state) {
                                    if (state is CityLoading) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                      );
                                    }

                                    if (state is CityFailure) {
                                      return Text(
                                        "فشل في تحميل المدن",
                                        style: TextStyles.font12SecondaryBlack500Weight,
                                      );
                                    }

                                    if (state is CitySuccess) {
                                      final cities = state.cities;

                                      if (cities.isEmpty) {
                                        return Text(
                                          "لا توجد مدن متاحة",
                                          style: TextStyles.font12SecondaryBlack500Weight,
                                        );
                                      }

                                      final cityNames = cities
                                          .map((e) => context.locale.languageCode == 'ar'
                                          ? e.nameAr
                                          : e.nameEn)
                                          .whereType<String>()
                                          .toSet()
                                          .toList();

                                      return DropdownButton<String>(
                                        isExpanded: true,
                                        value: cityNames.contains(toCity) ? toCity : null,
                                        hint: Text(
                                          'to'.tr(),
                                          style: TextStyles.font12SecondaryBlack500Weight,
                                        ),
                                        onChanged: (value) {
                                          if (value != null) {
                                            final cityId = cities.firstWhere(
                                                  (city) =>
                                              (context.locale.languageCode == 'ar'
                                                  ? city.nameAr
                                                  : city.nameEn) ==
                                                  value,
                                            ).id;

                                            setState(() {
                                              toCity = value;
                                              toCityId = cityId;
                                            });

                                            if (fromCityId != null && toCityId != null) {
                                              context.read<DistanceCubit>().calculateDistance(
                                                fromCityId: fromCityId!,
                                                toCityId: toCityId!,
                                              );

                                              context.read<UpdateTripCubit>().updateTrip(
                                                tripId: widget.tripId,
                                                departureLocation: fromCity!,
                                                destinationLocation: toCity!,
                                                distanceKm: widget.trips.distanceKm!
                                              );
                                            }
                                          }
                                        },
                                        items: cityNames.map((city) {
                                          return DropdownMenuItem<String>(
                                            value: city,
                                            child: Text(city),
                                          );
                                        }).toList(),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              /// From City Dropdown
                              Expanded(
                                child: BlocBuilder<CityCubit, CityState>(
                                  builder: (context, state) {
                                    if (state is CityLoading) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                      );
                                    }

                                    if (state is CityFailure) {
                                      return Text(
                                        "فشل في تحميل المدن",
                                        style: TextStyles.font12SecondaryBlack500Weight,
                                      );
                                    }

                                    if (state is CitySuccess) {
                                      final cities = state.cities;

                                      if (cities.isEmpty) {
                                        return Text(
                                          "لا توجد مدن متاحة",
                                          style: TextStyles.font12SecondaryBlack500Weight,
                                        );
                                      }

                                      final cityNames = cities
                                          .map((e) => context.locale.languageCode == 'ar'
                                          ? e.nameAr
                                          : e.nameEn)
                                          .whereType<String>()
                                          .toSet()
                                          .toList();

                                      return DropdownButton<String>(
                                        isExpanded: true,
                                        value: cityNames.contains(fromCity) ? fromCity : null,
                                        hint: Text(
                                          'from'.tr(),
                                          style: TextStyles.font12SecondaryBlack500Weight,
                                        ),
                                        onChanged: (value) {
                                          if (value != null) {
                                            final cityId = cities.firstWhere(
                                                  (city) => (context.locale.languageCode == 'ar'
                                                  ? city.nameAr
                                                  : city.nameEn) ==
                                                  value,
                                            ).id;

                                            setState(() {
                                              fromCity = value;
                                              fromCityId = cityId;
                                            });

                                            if (fromCityId != null && toCityId != null) {
                                              context.read<DistanceCubit>().calculateDistance(
                                                fromCityId: fromCityId!,
                                                toCityId: toCityId!,
                                              );

                                              context.read<UpdateTripCubit>().updateTrip(
                                                tripId: widget.tripId,
                                                departureLocation: fromCity!,
                                                destinationLocation: toCity!,
                                                distanceKm: widget.trips.distanceKm!
                                              );
                                            }
                                          }
                                        },
                                        items: cityNames.map((city) {
                                          return DropdownMenuItem<String>(
                                            value: city,
                                            child: Text(city),
                                          );
                                        }).toList(),
                                      );
                                    }

                                    return const SizedBox.shrink();
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                CustomPrimaryButton(
                  text: "update".tr(),
                  onPressed: () {
                    _handleFinalUpdate(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
