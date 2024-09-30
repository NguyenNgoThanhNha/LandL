import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/commons/widgets/balance/balance.dart';
import 'package:mobile/commons/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:mobile/commons/widgets/texts/section_heading.dart';
import 'package:mobile/features/personalization/screens/contract/contract.dart';
import 'package:mobile/features/personalization/screens/vehicle/vehicle.dart';
import 'package:mobile/features/service/controllers/home/home_controller.dart';
import 'package:mobile/features/service/screens/home/widgets/delivery_package.dart';
import 'package:mobile/features/service/screens/home/widgets/home_appbar.dart';
import 'package:mobile/features/service/screens/home/widgets/search_direction.dart';
import 'package:mobile/features/service/screens/home/widgets/warning_action.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';
import 'package:mobile/utils/helpers/helper_functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(HomeController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const THomeAppBar(),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    if (!controller.isUpdateVehicle.value &&
                        !controller.isUpdateIdCard.value) {
                      return Text(
                        TTexts.todo,
                        style: Theme.of(context).textTheme.bodyMedium,
                      );
                    }
                    return const SizedBox();
                  }),
                  const SizedBox(
                    height: TSizes.spacebtwItems,
                  ),
                  Obx(() {
                    if (!controller.isUpdateIdCard.value) {
                      return TWarningAction(
                        onPressed: () => Get.to(() => const ContractScreen()),
                        title: TTexts.identifyTitle,
                        subTitle: TTexts.identifySubTitle,
                      );
                    }
                    return const SizedBox();
                  }),
                  const SizedBox(
                    height: TSizes.spacebtwItems,
                  ),
                  Obx(() {
                    if (!controller.isUpdateVehicle.value) {
                      return TWarningAction(
                        onPressed: () => Get.to(() => const VehicleScreen()),
                        title: TTexts.addVehicleTitle,
                        subTitle: TTexts.addVehicleSubTitle,
                      );
                    }
                    return const SizedBox();
                  }),
                  const SizedBox(
                    height: TSizes.spacebtwItems,
                  ),
                  const TBalance(),
                  const SizedBox(
                    height: TSizes.spacebtwItems,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: TSizes.spacebtwItems,
                  ),
                  const TSearchDirection(),
                  Obx(() => TSectionHeading(
                        title: TTexts.availableReq,
                        buttonTitle: controller.isSearch.value
                            ? 'Clear all'
                            : 'View all',
                        onPressed: controller.isSearch.value
                            ? () => controller.isSearch.value = false
                            : () => {},
                      )),
                  Obx(() {
                    if (!controller.isUpdateVehicle.value &&
                        !controller.isUpdateIdCard.value) {
                      return TRoundedContainer(
                        backgroundColor: Colors.red.withOpacity(0.2),
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.spacebtwItems,
                            vertical: TSizes.defaultSpace),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.security_user,
                              size: 40,
                              color: Colors.redAccent,
                            ),
                            SizedBox(
                              height: TSizes.spacebtwItems,
                            ),
                            Text(TTexts.warningMessageNotUpdateInfo)
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  }),
                  const SizedBox(
                    height: TSizes.spacebtwItems,
                  ),
                  const TDeliveryPackage(),
                  const SizedBox(
                    height: TSizes.spacebtwItems,
                  ),
                  const TDeliveryPackage(),
                  const SizedBox(
                    height: TSizes.spacebtwItems,
                  ),
                  const TDeliveryPackage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
