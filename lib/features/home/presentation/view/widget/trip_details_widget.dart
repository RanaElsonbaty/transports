import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/features/home/presentation/view/widget/start_your_trip.dart';

class TripDetailsWidget extends StatefulWidget {
  const TripDetailsWidget({super.key});

  @override
  State<TripDetailsWidget> createState() => _TripDetailsWidgetState();
}

class _TripDetailsWidgetState extends State<TripDetailsWidget> {
  String? fromCity;
  String? toCity;
  bool tripStarted = false;

  final List<String> cities = ['جدة', 'الرياض', 'مكة', 'الدمام', 'حفر الباطن'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
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
                        'تفاصيل الرحلة',
                        style: TextStyles.font18MainBlack500Weight,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("من"),
                          const SizedBox(width: 10),
                          Container(
                            width: 20,
                            height: 2,
                            color: tripStarted ? AppColors.primaryStateColor : AppColors.greyColor,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 20,
                            height: 2,
                            color: tripStarted ? AppColors.primaryStateColor : AppColors.greyColor,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 20,
                            height: 2,
                            color: tripStarted ? AppColors.primaryStateColor : AppColors.greyColor,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 20,
                            height: 2,
                            color: tripStarted ? AppColors.primaryStateColor : AppColors.greyColor,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 20,
                            height: 2,
                            color: tripStarted ? AppColors.primaryStateColor : AppColors.greyColor,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 20,
                            height: 2,
                            color: tripStarted ? AppColors.primaryStateColor : AppColors.greyColor,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 20,
                            height: 2,
                            color: tripStarted ? AppColors.primaryStateColor : AppColors.greyColor,
                          ),
                          Icon(
                            Icons.arrow_right,
                            color: tripStarted ? AppColors.primaryStateColor : AppColors.greyColor,
                            size: 40,
                          ),
                          const SizedBox(width: 10),
                          Text("إلى"),
                        ],
                      ),

                    ],
                  ),
                  Row(
                    children: [
                      // from
                      DropdownButton<String>(
                        value: fromCity,
                        hint: Text('من',style: TextStyles.font12SecondaryBlack500Weight,),
                        onChanged: (value) {
                          setState(() {
                            fromCity = value;
                          });
                        },
                        items: cities.map((city) {
                          return DropdownMenuItem(
                            value: city,
                            child: Text(city),
                          );
                        }).toList(),
                      ),
                      Spacer(),
                      // to
                      DropdownButton<String>(
                        value: toCity,
                        hint: Text('إلى',style: TextStyles.font12SecondaryBlack500Weight,),
                        onChanged: (value) {
                          setState(() {
                            toCity = value;
                          });
                        },
                        items: cities.map((city) {
                          return DropdownMenuItem(
                            value: city,
                            child: Text(city),
                          );
                        }).toList(),
                      ),
                  ],)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 200),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CustomPrimaryButton(
            text: 'ابدأ الرحلة الآن',
            onPressed: () {
              if (fromCity != null && toCity != null) {
                setState(() {
                  showModalBottomSheet(
                    context: context,
                    isDismissible: false,
                    isScrollControlled: false,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) {
                      Future.delayed(const Duration(seconds: 3), () {
                        Navigator.of(context).pop();
                      });

                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                'assets/lottie/loading.json',
                                width: 80,
                                height: 80,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'الرجاء الإنتظار دقيقة للموافقة من الإدارة\n على بداية الرحلة',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                  tripStarted = true;
                });
              } else {
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: '',
                  transitionDuration: const Duration(milliseconds: 300),
                  pageBuilder: (context, animation1, animation2) {
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.of(context).pop();
                    });

                    return const SizedBox();
                  },
                  transitionBuilder: (context, animation, secondaryAnimation, child) {
                    final curvedValue = Curves.easeInOut.transform(animation.value);

                    return Opacity(
                      opacity: curvedValue,
                      child: Transform.scale(
                        scale: curvedValue,
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              'يرجى اختيار المدينتين أولاً!',
                              textAlign: TextAlign.center,
                              style: TextStyles.font14White700Weight.copyWith(decoration: TextDecoration.none,),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
