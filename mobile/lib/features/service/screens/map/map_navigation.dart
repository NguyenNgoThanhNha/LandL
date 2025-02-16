// import 'package:flutter/material.dart';
// import 'package:flutter_mapbox_navigation/library.dart';
// import 'package:get/get.dart';
// import 'package:mobile/features/service/controllers/map/map_navigation_controller.dart';
//
// class MapNavigationScreen extends StatelessWidget {
//   const MapNavigationScreen({super.key, required this.id});
//
//   final int id;
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(MapNavigationController(id: id));
//     return  Scaffold(
//         appBar: AppBar(title: const Text('Turn By Turn Navigation')),
//         body: Obx(() {
//       // Handle loading state
//       if (controller.loading.value) {
//         return const Center(child:  CircularProgressIndicator());
//       }
//
//       return Stack(
//         children: [
//           // The MapBoxNavigationView displays the map
//           MapBoxNavigationView(
//             onCreated: controller.onMapCreated,
//             options: MapBoxOptions(
//               zoom: 13.0,
//               tilt: 0.0,
//               bearing: 0.0,
//               voiceInstructionsEnabled: true,
//               bannerInstructionsEnabled: true,
//               allowsUTurnAtWayPoints: true,
//               mode: MapBoxNavigationMode.drivingWithTraffic,
//               units: VoiceUnits.imperial,
//               simulateRoute: false,
//               language: "en",
//             ),
//           ),
//           // Overlay: Show distance, duration, and instructions on top of the map
//
//         ],
//       );}
//
//     ));
//   }
// }
