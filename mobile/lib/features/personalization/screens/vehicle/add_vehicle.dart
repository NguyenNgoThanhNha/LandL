import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/commons/widgets/icons/rounded_icon.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';
import 'package:mobile/utils/validators/validation.dart';

class AddVehicleScreen extends StatelessWidget {
  const AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          'New Vehicle',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TRoundedIcon(
            icon: Icons.edit,
            backgroundColor: TColors.accent.withOpacity(0.2),
            color: Colors.black,
            onPressed: () => Get.to(() => const AddVehicleScreen()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    // controller: controller.fullName,
                    validator: (value) =>
                        TValidator.validateEmptyText('Type', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.type, prefixIcon: Icon(Iconsax.truck)),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                    // controller: controller.fullName,
                    validator: (value) =>
                        TValidator.validateEmptyText('Brand', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.brand,
                        prefixIcon: Icon(Iconsax.clipboard)),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                    // controller: controller.fullName,
                    validator: (value) =>
                        TValidator.validateEmptyText('Model', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.model,
                        prefixIcon: Icon(Iconsax.driver)),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                    // controller: controller.fullName,
                    validator: (value) =>
                        TValidator.validateEmptyText('Year', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.year,
                        prefixIcon: Icon(Iconsax.calendar)),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                    // controller: controller.fullName,
                    validator: (value) =>
                        TValidator.validateEmptyText('Model', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.color,
                        prefixIcon: Icon(Iconsax.barcode)),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                    // controller: controller.fullName,
                    validator: (value) =>
                        TValidator.validateEmptyText('Model', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.plate,
                        prefixIcon: Icon(Iconsax.document)),
                  ),
                  const SizedBox(
                    height: TSizes.spacebtwSections,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: (){},
                        child: const Text(TTexts.addVehicle)),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
