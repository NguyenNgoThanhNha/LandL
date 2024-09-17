// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:mobile/commons/widgets/appbar/appbar.dart';
// import 'package:mobile/utils/helpers/helper_functions.dart';
//
// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});
//
//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   @override
//   Widget build(BuildContext context) {
//      return Scaffold(
//       appBar: const TAppbar(
//         showBackArrow: true,
//       ),
//       body: SafeArea(
//         child: Stack(
//           // children: [
//             SizedBox(
//               height: THelperFunctions.screenHeight(),
//               child: MapboxMap(
//                 accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
//                 initialCameraPosition: mapController.initialCameraPosition,
//                 zoomGesturesEnabled: true,
//                 myLocationEnabled: true,
//                 trackCameraPosition: true,
//                 scrollGesturesEnabled: true,
//                 myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
//                 styleString: MapboxStyles.OUTDOORS,
//                 compassEnabled: true,
//                 // onMapCreated: mapController.onMapCreated,
//                 // onStyleLoadedCallback: mapController.onStyleLoadedCallback,
//                 minMaxZoomPreference: const MinMaxZoomPreference(4, 20),
//               ),
//             ),
//
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () =>
//             mapController.controller.animateCamera(
//                 CameraUpdate.newCameraPosition(
//                     mapController.initialCameraPosition)),
//         child: const Icon(Icons.my_location_sharp),
//       ),
//     );
//   }
// }
