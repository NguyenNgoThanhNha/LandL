import 'package:flutter/material.dart';
import 'package:mobile/features/service/models/order_driver_model.dart';
import 'package:mobile/features/service/screens/manage_delivery/widgets/package_total.dart';
import 'package:mobile/utils/constants/sizes.dart';

class TStatusTab extends StatelessWidget {
  const TStatusTab({super.key, required this.items});

  final List<OrderTotalModel> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('Do not have any order here!!'));
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final order = items[index];
        return TPackageTotal(order: order);
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: TSizes.spacebtwItems,
      ),
      itemCount: items.length,
    );
  }
}
