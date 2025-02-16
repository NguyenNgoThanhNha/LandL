import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/features/personalization/controllers/bank_account/bank_account.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';
import 'package:mobile/utils/validators/validation.dart';

class AddBankAccount extends StatelessWidget {
  const AddBankAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BankAccountController());
    return Scaffold(
      appBar: TAppbar(
        title: Text(
          "Add bank account",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.w700),
        ),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Form(
          key: controller.bankAccountFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.fullName,
                validator: (value) =>
                    TValidator.validateEmptyText("Full Name", value),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user), labelText: TTexts.fullName),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                ],
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(
                height: TSizes.sm,
              ),
              TextFormField(
                controller: controller.bank,
                validator: (value) =>
                    TValidator.validateEmptyText("Bank Name", value),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.account_balance_rounded),
                    labelText: TTexts.bank),
              ),
              const SizedBox(
                height: TSizes.sm,
              ),
              TextFormField(
                controller: controller.number,
                validator: (value) =>
                    TValidator.validateEmptyText("Number", value),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.aquarius),
                    labelText: TTexts.number),
              ),
              const SizedBox(
                height: TSizes.sm,
              ),
              TextFormField(
                controller: controller.doe,
                validator: (value) =>
                    TValidator.validateEmptyText("Expire date", value),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.alarm), labelText: TTexts.doe),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(
                height: TSizes.md,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.createBankAccount(),
                    child: const Text(TTexts.createBankAccount)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
