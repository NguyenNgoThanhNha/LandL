import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/commons/widgets/images/circular_image.dart';
import 'package:mobile/commons/widgets/texts/section_heading.dart';
import 'package:mobile/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = UserController.instance;
    // final controller = Get.put(UserController());
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  // Obx(() {
                  // final networkImage = controller.user.value.profilePicture;
                  // final image =
                  //     networkImage.isNotEmpty ? networkImage : TImages.avatar;

                  // return
                  const TCircularImage(image: TImages.avatar),
                  // controller.imageUploading.value
                  //     ? const TShimmerEffect(
                  //         width: 80,
                  //         height: 80,
                  //         radius: 80,
                  //       )
                  //     :
// TCircularImage(
//                             image: image,
//                             width: 80,
//                             height: 80,
//                             isNetworkImage: networkImage.isNotEmpty,
//                           );
//                   }),
                  TextButton(
                      onPressed: () {},
// => controller.uploadUserProfilePicture(),
                      child: const Text("Change Profile Picture"))
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spacebtwItems / 2,
            ),
            const Divider(),
            const SizedBox(
              height: TSizes.spacebtwItems,
            ),
            const TSectionHeading(
              title: 'Profile Information',
              showActionButton: false,
            ),
            const SizedBox(
              height: TSizes.spacebtwItems,
            ),
            TProfileMenu(title: 'Name', value: '', onPressed: () {}),
            TProfileMenu(title: 'Username ID', value: '', onPressed: () {}),
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
                value: '',
                icon: Iconsax.copy,
                onPressed: () {}),
            TProfileMenu(title: 'E-mail', value: '', onPressed: () {}),
            TProfileMenu(title: 'Phone Number', value: '', onPressed: () {}),
            TProfileMenu(title: 'Gender', value: 'Male', onPressed: () {}),
            TProfileMenu(
                title: 'Date of Birth', value: '8 Aug 2003', onPressed: () {}),
            const Divider(),
            const SizedBox(
              height: TSizes.spacebtwItems,
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Close Account',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: Colors.red),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
