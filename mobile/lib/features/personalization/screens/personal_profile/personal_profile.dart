import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/commons/widgets/texts/section_heading.dart';
import 'package:mobile/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:mobile/utils/constants/sizes.dart';

class PersonalProfileScreen extends StatelessWidget {
  const PersonalProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            const TSectionHeading(
              title: 'Profile Information',
              showActionButton: false,
            ),
            const SizedBox(
              height: TSizes.spacebtwItems,
            ),
            TProfileMenu(
              title: 'Name',
              value: "Hieu",
              onPressed: () {},
              // value: controller.user.value.fullName,
              // onPressed: () => Get.to(() => const ChangeName())
            ),
            TProfileMenu(
                title: 'Username ID', value: "hieub", onPressed: () {}),
            const SizedBox(
              height: TSizes.spacebtwItems,
            ),
            const Divider(),
            const SizedBox(
              height: TSizes.spacebtwItems,
            ),
            const TSectionHeading(
              title: 'Personal Information',
              showActionButton: false,
            ),
            const SizedBox(
              height: TSizes.spacebtwItems,
            ),
            TProfileMenu(
                title: 'User ID',
                // value: controller.user.value.id,
                icon: Iconsax.copy,
                value: '2857349',
                onPressed: () {}),
            TProfileMenu(
                title: 'E-mail',
                value: 'hieuttjob@gmail.com',
                // value: controller.user.value.email,
                onPressed: () {}),
            TProfileMenu(
                title: 'Phone Number',
                value: '039309283',
                // value: controller.user.value.phoneNumber,
                onPressed: () {}),
            TProfileMenu(title: 'Gender', value: 'Male', onPressed: () {}),
            TProfileMenu(
                title: 'Date of Birth', value: '8 Aug 2003', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
