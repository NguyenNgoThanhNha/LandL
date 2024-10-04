import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/commons/widgets/icons/rounded_icon.dart';
import 'package:mobile/features/service/controllers/home/home_controller.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';
import 'package:mobile/utils/validators/validation.dart';

class TSearchDirection extends StatelessWidget {
  const TSearchDirection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return Column(
      children: [
        Text(
          TTexts.directionTo,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: TSizes.spacebtwItems / 2,
        ),
        Form(
            child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller.directionTo,
                validator: (value) =>
                    TValidator.validateEmptyText('DirectionTo', value),
                decoration: InputDecoration(
                    labelText: TTexts.placeholderDirectionTo,
                    labelStyle: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: TColors.black.withOpacity(0.5)),
                    floatingLabelStyle: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: Colors.transparent),
                    prefixIcon: const Icon(
                      Iconsax.direct_right,
                      color: TColors.grey,
                    )),
              ),
            ),
            const SizedBox(
              width: TSizes.spacebtwItems / 2,
            ),
            TRoundedIcon(
              icon: Iconsax.search_normal,
              color: TColors.white,
              onPressed: () => controller.onSearch(),
              backgroundColor: TColors.primary.withOpacity(0.9),
            )
          ],
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: Text('Get location',
                  style: Theme.of(context).textTheme.titleSmall),
              onPressed: () => controller.getLocation(),
            ),
          ],
        )
      ],
    );
  }
}
