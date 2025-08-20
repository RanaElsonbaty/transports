import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/features/home/data/models/previous_trips.dart';
import 'package:transports/features/home/presentation/view_model/previouse_trip/previous_trips_cubit.dart';

class PreviousTripsView extends StatelessWidget {
  const PreviousTripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("previous_trips".tr(),style: TextStyle(color: AppColors.primaryColor,fontSize: 25,fontWeight: FontWeight.bold),)),
      body: BlocBuilder<PreviousTripsCubit, PreviousTripsState>(
        builder: (context, state) {
          if (state is PreviousTripsSuccess) {
  return ListView.builder(

      itemCount:state.trips.length ,
      itemBuilder: (context, index) {
        
        return PreviousTripItem(trips:state.trips[index] ,);
      },
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

class CustomPreviouseTripsShimmerBody extends StatelessWidget {
  const CustomPreviouseTripsShimmerBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
           itemCount: 20, 
           itemBuilder: (context, index) {
             return Shimmer.fromColors(
               baseColor: Colors.grey.shade300,
               highlightColor: Colors.grey.shade100,
               child:  Card(
         margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
         elevation: 3,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(12),
         ),
         child: ListTile(
           leading: const Icon(Icons.directions_bus, color: AppColors.primaryColor),
           title: Text(
         " → ",
             style: const TextStyle(fontWeight: FontWeight.bold),
           ),
           subtitle: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               const SizedBox(height: 6),
               Text(" "),
               Text(" "),
             ],
           ),
            trailing: IconButton(
             icon: const Icon(Icons.download, color: AppColors.primaryColor),
             onPressed: () async {
    
             },
           ),
         ),
       )
             );
           });
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
        leading: const Icon(Icons.directions_bus, color: AppColors.primaryColor),
        title: Text(
      "${trips.departureLocation} → ${trips.destinationLocation}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Text("${"departure_time".tr()}: ${DateFormat('HH:mm').format(DateTime.parse(trips.departureTime??"no_time".tr()))  }"),
            Text("${"passengers".tr()}: ${trips.totalPassengers} / ${trips.maxPassengers}"),
            Text("${"status".tr()}: ${trips.status}"),
          ],
        ),
         trailing: IconButton(
          icon: const Icon(Icons.download, color: AppColors.primaryColor),
          onPressed: () async {
           await downloadAndOpenPdf(trips.id!);

          },
        ),
      ),
    );
  }
Future<void> downloadAndOpenPdf(int tripId) async {
  try {
   final url = "https://my-app-livid-ten-94.vercel.app/?tripId=$tripId";
    print("Downloading PDF from: $url");

    final response = await Dio().get<List<int>>(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        headers: {
          "User-Agent": "Mozilla/5.0",
          "Accept": "application/pdf",
        },
        followRedirects: true, 
        validateStatus: (status) => status! < 500, 
      ),
    );

    print("File length: ${response.data?.length}");

    if (response.data == null || response.data!.isEmpty) {
      print("PDF not valid or empty");
      return;
    }

    final dir = await getTemporaryDirectory();
    final filePath = "${dir.path}/trip_$tripId.pdf";
    final file = File(filePath);
    await file.writeAsBytes(response.data!);

    await OpenFilex.open(filePath);
  } catch (e) {
    print("Error downloading PDF: $e");
  }
}



}
