import 'package:mobile/commons/widgets/shimmer/shimmer.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCategoryShimmer extends StatelessWidget {
  const TCategoryShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, __) => const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TShimmerEffect(
                    width: 55,
                    height: 55,
                    radius: 55,
                  ),
                  SizedBox(
                    height: TSizes.spacebtwItems / 2,
                  ),
                  TShimmerEffect(width: 55, height: 8)
                ],
              ),
          separatorBuilder: (_, __) => const SizedBox(
                width: TSizes.defaultSpace,
              ),
          itemCount: itemCount),
    );
  }
}
