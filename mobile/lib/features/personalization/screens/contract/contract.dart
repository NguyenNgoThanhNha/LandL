import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/commons/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:mobile/commons/widgets/icons/rounded_icon.dart';
import 'package:mobile/features/personalization/controllers/contract/contract_controller.dart';
import 'package:mobile/features/personalization/controllers/upload_contract/upload_contract_controller.dart';
import 'package:mobile/features/personalization/screens/id_card_detail/id_card_detail.dart';
import 'package:mobile/features/personalization/screens/upload_contract/upload_contract.dart';
import 'package:mobile/features/personalization/screens/upload_driver_card/upload_driver_card.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';

class ContractScreen extends StatelessWidget {
  const ContractScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContractController());
    return Scaffold(
        appBar: TAppbar(
          showBackArrow: true,
          title: Text(
            TTexts.contract,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TRoundedIcon(
              icon: Iconsax.info_circle,
              color: Colors.black,
              onPressed: () {},
            )
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(children: [
              GestureDetector(
                  onTap: () => Get.to(() => Obx(() {
                        if (!controller.isHasIdCard.value) {
                          return const UploadContractScreen();
                        }
                        return const IdCardDetailScreen();
                      })),
                  child: TRoundedContainer(
                    backgroundColor: TColors.accent.withOpacity(0.3),
                    padding: const EdgeInsets.all(TSizes.sm),
                    child: Row(
                      children: [
                        const Image(image: AssetImage(TImages.idCard)),
                        const SizedBox(
                          width: TSizes.spacebtwItems,
                        ),
                        Expanded(
                            child: Text('Id Card',
                                style: Theme.of(context).textTheme.bodyMedium)),
                        Obx(() {
                          if (controller.isHasIdCard.value) {
                            return TRoundedIcon(
                              icon: Iconsax.verify,
                              color: Colors.blue,
                              size: 26,
                              onPressed: () =>
                                  Get.to(() => const IdCardDetailScreen()),
                              backgroundColor: Colors.transparent,
                            );
                          }
                          return const TRoundedIcon(
                            icon: Icons.warning_amber_outlined,
                            color: Colors.red,
                            size: 26,
                            backgroundColor: Colors.transparent,
                          );
                        })
                      ],
                    ),
                  )),
              const SizedBox(
                height: TSizes.spacebtwItems,
              ),
              GestureDetector(
                  onTap: () => Get.to(() => const UploadDriverCardScreen()),
                  child: TRoundedContainer(
                    backgroundColor: TColors.accent.withOpacity(0.3),
                    padding: const EdgeInsets.all(TSizes.sm),
                    child: Row(
                      children: [
                        const Image(image: AssetImage(TImages.licenceCard)),
                        const SizedBox(
                          width: TSizes.spacebtwItems,
                        ),
                        Expanded(
                            child: Text('Licence Card',
                                style: Theme.of(context).textTheme.bodyMedium)),
                        Obx(() {
                          if (controller.isHasDriverCard.value) {
                            return const TRoundedIcon(
                              icon: Iconsax.verify,
                              color: Colors.blue,
                              size: 26,
                              backgroundColor: Colors.transparent,
                            );
                          }
                          return const TRoundedIcon(
                            icon: Icons.warning_amber_outlined,
                            color: Colors.red,
                            size: 26,
                            backgroundColor: Colors.transparent,
                          );
                        })
                      ],
                    ),
                  )),
            ])));
  }
}
