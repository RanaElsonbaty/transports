import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/icons.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/features/home/presentation/view/passenger_data.dart';
import 'package:transports/features/home/presentation/view/widget/start_your_trip.dart';

class BusSeatSelectionScreen extends StatefulWidget {
  const BusSeatSelectionScreen({super.key});

  @override
  State<BusSeatSelectionScreen> createState() => _BusSeatSelectionScreenState();
}

class _BusSeatSelectionScreenState extends State<BusSeatSelectionScreen> {
  final List<String> reservedSeats = ["C2", "D4", "E4", "G4"];
  final Set<String> selectedSeats = {};

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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
        Expanded(
          child: Column(
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
                            onTap: () => toggleSeat(row[i]),
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
                            onTap: () => toggleSeat(row[i]),
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
        ),
        const SizedBox(height: 20),
        CustomPrimaryButton(
          text: 'تاكيد',
          onPressed: () {
            if (selectedSeats.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('يرجى اختيار مقعد أولاً')),
              );
              return;
            }
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PassengerDataView()),
            );
          },
        ),
      ],
    );
  }
}

class SeatBox extends StatelessWidget {
  final String label;
  final bool isReserved;
  final bool isSelected;
    final Color? color; 

  const SeatBox({
    super.key,
    required this.label,
    this.isReserved = false,
    this.isSelected = false, this.color,
  });

  @override
  Widget build(BuildContext context) {
 final boxColor = color ??
        (isReserved
            ? Colors.black
            : isSelected
                ? AppColors.primarySeatColor
                : AppColors.primarySeatColor.withOpacity(.1));
 final textStyle = TextStyles.font14SeatBlack500Weight.copyWith(
      color: isSelected || isReserved ? Colors.white : Colors.black,
    );
    return Container(
      height: 40.h,
      width: 40.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style:textStyle
      ),
    );
  }
}
