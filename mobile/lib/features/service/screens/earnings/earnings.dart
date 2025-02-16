import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/commons/widgets/balance/balance.dart';
import 'package:mobile/features/service/controllers/earning/earning.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';
import 'package:mobile/utils/formatters/input_money.dart';
import 'package:mobile/utils/validators/validation.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EarningController());

    return Scaffold(
      appBar: TAppbar(
        title: Text(
          TTexts.earnings,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.w900),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            const TBalance(),
            const SizedBox(
              height: TSizes.defaultSpace,
            ),
            Text(
              "How much money would you like to withdraw?",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: TSizes.sm,
            ),
            Form(
                child: Column(
              children: [
                TextFormField(
                  controller: controller.quantity,
                  validator: (value) =>
                      TValidator.validateEmptyText("Quantity", value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.monetization_on_sharp),
                      labelText: TTexts.money),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                ),
                const SizedBox(
                  height: TSizes.sm,
                ),
                TextFormField(
                  controller: controller.description,
                  validator: (value) =>
                      TValidator.validateEmptyText("Description", value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.description),
                      labelText: TTexts.description),
                  maxLines: 2,
                ),
                const SizedBox(
                  height: TSizes.md,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.requestWithDraw(),
                      child: const Text(TTexts.request)),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
