// import 'package:flutter/material.dart';
// import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
// import 'package:get/get.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:mobile/features/service/controllers/map/map_navigation_controller.dart';
// import 'package:mobile/utils/helpers/helper_functions.dart';
//
// class MapNavigationScreen extends StatelessWidget {
//   const MapNavigationScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // final mapController = Get.put(MapNavigationController());
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Map Navigation'),
//       ),
//       body: SafeArea(
//         child: Obx(() {
//           // Display a loading indicator if navigation is initializing
//           if (mapController.isNavigating.value == false && mapController.routeBuilt.value == false) {
//             return Center(child: CircularProgressIndicator());
//           }
//           return Stack(
//             children: [
//               SizedBox(
//                 height: THelperFunctions.screenHeight(),
//                 child: MapBoxNavigationView(
//                   onRouteEvent: mapController.onRouteEvent,
//                   onCreated: (MapBoxNavigationViewController controller) async {
//                     mapController.controller = controller;
//                     await mapController.initialize();
//                   },
//                 ),
//               ),
//               // Optionally add additional UI elements here
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }
