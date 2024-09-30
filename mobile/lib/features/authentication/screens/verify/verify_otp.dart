import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/widgets/otp/otp_widgets.dart';
import 'package:mobile/features/authentication/controllers/verify/verify_controller.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => VerifyController(email: email));
    final controller = VerifyController.instance;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Text(
                TTexts.verifyTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spacebtwItems,
              ),
              Text(
                email ?? "",
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spacebtwItems,
              ),
              Text(
                TTexts.verifySubTitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: TSizes.spacebtwSections,
              ),
              const OTPCode(),
              const SizedBox(
                height: TSizes.spacebtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.verify(),
                    child: const Text(TTexts.verificationCode)),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                TextButton(
                    onPressed: () => controller.resend(), child: const Text('Resend'))
              ])
            ],
          ),
        ),
      ),
    );
  }
}

class OTPCode extends StatelessWidget {
  const OTPCode({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = VerifyController.instance;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: OTPFields(
        pin1: controller.pin1,
        pin2: controller.pin2,
        pin3: controller.pin3,
        pin4: controller.pin4,
        pin5: controller.pin5,
        pin6: controller.pin6,
      ),
    );
  }
}
