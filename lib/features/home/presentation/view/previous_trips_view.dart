import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transports/core/service/service_locater.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/core/theming/styles.dart';
import 'package:transports/features/auth/register/presentation/view/widgets/back_button.dart';
import 'package:transports/features/home/data/models/previous_trips.dart';
import 'package:transports/features/home/presentation/view/update_trip_date_view.dart';
import 'package:transports/features/home/presentation/view/widget/custom_shimmer_body.dart';
import 'package:transports/features/home/presentation/view/widget/language_drop_down.dart';
import 'package:transports/features/home/presentation/view/widget/previous_empty_trip.dart';
import 'package:transports/features/home/presentation/view/widget/web_view_page.dart';
import 'package:transports/features/home/presentation/view_model/city_cubit/city_cubit.dart';
import 'package:transports/features/home/presentation/view_model/distance/distance_cubit.dart';
import 'package:transports/features/home/presentation/view_model/pick_data/extract_image_cubit.dart';
import 'package:transports/features/home/presentation/view_model/previous_trip/previous_trips_cubit.dart';
import 'package:transports/features/home/presentation/view_model/update_cities_cubit/update_trip_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class PreviousTripsView extends StatelessWidget {
  const PreviousTripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: BlocBuilder<PreviousTripsCubit, PreviousTripsState>(
        builder: (context, state) {
          if (state is PreviousTripsSuccess) {
            if(state.trips.isEmpty){
              return PreviousEmptyTrip();
            }
  return Column(
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
      Center(child: Text("previous_trips".tr(), style: TextStyles.font20Black700Weight)),
      Expanded(
        child: ListView.builder(

            itemCount:state.trips.length ,
            itemBuilder: (context, index) {
              return PreviousTripItem(trips:state.trips[index] ,);
            },
          ),
      ),
    ],
  );
}else if(state is PreviousTripsFailure){
  return Center(child: Text(state.errorMessage,style: TextStyle(color: AppColors.red,fontSize: 24),));
}else{
 return CustomPreviouseTripsShimmerBody();
              }
        },
      ),
    );
  }
}

class PreviousTripItem extends StatelessWidget {
  const PreviousTripItem({
    super.key, required this.trips,
  });
 final Data1 trips;
   @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        // leading: const Icon(Icons.directions_bus, color: AppColors.primaryColor),
        title: Text(
      "${trips.destinationLocation} ← ${trips.departureLocation}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Text(
              "${"departure_time".tr()}: "
                  "${trips.departureTime == null
                  ? "no_time".tr()
                  : DateFormat('HH:mm').format(
                  DateTime.parse(trips.departureTime!).toLocal()
              )
              }",
            ),
            Text("${"passengers".tr()}: ${trips.totalPassengers} / ${trips.maxPassengers}"),
            Text("${"status".tr()}: ${trips.status}"),
          ],
        ),
         trailing: Row(
           mainAxisSize: MainAxisSize.min,
           children: [
             IconButton(
                   icon: const Icon(Icons.visibility, color: AppColors.primaryColor),
                   onPressed: () {
                     Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HtmlViewerPage(
                  // url: "https://my-app-livid-ten-94.vercel.app/?tripId=${trips.id}",
               url: "https://my-app-livid-ten-94.vercel.app/trips/${trips.id}",
                ),
              ),
                     );
                   },
                 ),
             IconButton(
               icon: Image.asset('assets/svgs/whatsapp_icon.png',height: 22,width: 22,),
               onPressed: () async {
                 final tripUrl = "https://my-app-livid-ten-94.vercel.app/trips/${trips.id}";
                 final whatsappUrl = Uri.parse("https://wa.me/?text=$tripUrl");
                 try {
                   if (await canLaunchUrl(whatsappUrl)) {
                     await launchUrl(
                       whatsappUrl,
                       mode: LaunchMode.externalApplication,
                     );
                   } else {
                     ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(
                         content: Text("لا يمكن فتح واتساب."),
                       ),
                     );
                   }
                 } catch (e) {
                   debugPrint("Error launching WhatsApp: $e");
                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                       content: Text("فشل في المشاركة عبر واتساب: $e"),
                     ),
                   );
                 }
               },
             ),
             IconButton(
               icon: const Icon(Icons.edit, color: AppColors.primaryColor),
               onPressed: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) => MultiBlocProvider(
                       providers: [
                         BlocProvider(
                           create: (context) => getIt.get<CityCubit>(),
                         ),
                         BlocProvider(
                           create: (context) => DistanceCubit(),
                         ),
                         BlocProvider(
                           create: (context) => ExtractImageCubit(),
                         ),
                         BlocProvider(
                           create: (context) => UpdateTripCubit(),
                         ),
                       ],
                       child: UpdateTripDataView(
                         tripId: trips.id!,
                         trips: trips,
                       ),
                     ),
                   ),
                 ).then((_) {
                   context.read<PreviousTripsCubit>().getTrips();
                 });
               },
             ),

           ],
         ),
     )
    );
}
}
