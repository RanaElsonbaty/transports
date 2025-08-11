// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:transports/core/theming/colors.dart';
// import 'package:transports/core/theming/icons.dart';
// import 'package:transports/core/theming/styles.dart';
// import 'package:transports/features/auth/register/presentation/view/widgets/back_button.dart';
// import 'package:transports/features/home/presentation/view/widget/start_your_trip.dart';

// class LocationSelectionView extends StatefulWidget {
//   final String title;
//   final void Function()? onPressed;
//   const LocationSelectionView({required this.title, super.key, this.onPressed});

//   @override
//   State<LocationSelectionView> createState() => _LocationSelectionViewState();
// }

// class _LocationSelectionViewState extends State<LocationSelectionView> {
//   LatLng? currentPosition;

//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return;
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
//       permission = await Geolocator.requestPermission();
//       if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) return;
//     }

//     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       currentPosition = LatLng(position.latitude, position.longitude);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Row(
//               children: [
//                 BackButtonWidget(),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Text(widget.title, style: TextStyles.font24MainBlack500Weight),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'ابحث',
//                 hintStyle: TextStyles.font14CardColor500Weight,
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.all(13),
//                   child: SvgPicture.asset(
//                     AppIcons.location,
//                     width: 20,
//                     height: 20,
//                   ),
//                 ),
//                 filled: true,
//                 fillColor: AppColors.dividerColor,
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: AppColors.dividerColor),
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: AppColors.dividerColor),
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//                 border: OutlineInputBorder(
//                   borderSide: const BorderSide(color: AppColors.dividerColor),
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           ListTile(
//             title: Text('اختر موقعك الحالي',style: TextStyles.font16SecondaryBlack500Weight,),
//             leading: SvgPicture.asset(
//               AppIcons.location,
//               width: 24,
//               height: 24,
//             ),
//             onTap: _getCurrentLocation,
//           ),
//           Divider(thickness: 1,color: AppColors.greyColor,),
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Row(
//               children: [
//                 Text('الاخيره',style: TextStyles.font14CardColor500Weight,),
//               ],
//             ),
//           ),
//           if (currentPosition != null)
//             SizedBox(
//               height: 200,
//               child: GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                   target: currentPosition!,
//                   zoom: 15,
//                 ),
//                 markers: {
//                   Marker(
//                     markerId: const MarkerId("current"),
//                     position: currentPosition!,
//                   )
//                 },
//               ),
//             ),
//          SizedBox(height: 90.h,),
//           CustomPrimaryButton(text: 'تأكيد',onPressed:widget.onPressed
//             //() {
//             // if (currentPosition != null) {
//             //   showGeneralDialog(
//             //     context: context,
//             //     barrierDismissible: true,
//             //     barrierLabel: '',
//             //     transitionDuration: const Duration(milliseconds: 300),
//             //     pageBuilder: (context, animation, secondaryAnimation) {
//             //       return Center(
//             //         child: Container(
//             //           margin: const EdgeInsets.symmetric(horizontal: 30),
//             //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//             //           decoration: BoxDecoration(
//             //             color: AppColors.primaryDarkGradientColor,
//             //             borderRadius: BorderRadius.circular(15),
//             //           ),
//             //           child: Text(
//             //             "تم اختيار الموقع: ${currentPosition!.latitude}, ${currentPosition!.longitude}",
//             //             style: TextStyles.font14White400Weight.copyWith(
//             //               decoration: TextDecoration.none,
//             //             ),
//             //             textAlign: TextAlign.center,
//             //           ),
//             //         ),
//             //       );
//             //     },
//             //   );
//             // } else {
//             //   showGeneralDialog(
//             //     context: context,
//             //     barrierDismissible: true,
//             //     barrierLabel: '',
//             //     pageBuilder: (context, animation1, animation2) {
//             //       return Center(
//             //         child: Container(
//             //           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//             //           margin: const EdgeInsets.symmetric(horizontal: 40),
//             //           decoration: BoxDecoration(
//             //             color: AppColors.primaryDarkGradientColor,
//             //             borderRadius: BorderRadius.circular(15),
//             //           ),
//             //           child: Text(
//             //             "يرجى اختيار الموقع أولاً",
//             //             style: TextStyles.font14White400Weight.copyWith(
//             //               decoration: TextDecoration.none,),
//             //             textAlign: TextAlign.center,
//             //           ),
//             //         ),
//             //       );
//             //     },
//             //   );
//             //
//             // }
//          // }
//         )
//         ],
//       ),
//     );
//   }
// }
