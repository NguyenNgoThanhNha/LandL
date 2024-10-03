import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/features/personalization/controllers/contract/contract_controller.dart';
import 'package:mobile/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';

class IdCardDetailScreen extends StatelessWidget {
  const IdCardDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContractController());

    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Obx(() {
                if (controller.loading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: TColors.primary,
                    ),
                  );
                } else if (controller.idCard.value != null) {
                  final info = controller.idCard?.value;
                  return Column(
                    children: [
                      TProfileMenu(
                          title: 'ID',
                          value: info?['id'] ?? "",
                          onPressed: () {}),
                      TProfileMenu(
                          title: 'Name',
                          value: info?['name'],
                          onPressed: () {}),
                      TProfileMenu(
                          title: 'DOB', value: info?['dob'], onPressed: () {}),
                      TProfileMenu(
                          title: 'Sex', value: info?['sex'], onPressed: () {}),
                      TProfileMenu(
                          title: 'Address',
                          value: info?['address'],
                          onPressed: () {}),
                      TProfileMenu(
                          title: 'Home',
                          value: info?['home'],
                          onPressed: () {}),
                      TProfileMenu(
                          title: 'Nationality',
                          value: info?['nationality'],
                          onPressed: () {}),
                      TProfileMenu(
                          title: 'Features',
                          value: info?['features'],
                          onPressed: () {}),
                    ],
                  );
                }
                return Center(
                  child: Text('No data'),
                );
              })),
        ));
  }
}
