import 'package:flutter/material.dart';
import 'package:mobile/commons/widgets/layouts/grid_layout.dart';
import 'package:mobile/features/service/screens/home/widgets/delivery_package.dart';
import 'package:mobile/utils/constants/sizes.dart';
class TStatusTab extends StatelessWidget {
  const TStatusTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                //Brand

                TGridLayout(
                    itemCount: 8,
                    itemBuilder: (_, index) => const TDeliveryPackage())
              ],
            ),
          ),
        ]);
  }
}
