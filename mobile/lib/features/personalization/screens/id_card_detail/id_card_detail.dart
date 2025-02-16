import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/commons/widgets/list_tiles/profile_element.dart';
import 'package:mobile/features/personalization/controllers/contract/contract_controller.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';

class IdCardDetailScreen extends StatelessWidget {
  const IdCardDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContractController());
    controller.getInforId();
    return Scaffold(
        appBar: TAppbar(
          title: Text(
            "ID Information",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          showBackArrow: true,
        ),
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
                      TProfileElement(
                        title: 'ID',
                        value: info?['id'] ?? "",
                      ),
                      TProfileElement(
                        title: 'Name',
                        value: info?['name'],
                      ),
                      TProfileElement(
                        title: 'DOB',
                        value: info!['dob'].toString().substring(0, 10),
                      ),
                      TProfileElement(
                        title: 'Sex',
                        value: info?['sex'],
                      ),
                      TProfileElement(
                        title: 'Address',
                        value: info?['address'],
                      ),
                      TProfileElement(
                        title: 'Home',
                        value: info?['home'],
                      ),
                      TProfileElement(
                        title: 'Nationality',
                        value: info?['nationality'],
                      ),
                      TProfileElement(
                        title: 'Features',
                        value: info?['features'],
                      ),
                    ],
                  );
                }
                return const Center(
                  child: Text('No data'),
                );
              })),
        ));
  }
}
