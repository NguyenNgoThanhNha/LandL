import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/utils/constants/sizes.dart';

class TWarningAction extends StatelessWidget {
  const TWarningAction({
    super.key,
    required this.onPressed,
    required this.title,
    required this.subTitle,
  });

  final VoidCallback onPressed;
  final String title, subTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(TSizes.sm),
        decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: TSizes.spacebtwItems / 2,
                  ),
                  Text(
                    subTitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: TSizes.spacebtwItems / 2,
            ),
            const Icon(
              Iconsax.alarm,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
