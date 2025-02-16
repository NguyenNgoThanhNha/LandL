import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/commons/widgets/icons/rounded_icon.dart';
import 'package:mobile/features/personalization/controllers/bank_account/bank_account.dart';
import 'package:mobile/features/personalization/screens/bank_account/add_bank_accont.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';
import 'package:mobile/utils/helpers/helper_functions.dart';
import 'package:mobile/utils/validators/validation.dart';

class BankAccountScreen extends StatelessWidget {
  const BankAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BankAccountController());
    return Scaffold(
      appBar: TAppbar(
        title: Text(
          "Bank Account",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
        actions: [
          Obx(() {
            if (controller.isHasAccount.value) {
              return const SizedBox();
            }
            return TRoundedIcon(
              icon: Icons.add,
              backgroundColor: TColors.accent.withOpacity(0.2),
              color: Colors.black,
              onPressed: () => Get.to(() => const AddBankAccount()),
            );
          })
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Obx(() {
                if (controller.loading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: TColors.primary,
                    ),
                  );
                }
                if (!controller.isHasAccount.value) {
                  return const SizedBox();
                }

                return Container(
                  padding: const EdgeInsets.all(16),
                  width: THelperFunctions.screenWidth() * 0.8,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.user?.value?.bank! ?? "",
                        style:  const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text(controller.user?.value?.stk! ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .apply(
                                    color: TColors.white,
                                    letterSpacingFactor: 2.0)),
                      ),

                      const SizedBox(height: 10),
                      Text(controller.user?.value?.fullName! ?? "",
                          style:
                              Theme.of(context).textTheme.headlineSmall!.apply(
                                    color: TColors.white,
                                  )),

                      const SizedBox(height: 10),
                      // Text(
                      //   controller.user?.value.exp ?? "",
                      //   style: TextStyle(
                      //     color: Colors.white70,
                      //     fontSize: 16,
                      //   ),
                      // ),
                    ],
                  ),
                );
              })
            ],
          )),
    );
  }
}
