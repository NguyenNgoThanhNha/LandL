import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/utils/constants/sizes.dart';

class UploadContractScreen extends StatelessWidget {
  const UploadContractScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.cardRadiusLg * 4,
                          vertical: TSizes.cardRadiusLg * 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey)),
                      child: const Icon(
                        Iconsax.camera,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spacebtwSections,
                    ),
                    const Text('Upload Card Front')
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.cardRadiusLg * 4,
                          vertical: TSizes.cardRadiusLg * 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey)),
                      child: const Icon(
                        Iconsax.camera,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      height: TSizes.spacebtwSections,
                    ),
                    const Text('Upload Card Back')
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Done'),
            ),
          )
        ]),
      ),
    );
  }
}
