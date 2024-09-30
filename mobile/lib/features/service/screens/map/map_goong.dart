import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/commons/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:mobile/features/service/controllers/map/map_goong_controller.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/text_strings.dart';

class MapGoongScreen extends StatelessWidget {
  const MapGoongScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mapController = Get.put(MapGoongController());
    return Scaffold(
      appBar: const TAppbar(
        showBackArrow: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: THelperFunctions.screenHeight(),
              child: MapboxMap(
                onMapCreated: mapController.onMapCreated,
                accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
                initialCameraPosition: mapController.initialCameraPosition,
                zoomGesturesEnabled: true,
                myLocationEnabled: true,
                trackCameraPosition: true,
                scrollGesturesEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                styleString: MapboxStyles.OUTDOORS,
                compassEnabled: true,
                onStyleLoadedCallback: mapController.onStyleLoadedCallback,
                minMaxZoomPreference: const MinMaxZoomPreference(3, 20),
              ),
            ),
            Positioned(
              bottom: 5,
              width: THelperFunctions.screenWidth(),
              child: TRoundedContainer(
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide.none,
                                  backgroundColor: TColors.white),
                              onPressed: () {},
                              child: const Text(
                                TTexts.reject,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: TSizes.spacebtwItems,
                          ),
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              TTexts.accept,
                            ),
                          ))
                        ],
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => mapController.controller
            .animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: mapController.currentLocation.value,
            zoom: 14.0,
          ),
        )),
        child: const Icon(
          Icons.my_location_sharp,
          color: TColors.primary,
        ),
      ),
    );
  }
}
