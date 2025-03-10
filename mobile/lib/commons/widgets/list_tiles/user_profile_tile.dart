import 'package:get_storage/get_storage.dart';
import 'package:mobile/commons/widgets/images/circular_image.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final deviceStorage = GetStorage();
    // final controller = UserController.instance;
    return ListTile(
      leading: const TCircularImage(
        image: TImages.avatar,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text(
        deviceStorage.read('username') ?? "",
        // controller.user.value.fullName,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TColors.white),
      ),
      subtitle: Text(
        deviceStorage.read('email') ?? "",
        // controller.user.value.email,
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Iconsax.edit,
          color: TColors.white,
        ),
      ),
    );
  }
}
