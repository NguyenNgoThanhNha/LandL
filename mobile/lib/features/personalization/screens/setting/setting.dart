import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/commons/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:mobile/commons/widgets/list_tiles/settings_menu_tile.dart';
import 'package:mobile/commons/widgets/list_tiles/user_profile_tile.dart';
import 'package:mobile/commons/widgets/texts/section_heading.dart';
import 'package:mobile/features/personalization/screens/contract/contract.dart';
import 'package:mobile/features/personalization/screens/profile/profile.dart';
import 'package:mobile/features/personalization/screens/vehicle/vehicle.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/utils/constants/text_strings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //header
            TPrimaryHeaderContainer(
                child: Column(
              children: [
                TAppbar(
                  title: Text(
                    'Account',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: TColors.white),
                  ),
                ),

                //user profile card
                TUserProfileTile(
                  onPressed: () => Get.to(() => const ProfileScreen()),
                ),
                const SizedBox(
                  height: TSizes.spacebtwSections,
                ),
              ],
            )),

            //body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  //Account settings
                  const TSectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spacebtwItems,
                  ),
                  const TSettingsMenuTile(
                    icon: Iconsax.bank,
                    title: TTexts.payment,
                    subTitle: TTexts.paymentSub,
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.document,
                    title: TTexts.contract,
                    subTitle: TTexts.contractSub,
                    onTap: () => Get.to(() => const ContractScreen()),
                  ),
                  TSettingsMenuTile(
                      icon: Iconsax.truck,
                      title: TTexts.vehicles,
                      onTap: () => Get.to(() => const VehicleScreen()),
                      subTitle: TTexts.vehiclesSub),
                  const TSettingsMenuTile(
                      icon: Iconsax.calendar,
                      title: TTexts.deliveryHistory,
                      subTitle: TTexts.deliveryHistorySub),
                  const TSettingsMenuTile(
                      icon: Iconsax.language_square,
                      title: TTexts.language,
                      subTitle: TTexts.languageSub),

                  const Divider(),
                  const SizedBox(
                    height: TSizes.spacebtwItems,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () => {},
                        // AuthenticationRepository.instance.logout(),
                        child: const Text('Logout')),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
