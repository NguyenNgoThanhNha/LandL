import 'package:flutter/material.dart';
import 'package:mobile/utils/constants/sizes.dart';

class TProfileElement extends StatelessWidget {
  const TProfileElement({
    super.key,
    required this.title,
    required this.value,
  });

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.spacebtwItems / 2),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              )),
          Expanded(
              flex: 5,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                // overflow: TextOverflow.ellipsis,
              )),
        ],
      ),
    );
  }
}
