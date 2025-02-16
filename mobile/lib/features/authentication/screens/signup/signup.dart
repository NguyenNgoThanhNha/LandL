import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/commons/widgets/authentication/form_divider.dart';
import 'package:mobile/commons/widgets/authentication/social_btn.dart';
import 'package:mobile/features/authentication/controllers/signup/signup_controller.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';
import 'package:mobile/utils/helpers/helper_functions.dart';
import 'package:mobile/utils/validators/validation.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Let\'s create your account',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spacebtwSections,
              ),
              const SignUpForm(),
              const SizedBox(
                height: TSizes.spacebtwSections,
              ),
              const FormDivider(dividerText: TTexts.signUpWith),
              const SizedBox(
                height: TSizes.spacebtwSections,
              ),
              const SocialBtn(),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController(), permanent: false);
    final dark = THelperFunctions.isDarkMode(context);
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.username,
            validator: (value) =>
                TValidator.validateEmptyText('Username', value),
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.username, prefixIcon: Icon(Iconsax.user)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            controller: controller.fullName,
            validator: (value) =>
                TValidator.validateEmptyText('Full name', value),
            decoration: const InputDecoration(
                labelText: TTexts.fullName,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            controller: controller.email,
            validator: (value) => TValidator.validateEmail(value),
            decoration: const InputDecoration(
                labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            controller: controller.birthDay,
            keyboardType: TextInputType.datetime,
            validator: (value) => TValidator.validateDate(value),
            decoration: const InputDecoration(
                labelText: TTexts.birthDay, prefixIcon: Icon(Iconsax.cake)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => TValidator.validatePhoneNumber(value),
            decoration: const InputDecoration(
                labelText: TTexts.phoneNumber, prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => TValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                  labelText: TTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value =
                          !controller.hidePassword.value,
                      icon: Icon(
                        controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye,
                      ))),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),
          Obx(
            () => TextFormField(
              controller: controller.confirmPassword,
              validator: (value) => TValidator.validatePassword(value),
              obscureText: controller.hideConfirmPassword.value,
              decoration: InputDecoration(
                  labelText: TTexts.confirmPassword,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                      onPressed: () => controller.hideConfirmPassword.value =
                          !controller.hideConfirmPassword.value,
                      icon: Icon(
                        controller.hideConfirmPassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye,
                      ))),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          TextFormField(
            controller: controller.city,
            validator: (value) => TValidator.validateEmptyText('City', value),
            decoration: const InputDecoration(
                labelText: TTexts.city, prefixIcon: Icon(Iconsax.building)),
          ),

          const SizedBox(
            height: TSizes.spacebtwSections,
          ),

          //Term
          const TermAndPolicy(),
          const SizedBox(
            height: TSizes.spacebtwSections,
          ),

          //Sign up Btn
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => controller.signup(),
                child: const Text(TTexts.createAccount)),
          ),
        ],
      ),
    );
  }
}

class TermAndPolicy extends StatelessWidget {
  const TermAndPolicy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(() => Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: (value) => controller.privacyPolicy.value =
                  !controller.privacyPolicy.value)),
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: TTexts.iAgreeTo,
                    style: Theme.of(context).textTheme.bodySmall),
                TextSpan(
                    text: TTexts.privacyPolicy,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? TColors.white : TColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor:
                            dark ? TColors.white : TColors.primary),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return Container(
                                padding:
                                    const EdgeInsets.all(TSizes.defaultSpace),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(TTexts.privacyPolicy),
                                    Text('Content detail')
                                  ],
                                ),
                              );
                            });
                      }),
                TextSpan(
                    text: ' and ',
                    style: Theme.of(context).textTheme.bodySmall),
                TextSpan(
                    text: TTexts.termOfUse,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? TColors.white : TColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor:
                            dark ? TColors.white : TColors.primary),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return Container(
                                padding:
                                    const EdgeInsets.all(TSizes.defaultSpace),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(TTexts.termOfUse),
                                    Text('Content detail')
                                  ],
                                ),
                              );
                            });
                      }),
              ],
            ),
            softWrap: true,
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(
          width: TSizes.spacebtwItems,
        )
      ],
    );
  }
}
