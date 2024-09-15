import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/commons/widgets/icons/rounded_icon.dart';
import 'package:mobile/features/personalization/screens/vehicle/vehicle_detail.dart';
import 'package:mobile/features/service/screens/home/widgets/warning_action.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';

class VehicleScreen extends StatelessWidget {
  const VehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title:
            Text('Vehicles', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TRoundedIcon(
            icon: Icons.add,
            backgroundColor: TColors.accent.withOpacity(0.2),
            color: Colors.black,
            onPressed: () => Get.to(()=> const VehicleDetailScreen()),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            TWarningAction(
              onPressed: () {},
              title: TTexts.addVehicleTitle,
              subTitle: TTexts.addVehicleSubTitle,
            ),
          ],
        ),
      ),
    );
  }
}
