// import 'package:flutter/services.dart';
// import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
// import 'package:get/get.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:mobile/utils/helpers/get_storage.dart';
//
// class MapNavigationController extends GetxController {
//   static MapNavigationController get instance => Get.find();
//   late MapBoxNavigationViewController mapboxController;
//
//   final currentLocation = const LatLng(0, 0).obs;
//   final currentAddress = ''.obs;
//   late CameraPosition initialCameraPosition;
//
//   late MapBoxNavigation directions;
//   late MapBoxOptions options;
//   var wayPoints = <WayPoint>[].obs;
//   late double distanceRemaining, durationRemaining;
//   late MapBoxNavigationViewController controller;
//
//   var instruction = "".obs;
//   var arrived = false.obs;
//   var routeBuilt = false.obs;
//   var isNavigating = false.obs;
//   final bool isMultipleStop = false;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadCurrentLocation();
//     loadCurrentAddress();
//     initialCameraPosition =
//         CameraPosition(target: currentLocation.value, zoom: 14);
//     print(initialCameraPosition.target);
//     initialize();
//   }
//
//   void loadCurrentLocation() {
//     currentLocation.value = getCurrentLatLngFromGetStorage();
//   }
//
//   void loadCurrentAddress() {
//     currentAddress.value = getCurrentAddressFromGetStorage();
//   }
//
//   Future<void> onRouteEvent(e) async {
//     distanceRemaining = (await directions.getDistanceRemaining())!;
//     durationRemaining = (await directions.getDurationRemaining())!;
//
//     switch (e.eventType) {
//       case MapBoxEvent.progress_change:
//         var progressEvent = e.data as RouteProgressEvent;
//         arrived.value = progressEvent.arrived!;
//         if (progressEvent.currentStepInstruction != null) {
//           instruction.value = progressEvent.currentStepInstruction!;
//         }
//         break;
//       case MapBoxEvent.route_building:
//       case MapBoxEvent.route_built:
//         routeBuilt.value = true;
//         break;
//       case MapBoxEvent.route_build_failed:
//         routeBuilt.value = false;
//         break;
//       case MapBoxEvent.navigation_running:
//         isNavigating.value = true;
//         break;
//       case MapBoxEvent.on_arrival:
//         arrived.value = true;
//         if (!isMultipleStop) {
//           await Future.delayed(const Duration(seconds: 3));
//           await mapboxController.finishNavigation();
//         } else {}
//         break;
//       case MapBoxEvent.navigation_finished:
//       case MapBoxEvent.navigation_cancelled:
//         routeBuilt.value = false;
//         isNavigating.value = false;
//         break;
//       default:
//         break;
//
//     }
//   }
//
//   Future<void> initialize() async {
//     final cityhall =
//         WayPoint(name: "City Hall", latitude: 42.886448, longitude: -78.878372);
//     final downtown = WayPoint(
//         name: "Downtown Buffalo", latitude: 42.8866177, longitude: -78.8814924);
//     wayPoints.add(cityhall);
//     wayPoints.add(downtown);
//     controller.startNavigation(
//         options: MapBoxOptions(
//             initialLatitude: 36.1175275,
//             initialLongitude: -115.1839524,
//             zoom: 13.0,
//             tilt: 0.0,
//             bearing: 0.0,
//             enableRefresh: false,
//             alternatives: true,
//             voiceInstructionsEnabled: true,
//             bannerInstructionsEnabled: true,
//             allowsUTurnAtWayPoints: true,
//             mode: MapBoxNavigationMode.drivingWithTraffic,
//             // mapStyleUrlDay: "https://url_to_day_style",
//             // mapStyleUrlNight: "https://url_to_night_style",
//             units: VoiceUnits.imperial,
//             simulateRoute: true,
//             language: "en"));
//     controller.buildRoute(wayPoints: wayPoints);
//   }
// }
