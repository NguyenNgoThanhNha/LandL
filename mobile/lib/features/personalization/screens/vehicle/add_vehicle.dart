import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/commons/widgets/icons/rounded_icon.dart';
import 'package:mobile/features/personalization/controllers/vehicle/add_vehicle_controller.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';
import 'package:mobile/utils/validators/validation.dart';

class AddVehicleScreen extends StatelessWidget {
  const AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddVehicleController(), permanent: false);
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(
          'New Vehicle',
          style: Theme
              .of(context)
              .textTheme
              .headlineMedium,
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
            child: TAddVehicleForm(controller: controller)),
      ),
    );
  }
}

class TAddVehicleForm extends StatelessWidget {
  const TAddVehicleForm({
    super.key,
    required this.controller,
  });

  final AddVehicleController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.vehicleKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.name,
            validator: (value) =>
                TValidator.validateEmptyText('Truck name', value),
            expands: false,
            decoration: const InputDecoration(
                labelText: 'Name', prefixIcon: Icon(Iconsax.clipboard)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            controller: controller.manufacturer,
            validator: (value) =>
                TValidator.validateEmptyText('Truck name', value),
            expands: false,
            decoration: const InputDecoration(
                labelText: 'Manufacturer', prefixIcon: Icon(Iconsax.clipboard)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            controller: controller.model,
            validator: (value) => TValidator.validateEmptyText('Model', value),
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.model, prefixIcon: Icon(Iconsax.driver)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Obx(() {
                  if (controller.listType.value == null) {
                    return const Text('....');
                  }
                  return DropdownButtonFormField<int>(
                      value: controller.type,
                      isDense: true,
                      dropdownColor: TColors.white,
                      decoration: const InputDecoration(
                        labelText: 'Type',
                        prefixIcon: Icon(Iconsax.truck),
                      ),
                      items: controller.listType.value
                          .map<DropdownMenuItem<int>>((dynamic item) {
                        return DropdownMenuItem<int>(
                          value: item['vehicleTypeId'],
                          child: Text(item['vehicleTypeName']),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        controller.type = newValue;
                      });
                }),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: controller.color,
                  validator: (value) =>
                      TValidator.validateEmptyText('Color', value),
                  decoration: const InputDecoration(
                    labelText: TTexts.color,
                    prefixIcon: Icon(Iconsax.barcode),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller.length,
                  validator: (value) =>
                      TValidator.validateEmptyText('Length', value),
                  decoration: const InputDecoration(
                    labelText: "Length",
                    prefixIcon: Icon(Iconsax.calendar),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller.width,
                  validator: (value) =>
                      TValidator.validateEmptyText('Width', value),
                  decoration: const InputDecoration(
                    labelText: "Width",
                    prefixIcon: Icon(Iconsax.barcode),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller.height,
                  validator: (value) =>
                      TValidator.validateEmptyText('Height', value),
                  decoration: const InputDecoration(
                    labelText: "Height",
                    prefixIcon: Icon(Iconsax.barcode),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
                "The unit of measurement is meter",
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall,
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields/2,
          ),
          TextFormField(
            controller: controller.plate,
            validator: (value) => TValidator.validateEmptyText('Plate', value),
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.plate, prefixIcon: Icon(Iconsax.document)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            controller: controller.loadCapacity,
            validator: (value) =>
                TValidator.validateEmptyText('Load Capacity', value),
            expands: false,
            decoration: const InputDecoration(
                labelText: "Load Capacity", prefixIcon: Icon(Iconsax.document)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            controller: controller.frameNumber,
            validator: (value) => TValidator.validateEmptyText('Frame', value),
            expands: false,
            decoration: const InputDecoration(
                labelText: "Frame Number", prefixIcon: Icon(Iconsax.document)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            controller: controller.engineNumber,
            validator: (value) => TValidator.validateEmptyText('Engine', value),
            expands: false,
            decoration: const InputDecoration(
                labelText: "Engine Number", prefixIcon: Icon(Iconsax.document)),
          ),
          const SizedBox(
            height: TSizes.spacebtwSections,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => controller.addVehicle(),
                child: const Text(TTexts.addVehicle)),
          ),
        ],
      )
      ,
    );
  }
}
