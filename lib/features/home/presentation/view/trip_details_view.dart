import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/features/home/presentation/view/bus_seat_selection_view.dart';
import 'package:transports/features/home/presentation/view/widget/start_your_trip.dart';

class TripDetailsView extends StatefulWidget {
  const TripDetailsView({super.key});

  @override
  State<TripDetailsView> createState() => _TripDetailsViewState();
}

class _TripDetailsViewState extends State<TripDetailsView> {
  late GoogleMapController mapController;

  final LatLng fromLocation = const LatLng(28.4326, 45.9631); // حفر الباطن (مثال)
  final LatLng toLocation = const LatLng(21.4858, 39.1925);   // جدة
  final int completedSteps = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(),
          // GoogleMap(
          //   initialCameraPosition: CameraPosition(
          //     target: LatLng(
          //       (fromLocation.latitude + toLocation.latitude) / 2,
          //       (fromLocation.longitude + toLocation.longitude) / 2,
          //     ),
          //     zoom: 5.8,
          //   ),
          //   markers: {
          //     Marker(
          //       markerId: const MarkerId("from"),
          //       position: fromLocation,
          //       infoWindow: const InfoWindow(title: "حفر الباطن"),
          //     ),
          //     Marker(
          //       markerId: const MarkerId("to"),
          //       position: toLocation,
          //       infoWindow: const InfoWindow(title: "جدة"),
          //     ),
          //   },
          //   polylines: {
          //     Polyline(
          //       polylineId: const PolylineId("route"),
          //       color: Colors.teal,
          //       width: 4,
          //       points: [fromLocation, toLocation],
          //     ),
          //   },
          //   onMapCreated: (controller) => mapController = controller,
          //   zoomControlsEnabled: false,
          //   myLocationEnabled: false,
          //   mapType: MapType.normal,
          // ),
          //
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric( vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'تفاصيل الرحله',
                          style: TextStyles.font18MainBlack500Weight,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(6, (index) {
                        bool isDone = index < completedSteps;
                        return Container(
                          margin: const EdgeInsets.only(right: 4),
                          width: 50,
                          height: 3,
                          decoration: BoxDecoration(
                            color: isDone ? AppColors.primaryLightGradientColor : AppColors.dividerColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("من",style: TextStyles.font12MainBlack500Weight,),
                            Text("حفر الباطن",style: TextStyles.font12MainBlack500Weight,),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("إلى",style: TextStyles.font12MainBlack500Weight,),
                            Text("جده",style: TextStyles.font12MainBlack500Weight,),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Divider(color: AppColors.dividerColor,),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text("عدد الركاب: 09",style: TextStyles.font12MainBlack500Weight,),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text("المسافه بالكيلومتر: 120 كم",style: TextStyles.font12MainBlack500Weight,),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text("الوقت المتوقع للوصول: 12 ساعة",style: TextStyles.font12MainBlack500Weight,),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Divider(color: AppColors.dividerColor,),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "الوقت المتبقي للوصول",
                          style: TextStyles.font12SecondaryBlack500Weight,
                        ),
                        Text(
                          "30mins",
                          style: TextStyles.font16MainBlack500Weight
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomPrimaryButton(text: 'انهاء الرحله ',
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BusSeatSelectionScreen()));
                  },)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
