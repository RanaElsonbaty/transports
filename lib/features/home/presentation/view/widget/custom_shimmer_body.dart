
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transports/core/theming/colors.dart';

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
