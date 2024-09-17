import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/constants/package_list.dart';
import 'package:mobile/utils/helpers/get_storage.dart';
import 'package:mobile/utils/helpers/goong_handler.dart';
import 'package:mobile/utils/requests/goong/direction.dart';

class MapGoongController extends GetxController {
  static MapGoongController get instance => Get.find();

  final currentLocation = const LatLng(0, 0).obs;
  final currentAddress = ''.obs;
  late CameraPosition initialCameraPosition;
  late MapboxMapController controller;
  late List<CameraPosition> _kPackageList;
  List<Map> carouselData = [];
  StreamSubscription<Position>? positionStream;

  // CircleAnnotationManager? _circleAnnotationManagerStart;
  // CircleAnnotationManager? _circleAnnotationManagerEnd;

  final isShowStart = false.obs;
  final isShowEnd = false;
  final isHidden = true.obs;

  // 10.844821, 106.761512
  LatLng d1 = const LatLng(10.7791, 106.6828);

  @override
  void onInit() {
    super.onInit();
    // loadCurrentLocation();

    _getCurrentLocation();
    loadCurrentAddress();
    initialCameraPosition =
        CameraPosition(target: currentLocation.value, zoom: 14);
    _startTracking();
  }

  PolylinePoints polylinePoints = PolylinePoints();

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentLocation.value = LatLng(position.latitude, position.longitude);
  }

  void _startTracking() {
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

  void loadCurrentLocation() {
    currentLocation.value = getCurrentLatLngFromGetStorage();
  }

  void loadCurrentAddress() async {
    // currentAddress.value = getCurrentAddressFromGetStorage();
    currentAddress.value =
        (await getParsedReverseGeocoding(currentLocation.value))['place'];
  }

  void onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  _addSourceAndLineLayer(int index, bool removeLayer) async {
    controller
        .animateCamera(CameraUpdate.newCameraPosition(_kPackageList[index]));

    Map geometry = getGeometryFromStorage(carouselData[index]['index']);
    final _fills = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "id": 0,
          "properties": <String, dynamic>{},
          "geometry": geometry,
        },
      ]
    };

    if (removeLayer == true) {
      await controller.removeLayer("lines");
      await controller.removeSource("fills");
    }

    await controller.addSource("fills", GeojsonSourceProperties(data: _fills));
    await controller.addLineLayer(
        "fills",
        "lines",
        LineLayerProperties(
            lineColor: Colors.pink.toHexStringRGB(),
            lineCap: "round",
            lineJoin: "round",
            lineWidth: 4));
  }

  onStyleLoadedCallback() async {
    await controller.addSymbol(
      SymbolOptions(
        geometry: d1,
        iconSize: 0.2,
        iconImage: TImages.package,
      ),
    );
    getDirection(true);
  }

  void getDirection(bool removeLayer) async {
    if (controller != null) {
      controller.animateCamera(
        CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: getSouthwest(d1, currentLocation.value),
              northeast: getNortheast(d1, currentLocation.value),
            ),
            top: 20,
            right: 20),
      );
      var response = await getDirectionsAPIResponse(currentLocation.value, d1);

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
              lineWidth: 4));
    }
  }

// void addLineToMap(MapboxMapController mapController, String geojson) async {
//   // Thêm GeoJsonSource và LineLayer vào bản đồ
//   await addLineLayer(mapController, geojson);
//   isHidden.value = false;
//   // setState(() {
//   //   isHidden = false;
//   // });
// }
//
// Future<void> addLineLayer(
//     MapboxMapController mapController, String geojson) async {
//   // Thêm GeoJsonSource
//   await mapController.addSource(
//       "line_source", GeojsonSourceProperties(data: geojson));
//
//   // Thêm LineLayer
//   await mapController.addLineLayer(
//     "line_source", // Nguồn dữ liệu GeoJSON
//     "line_layer", // ID của layer
//     const LineLayerProperties(
//       lineJoin: "round",
//       lineCap: "round",
//       lineColor: "#3333FF", // Màu đường
//       lineWidth: 9.0, // Độ rộng của đường
//     ),
//   );
// }
}
