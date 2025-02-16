import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/commons/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:mobile/commons/widgets/icons/rounded_icon.dart';
import 'package:mobile/features/personalization/controllers/vehicle/vehicle_controller.dart';
import 'package:mobile/features/personalization/screens/vehicle/add_vehicle.dart';
import 'package:mobile/features/personalization/screens/vehicle/vehicle_detail.dart';
import 'package:mobile/features/service/screens/home/widgets/warning_action.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';

class VehicleScreen extends StatelessWidget {
  const VehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VehicleController(), permanent: false);

    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title:
            Text('Vehicles', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
    Obx(() {
      if (controller.truck.value == null) {
        return   TRoundedIcon(
            icon: Icons.add,
            backgroundColor: TColors.accent.withOpacity(0.2),
            color: Colors.black,
            onPressed: () =>  Get.to(() => const AddVehicleScreen())
        );}
      return const SizedBox();
    })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            Obx(() {
              if (controller.truck.value == null) {
                return TWarningAction(
                  onPressed: () {},
                  title: TTexts.addVehicleTitle,
                  subTitle: TTexts.addVehicleSubTitle,
                );
              } else {
                final truck = controller.truck.value;
                return TRoundedContainer(
                  backgroundColor: TColors.accent.withOpacity(0.5),
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.sm, vertical: TSizes.sm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        truck!.truckName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Spacer(),
                      TRoundedIcon(
                        icon: Iconsax.arrow_right_34,
                        backgroundColor: Colors.transparent,
                        color: TColors.black,
                        onPressed: () =>
                            Get.to(() => VehicleDetailScreen(truck: truck)),
                      )
                    ],
                  ),
                );
              }
            })

            //
          ],
        ),
      ),
    );
  }
}
