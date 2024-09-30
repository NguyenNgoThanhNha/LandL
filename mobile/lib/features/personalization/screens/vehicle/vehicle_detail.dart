import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/features/personalization/controllers/vehicle/vehicle_detail_controller.dart';
import 'package:mobile/features/service/models/truck_model.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';

class VehicleDetailScreen extends StatelessWidget {
  const VehicleDetailScreen({super.key, required this.truck});

  final TruckModel truck;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VehicleDetailController(), permanent: false);
    return Scaffold(
      appBar: TAppbar(
        title: Text(truck.truckName),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TVehicleLine(title: "Name", content: truck.truckName),
                ),
                Expanded(
                  child: TVehicleLine(
                      title: TTexts.brand, content: truck.manufacturer),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spacebtwItems,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child:
                      TVehicleLine(title: TTexts.color, content: truck.color),
                ),
                Obx(() {
                  if (controller.listType.value != null) {
                    return Expanded(
                      child: TVehicleLine(
                          title: "Type",
                          content: controller.getTypeName(truck.vehicleTypeId)),
                    );
                  }
                  return const SizedBox();
                }),
              ],
            ),
            const SizedBox(
              height: TSizes.spacebtwItems,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TVehicleLine(
                      title: "Load Capacity", content: truck.loadCapacity),
                ),
                Expanded(
                  child: TVehicleLine(
                      title: TTexts.plate, content: truck.plateCode),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spacebtwItems,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TVehicleLine(
                      title: "Width",
                      content: "${truck.dimensionsWidth.toString()} m"),
                ),
                Expanded(
                  child: TVehicleLine(
                      title: "Length",
                      content: "${truck.dimensionsLength.toString()} m"),
                ),
                Expanded(
                  child: TVehicleLine(
                      title: "Height",
                      content: "${truck.dimensionsHeight.toString()} m"),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spacebtwItems,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TVehicleLine(
                      title: 'Engine Number', content: truck.engineNumber),
                ),
                Expanded(
                  child: TVehicleLine(
                      title: "Frame Number", content: truck.frameNumber),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spacebtwItems,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => controller.deleteTruck(),
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red)),
                    child: const Text(
                      'Remove',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(
                  width: TSizes.spacebtwItems,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () => controller.updateTruck(),
                        child: const Text('Edit'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TVehicleLine extends StatelessWidget {
  const TVehicleLine({
    super.key,
    required this.title,
    required this.content,
  });

  final String title, content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.w600)
                .apply(color: Colors.blueGrey)),
        const SizedBox(
          height: TSizes.spacebtwItems * 0.3,
        ),
        Text(content, style: Theme.of(context).textTheme.titleMedium)
      ],
    );
  }
}
