import 'package:iconsax/iconsax.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/commons/widgets/images/circular_image.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:mobile/utils/helpers/helper_functions.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    // final controller = Get.put(UserController());
    return TAppbar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TTexts.loginTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: dark ? TColors.white : TColors.black),
          ),
          // Obx(() {
          //   if (controller.profileLoading.value) {
          //     return const TShimmerEffect(width: 80, height: 15);
          //   } else {
          //     return
          Text(
            // controller.user.value.fullName,
            "Hieu",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: dark ? TColors.white : TColors.black),
            // )
            // ;
            // }
            // }
          ),
        ],
      ),
      actions: [
        TNotificationIcon(
            onPressed: () {}, iconColor: dark ? TColors.white : Colors.black),
        GestureDetector(
          onTap: () {},
          child: const TCircularImage(image: TImages.avatar),
        )
      ],
    );
  }
}

class TNotificationIcon extends StatelessWidget {
  const TNotificationIcon(
      {super.key, required this.onPressed, required this.iconColor});

  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      IconButton(
          onPressed: onPressed,
          icon: Icon(
            Iconsax.notification,
            color: iconColor,
            size: 30,
          )),
      Positioned(
        right: 7,
        child: Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
              color: TColors.primary, borderRadius: BorderRadius.circular(100)),
          child: Center(
            child: Text(
              '2',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(color: TColors.white, fontSizeFactor: 0.8),
            ),
          ),
        ),
      ),
    ]);
  }
}
