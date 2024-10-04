import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/commons/widgets/icons/rounded_icon.dart';
import 'package:mobile/features/service/controllers/map/map_goong_controller.dart';
import 'package:mobile/features/service/controllers/order/order_controller.dart';
import 'package:mobile/features/service/models/order_model.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/text_strings.dart';

class MapGoongScreen extends StatelessWidget {
  const MapGoongScreen({super.key, required this.id});

  final int id;

  Future<String> loadMapStyle() async {
    return await rootBundle.loadString('assets/style/style.json');
  }

  @override
  Widget build(BuildContext context) {
    final mapController = Get.put(MapGoongController(id: id));
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        actions: [
          TRoundedIcon(
            icon: Icons.my_location_sharp,
            color: TColors.primary,
            onPressed: () => mapController.controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: mapController.currentLocation.value,
                  zoom: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: THelperFunctions.screenHeight(),
              child: FutureBuilder<String>(
                future: loadMapStyle(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return MapboxMap(
                      onMapCreated: mapController.onMapCreated,
                      accessToken:
                          "pk.eyJ1IjoiaGlldXNlcnZpY2VzIiwiYSI6ImNtMXA1bmh6MjAwbjUycXNicm1hdmJqNnkifQ.pULi1W0EzO_pMU2fHv0bVQ",
                      initialCameraPosition: CameraPosition(
                        target: mapController.currentLocation.value,
                        zoom: 16.0,
                      ),
                      styleString: MapboxStyles.MAPBOX_STREETS,
                      myLocationTrackingMode:
                          MyLocationTrackingMode.TrackingGPS,
                      onStyleLoadedCallback:
                          mapController.onStyleLoadedCallback,
                    );
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: TColors.primary,
                    ));
                  }
                },
              ),
            ),
            Obx(() {
              if (mapController.loading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: TColors.primary,
                  ),
                );
              }
              if (mapController.order.value.orderDetailId != 0) {
                return DraggableScrollableSheet(
                  initialChildSize: 0.15,
                  minChildSize: 0.10,
                  maxChildSize: 0.8,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: TColors.primaryBackground,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              TActionOnOrder(
                                orderController: mapController,
                                orderModel: mapController.order.value,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return const SizedBox();
            }),
            // Obx(() {
            //   if (mapController.order.value.status == 'Paid' ||
            //       mapController.order.value.status == 'InRoute') {
            //     return Positioned(
            //         top: TSizes.md,
            //         right: TSizes.md,
            //         child: TRoundedIcon(
            //           icon: Icons.play_circle,
            //           backgroundColor: TColors.white,
            //           onPressed: () => mapController.getDirectionToCustomer(false),
            //         ));
            //   }
            //   return const SizedBox();
            // })
          ],
        ),
      ),
    );
  }
}

class TActionOnOrder extends StatelessWidget {
  const TActionOnOrder({
    super.key,
    required this.orderController,
    required this.orderModel,
  });

  final MapGoongController orderController;
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    if (orderModel.status == "Processing") {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(backgroundColor: TColors.white),
              onPressed: () => Get.back(),
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
            onPressed: () => orderController.acceptOrder(
                orderModel.orderId.toString(),
                orderModel.orderDetailId.toString()),
            child: const Text(
              TTexts.accept,
            ),
          ))
        ],
      );
    }
    if (orderModel.status == "Paid") {
      return Column(
        children: [
          Text(
            'You are on your way to pick up the goods',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: TSizes.spacebtwItems,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => orderController.updateOrderStatus(
                      orderModel.orderDetailId.toString(), 4),
                  child: const Text(
                    'On Route',
                  ),
                ),
              )
            ],
          )
        ],
      );
    }
    if (orderModel.status == "InRoute") {
      return Column(
        children: [
          Text(
            'You already received a package!',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: TSizes.spacebtwItems,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => orderController.updateOrderStatus(
                      orderModel.orderDetailId.toString(), 5),
                  child: const Text(
                    'Start Delivery',
                  ),
                ),
              )
            ],
          )
        ],
      );
    }
    if (orderModel.status == "Received") {
      return Column(
        children: [
          Text(
            'You already take package for receiver!',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: TSizes.spacebtwItems,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => orderController.updateOrderStatus(
                      orderModel.orderDetailId.toString(), 6),
                  child: const Text(
                    'Finish Delivery',
                  ),
                ),
              )
            ],
          )
        ],
      );
    }
    if (orderModel.status == "Delivered") {
      return Column(
        children: [
          Text(
            'Successfully!',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: TSizes.spacebtwItems,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => orderController.updateOrderStatus(
                      orderModel.orderDetailId.toString(), 7),
                  child: const Text(
                    'Completed Order',
                  ),
                ),
              )
            ],
          )
        ],
      );
    }
    if (orderModel.status == "Completed") {
      return Column(
        children: [
          Text(
            'You already done!',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      );
    }
    if (orderModel.status == "InProcess") {
      return Column(
        children: [
          Text(
            'Waiting customer paying!',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      );
    }
    return const SizedBox();
  }
}
