import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/constants/package_list.dart';
import 'package:mobile/utils/helpers/get_storage.dart';
import 'package:mobile/utils/helpers/mapbox_handler.dart';

class MapController extends GetxController {
  static MapController get instance => Get.find();

  final currentLocation = const LatLng(0, 0).obs;
  final currentAddress = ''.obs;
  late CameraPosition initialCameraPosition;
  late MapboxMapController controller;
  late List<CameraPosition> _kPackageList;
  List<Map> carouselData = [];

  // 10.844821, 106.761512

  @override
  void onInit() {
    super.onInit();
    loadCurrentLocation();
    loadCurrentAddress();
    initialCameraPosition =
        CameraPosition(target: currentLocation.value, zoom: 14);
    loadPackages();

    for (int index = 0; index < packages.length; index++) {
      // num distance = get(index) / 1000;
      // num duration = getDurationFromSharedPrefs(index) / 60;
      carouselData.add({'index': index});
    }
    carouselData.sort((a, b) => a['index'] < b['index'] ? 0 : 1);
    _kPackageList = List<CameraPosition>.generate(
        packages.length,
        (index) => CameraPosition(
            target: LatLng(
                double.parse(packages[index]['coordinates']['latitude']),
                double.parse(packages[index]['coordinates']['longitude'])),
            zoom: 15));


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

  void loadCurrentAddress() {
    currentAddress.value = getCurrentAddressFromGetStorage();
  }

  void onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  _addSourceAndLineLayer(int index, bool removeLayer) async {
    // Can animate camera to focus on the item
    controller
        .animateCamera(CameraUpdate.newCameraPosition(_kPackageList[index]));

    // Add a polyLine between source and destination
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

    // Remove lineLayer and source if it exists
    if (removeLayer == true) {
      await controller.removeLayer("lines");
      await controller.removeSource("fills");
    }

    // Add new source and lineLayer
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
    for (CameraPosition _kPackage in _kPackageList) {
      await controller.addSymbol(
        SymbolOptions(
          geometry: _kPackage.target,
          iconSize: 0.2,
          iconImage: TImages.avatar,
        ),
      );
    }
    _addSourceAndLineLayer(0, false);
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
  }
}
