import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  const MapGoongScreen({super.key, required this.orderModel});

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    final mapController = Get.put(MapGoongController());
    final orderController = Get.find<OrderController>();
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        actions: [
          TRoundedIcon(
            icon: Icons.my_location_sharp,
            color: TColors.primary,
            onPressed: () => mapController.controller
                .animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                target: mapController.currentLocation.value,
                zoom: 14.0,
              ),
            )),
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: THelperFunctions.screenHeight(),
              child: MapboxMap(
                onMapCreated:(MapboxMapController controller) {
                  mapController.onMapCreated(controller);
                },
                accessToken:
                    "pk.eyJ1IjoiaGlldXNlcnZpY2VzIiwiYSI6ImNtMXI2dG8zajAxYXMya3NienRueGFpMTUifQ.u4hszGbs2HMsDty9tvv3wg",
                initialCameraPosition: CameraPosition(
                  target: LatLng(37.4219983, -122.084), // Tọa độ khởi tạo
                  zoom: 10.0, // Độ phóng to
                ),
                zoomGesturesEnabled: true,
                myLocationEnabled: true,
                trackCameraPosition: true,
                scrollGesturesEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                styleString: MapboxStyles.OUTDOORS,
                compassEnabled: true,
                onStyleLoadedCallback: () {
                  print("Map style loaded");
                },
                // onStyleLoadedCallback: mapController.onStyleLoadedCallback,
                minMaxZoomPreference: const MinMaxZoomPreference(3, 20),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.15,
              minChildSize: 0.10,
              maxChildSize: 0.8,
              builder:
                  (BuildContext context, ScrollController scrollController) {
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
                              orderController: orderController,
                              orderModel: orderModel),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
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

  final OrderController orderController;
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
    return const SizedBox(
      child: Text('Waiting customer paid'),
    );
  }
}
