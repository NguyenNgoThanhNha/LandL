// import 'dart:math';
//
// import 'package:flutter_mapbox_navigation/library.dart';
// import 'package:get/get.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:mobile/data/repositories/order/order_repository.dart';
// import 'package:mobile/features/service/models/order_model.dart';
// import 'package:mobile/utils/helpers/goong_handler.dart';
// import 'package:mobile/utils/helpers/network_manager.dart';
// import 'package:mobile/utils/popups/loaders.dart';
//
// class MapNavigationController extends GetxController {
//   static MapNavigationController get instance => Get.find();
//   final int id;
//   final currentLocation = const LatLng(0, 0).obs;
//   final currentAddress = ''.obs;
//   late CameraPosition initialCameraPosition;
//   OrderRepository orderRepository = Get.put(OrderRepository());
//
//   var distanceRemaining = 0.0.obs;
//   var durationRemaining = 0.0.obs;
//   var instruction = "".obs;
//   var arrived = false.obs;
//   var routeBuilt = false.obs;
//   var isNavigating = false.obs;
//
//   MapNavigationController({required this.id});
//   late MapBoxNavigation directions;
//   late MapBoxOptions options;
//   var wayPoints = <WayPoint>[].obs;
//
//   late MapBoxNavigationViewController controller;
//   final bool isMultipleStop = false;
//   Rx<OrderModel> order = OrderModel.empty().obs;
//   LatLng pickup = const LatLng(0, 0);
//   LatLng delivery = const LatLng(0, 0);
//   final loading = false.obs;
//
//   @override
//   void onInit() async{
//     super.onInit();
//     loading.value=true;
//     await getData();
//     pickup = LatLng(double.parse(order.value.deliveryInfoDetail.latPickUp),
//         double.parse(order.value.deliveryInfoDetail.longPickUp));
//     delivery = LatLng(double.parse(order.value.deliveryInfoDetail.latDelivery),
//         double.parse(order.value.deliveryInfoDetail.longDelivery));
//    await _getCurrentLocation();
//     await loadCurrentAddress();
// await initialize();
//
//     loading.value=false;
//   }
//
//   Future<void> _getCurrentLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//     currentLocation.value = LatLng(position.latitude, position.longitude);
//     print(currentLocation.value);
//   }
//   Future<void> loadCurrentAddress() async {
//     // currentAddress.value = getCurrentAddressFromGetStorage();
//     print(222222222);
//     currentAddress.value =
//     (await getParsedReverseGeocoding(currentLocation.value))['place'];
//     print(">>>>>>>>>>>>> ${currentAddress.value}");
//   }
//
//
//   Future<void> getData() async {
//     try {
//       print("Get data");
//       loading.value = true;
//       final isConnected = await NetworkManager.instance.isConnected();
//       if (!isConnected) {
//         TLoaders.errorSnackBar(
//             title: 'Network Error',
//             message: 'Please check your internet connection.');
//         loading.value = false;
//         return;
//       }
//       final response = await orderRepository.getData(id);
//       if (response != null) {
//         order.value = response;
//         print(response);
//         update();
//         loading.value = false;
//       }
//     } catch (e) {
//       loading.value = false;
//       TLoaders.errorSnackBar(title: 'Oh Snaps', message: e.toString());
//     }
//   }
//   Future<void> onRouteEvent(RouteEvent e) async {
//     distanceRemaining.value = await directions.distanceRemaining;
//     durationRemaining.value = await directions.durationRemaining;
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
//           await controller.finishNavigation();
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
//     print("Starting ...");
//     if (controller == null) {
//       print("Controller is not initialized yet.");
//       return;
//     }
//     directions = MapBoxNavigation(onRouteEvent: onRouteEvent);
//     options = MapBoxOptions(
//       zoom: 18.0,
//       voiceInstructionsEnabled: true,
//       bannerInstructionsEnabled: true,
//       mode: MapBoxNavigationMode.drivingWithTraffic,
//       isOptimized: true,
//       units: VoiceUnits.metric,
//       simulateRoute: true,
//       language: "en",
//     );
//
//     final cityhall =
//         WayPoint(name: "Pickup", latitude: pickup.latitude, longitude: pickup.longitude);
//     final downtown = WayPoint(
//         name: "Delivery", latitude: delivery.latitude, longitude: delivery.longitude);
//     wayPoints.add(cityhall);
//     wayPoints.add(downtown);
//     // controller.startNavigation(
//     //     options: MapBoxOptions(
//     //         initialLatitude: currentLocation.value.latitude,
//     //         initialLongitude:currentLocation.value.longitude,
//     //         zoom: 13.0,
//     //         tilt: 0.0,
//     //         bearing: 0.0,
//     //         enableRefresh: false,
//     //         alternatives: true,
//     //         voiceInstructionsEnabled: true,
//     //         bannerInstructionsEnabled: true,
//     //         allowsUTurnAtWayPoints: true,
//     //         mode: MapBoxNavigationMode.drivingWithTraffic,
//     //         // mapStyleUrlDay: "https://url_to_day_style",
//     //         // mapStyleUrlNight: "https://url_to_night_style",
//     //         units: VoiceUnits.imperial,
//     //         simulateRoute: true,
//     //         language: "en"));
//     // controller.buildRoute(wayPoints: wayPoints);
//     await directions.startNavigation(wayPoints: wayPoints, options: options);
//   }
//   void onMapCreated(MapBoxNavigationViewController controller) async {
//     this.controller = controller;
//     await initialize();
//     // Now controller is initialized
//     print("MapBox Controller initialized.");
//   }
// }
