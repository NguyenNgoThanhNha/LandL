import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/features/service/controllers/home/home_controller.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';

class TBalance extends StatelessWidget {
  const TBalance({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final accountBalance = GetStorage().read("balance");
    final controller = HomeController.instance;
    return Container(
      padding: const EdgeInsets.all(TSizes.md),
      decoration: BoxDecoration(
          color: TColors.primary,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusSm)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TTexts.balanceTitle,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .apply(color: TColors.white),
          ),
          const SizedBox(
            height: TSizes.spacebtwItems / 2,
          ),
          Stack(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: TSizes.spacebtwSections * 1.4,
                  ),
                  Obx(() {
                    if (controller.hideBalance.value) {
                      return Text(
                        '******',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .apply(color: TColors.white),
                      );
                    } else {
                      return Text(accountBalance ?? "0.000",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .apply(
                                  color: TColors.white,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeightDelta: 600));
                    }
                  }),
                  const SizedBox(
                    width: TSizes.spacebtwItems / 2,
                  ),
                  Obx(
                    () => Center(
                        child: IconButton(
                      icon: Icon(controller.hideBalance.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye),
                      color: TColors.white,
                      onPressed: () => controller.hideBalance.value =
                          !controller.hideBalance.value,
                    )),
                  )
                ],
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  child: Text(
                    'VND',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .apply(color: TColors.white),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
