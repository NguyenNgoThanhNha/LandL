import 'dart:async';
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mobile/data/repositories/order/order_repository.dart';
import 'package:mobile/features/service/models/order_model.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/constants/package_list.dart';
import 'package:mobile/utils/helpers/get_storage.dart';
import 'package:mobile/utils/helpers/goong_handler.dart';
import 'package:mobile/utils/helpers/network_manager.dart';
import 'package:mobile/utils/popups/full_screen_loader.dart';
import 'package:mobile/utils/popups/loaders.dart';

class MapGoongController extends GetxController {
  static MapGoongController get instance => Get.find();
  final int id;
  Rx<OrderModel> order = OrderModel.empty().obs;
  OrderRepository orderRepository = Get.put(OrderRepository());

  MapGoongController({required this.id});

  final loading = false.obs;
  final currentLocation = const LatLng(0, 0).obs;
  final currentAddress = ''.obs;
  late MapboxMapController controller;
  late List<CameraPosition> _kPackageList;
  List<Map> carouselData = [];
  StreamSubscription<Position>? positionStream;
  LatLng pickup = const LatLng(0, 0);
  LatLng delivery = const LatLng(0, 0);
  final isShowStart = false.obs;
  final isShowEnd = false;
  final isHidden = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await getData();
    pickup = LatLng(double.parse(order.value.deliveryInfoDetail.latPickUp),
        double.parse(order.value.deliveryInfoDetail.longPickUp));
    delivery = LatLng(double.parse(order.value.deliveryInfoDetail.latDelivery),
        double.parse(order.value.deliveryInfoDetail.longDelivery));
    await _getCurrentLocation();
    await loadCurrentAddress();
    _startTracking();
  }

  Future<void> getData() async {
    try {
      loading.value = true;
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TLoaders.errorSnackBar(
            title: 'Network Error',
            message: 'Please check your internet connection.');
        loading.value = false;
        return;
      }
      final response = await orderRepository.getData(id);
      if (response != null) {
        order.value = response;
        update();
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snaps', message: e.toString());
    }
  }

  Future<void> acceptOrder(String orderId, String orderDetailId) async {
    try {
      loading.value = true;
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
      }
      final response =
          await orderRepository.acceptOrder(orderId, orderDetailId);
      loading.value = false;
      if (response.success) {
        order.value = OrderModel.fromJson(response.result?.data);

        TLoaders.successSnackBar(
            title: "Accept Success!", message: "Order status update success!");
      } else {
        TLoaders.errorSnackBar(
            title: 'Accept Failed!', message: response.result?.message);
      }
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snaps', message: e.toString());
    }
  }

  Future<void> updateOrderStatus(String orderDetailId, int status) async {
    try {
      loading.value = false;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }
      final response =
          await orderRepository.updateStatusOrder(orderDetailId, status);
      loading.value = false;
      if (response.success) {
        order.value = OrderModel.fromJson(response.result?.data);

        TLoaders.successSnackBar(
            title: "Update Success!", message: "Order status update success!");
      } else {
        TLoaders.errorSnackBar(
            title: 'Accept Failed!', message: response.result?.message);
      }
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snaps', message: e.toString());
    }
  }

  PolylinePoints polylinePoints = PolylinePoints();

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentLocation.value = LatLng(position.latitude, position.longitude);
  }

  Future<void> _startTracking() async {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      currentLocation.value = LatLng(position.latitude, position.longitude);
    });
  }

  Future<void> loadPackages() async {
    for (int i = 0; i < packages.length; i++) {
      LatLng packageLatLng = LatLng(
          double.parse(packages[i]['coordinates']['latitude']),
          double.parse(packages[i]['coordinates']['longitude']));
      Map modifiedResponse =
          await getDirectionsAPIResponse(currentLocation.value, packageLatLng);
      saveDirectionsAPIResponse(i, json.encode(modifiedResponse));
    }
  }

  Future<void> loadCurrentLocation() async {
    currentLocation.value = getCurrentLatLngFromGetStorage();
    print(currentLocation.value);
  }

  Future<void> loadCurrentAddress() async {
    // currentAddress.value = getCurrentAddressFromGetStorage();
    currentAddress.value =
        (await getParsedReverseGeocoding(currentLocation.value))['place'];
    print(">>>>>>>>>>>>> ${currentAddress.value}");
  }

  void onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  onStyleLoadedCallback() async {
    await controller.addSymbol(
      SymbolOptions(
        geometry: pickup,
        iconSize: 1.4,
        iconImage: TImages.receivePackage,
      ),
    );
    await controller.addSymbol(
      SymbolOptions(
        geometry: delivery,
        iconSize: 1.4,
        iconImage: TImages.dropPackage,
      ),
    );
    await controller.addSymbol(
      SymbolOptions(
        geometry: currentLocation.value,
        iconSize: 1.6,
        iconImage: TImages.startHome,
      ),
    );
    getDirection(true);
  }

  Future<void> getDirection(bool removeLayer) async {
    if (controller != null) {
      controller.animateCamera(
        CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: getSouthwest(pickup, delivery),
              northeast: getNortheast(pickup, delivery),
            ),
            top: 20,
            right: 20),
      );
      var response = await getDirectionsAPIResponse(pickup, delivery);

      List<PointLatLng> result =
          polylinePoints.decodePolyline(response['route']);

      List<List<double>> coordinates =
          result.map((point) => [point.longitude, point.latitude]).toList();

      final _fills = {
        "type": "FeatureCollection",
        "features": [
          {
            "type": "Feature",
            "id": 0,
            "properties": <String, dynamic>{},
            "geometry": {"type": "LineString", "coordinates": coordinates}
          },
        ]
      };

      if (removeLayer == true) {
        await controller.removeLayer("lines");
        await controller.removeSource("fills");
      }

      await controller.addSource(
          "fills", GeojsonSourceProperties(data: _fills));
      await controller.addLineLayer(
          "fills",
          "lines",
          LineLayerProperties(
              lineColor: TColors.primary.toHexStringRGB(),
              lineCap: "round",
              lineJoin: "round",
              lineWidth: 6));
    }
  }

  Future<void> getDirectionToCustomer(bool removeLayer) async {
    if (controller != null) {
      controller.animateCamera(
        CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: getSouthwest(currentLocation.value, delivery),
              northeast: getNortheast(currentLocation.value, delivery),
            ),
            top: 20,
            right: 20),
      );
      var response =
          await getDirectionsAPIResponse(currentLocation.value, delivery);

      List<PointLatLng> result =
          polylinePoints.decodePolyline(response['route']);

      List<List<double>> coordinates =
          result.map((point) => [point.longitude, point.latitude]).toList();

      final _fills = {
        "type": "FeatureCollection",
        "features": [
          {
            "type": "Feature",
            "id": 0,
            "properties": <String, dynamic>{},
            "geometry": {"type": "LineString", "coordinates": coordinates}
          },
        ]
      };

      if (removeLayer == true) {
        await controller.removeLayer("lines");
        await controller.removeSource("fills");
      }

      await controller.addSource(
          "fills", GeojsonSourceProperties(data: _fills));
      await controller.addLineLayer(
          "fills",
          "lines",
          LineLayerProperties(
              lineColor: TColors.secondary.toHexStringRGB(),
              lineCap: "round",
              lineJoin: "round",
              lineWidth: 6));
    }
  }
}
