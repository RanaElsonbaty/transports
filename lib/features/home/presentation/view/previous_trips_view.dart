
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transports/core/theming/colors.dart';
import 'package:transports/features/home/data/models/previous_trips.dart';
import 'package:transports/features/home/presentation/view/widget/custom_shimmer_body.dart';
import 'package:transports/features/home/presentation/view/widget/previous_empty_trip.dart';
import 'package:transports/features/home/presentation/view/widget/web_view_page.dart';
import 'package:transports/features/home/presentation/view_model/previouse_trip/previous_trips_cubit.dart';

class PreviousTripsView extends StatelessWidget {
  const PreviousTripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("previous_trips".tr(),style: TextStyle(color: AppColors.primaryColor,fontSize: 25,fontWeight: FontWeight.bold),)),
      body: BlocBuilder<PreviousTripsCubit, PreviousTripsState>(
        builder: (context, state) {
          if (state is PreviousTripsSuccess) {
            if(state.trips.isEmpty){
              return PreviousEmptyTrip();
            }
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
//           Row(
//   mainAxisSize: MainAxisSize.min,
//   children: [
//     IconButton(
//       icon: const Icon(Icons.visibility, color: AppColors.primaryColor),
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => HtmlViewerPage(
//               url: "https://my-app-livid-ten-94.vercel.app/?tripId=${trips.id}",
//             ),
//           ),
//         );
//       },
//     ),
//     IconButton(
//       icon: const Icon(Icons.download, color: AppColors.primaryColor),
//       onPressed: () async {
// //  await downloadHtmlAsPdfSafe(
// //       trips,
// //     );      },
//       }
  
//     ),
//   ],
// ),

      ),
    );
//   }
// Future<void> downloadHtmlAsPdfSafe(Data1 trip) async {
//   try {
//     final url = "https://my-app-livid-ten-94.vercel.app/?tripId=${trip.id}";
//     final response = await Dio().get<String>(url);
//     final htmlContent = response.data ?? "<h1>No Data</h1>";

//     final dir = await getTemporaryDirectory();
//     final targetPath = dir.path;
//     final targetFileName = "trip_${trip.id}";

//     final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
//       htmlContent,
//       targetPath,
//       targetFileName,
//     );

//     await OpenFilex.open(generatedPdfFile.path);

//   } catch (e) {
//     print("Error generating PDF: $e");
//   }
// }





// Future<void> downloadAndOpenPdf(int tripId) async {
//   try {
//    final url = "https://my-app-livid-ten-94.vercel.app/?tripId=$tripId";
//     print("Downloading PDF from: $url");

//     final response = await Dio().get<List<int>>(
//       url,
//       options: Options(
//         responseType: ResponseType.bytes,
//         headers: {
//           "User-Agent": "Mozilla/5.0",
//           "Accept": "application/pdf",
//         },
//         followRedirects: true, 
//         validateStatus: (status) => status! < 500, 
//       ),
//     );

//     print("File length: ${response.data?.length}");

//     if (response.data == null || response.data!.isEmpty) {
//       print("PDF not valid or empty");
//       return;
//     }

//     final dir = await getTemporaryDirectory();
//     final filePath = "${dir.path}/trip_$tripId.pdf";
//     final file = File(filePath);
//     await file.writeAsBytes(response.data!);

//     await OpenFilex.open(filePath);
//   } catch (e) {
//     print("Error downloading PDF: $e");
//   }
// }



}
}