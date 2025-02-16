import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/commons/widgets/list_tiles/profile_element.dart';
import 'package:mobile/features/personalization/controllers/contract/contract_controller.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';

class DriverCardScreen extends StatelessWidget {
  const DriverCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContractController());
    controller.getDriverInfoId();
    return Scaffold(
        appBar: TAppbar(
          title: Text(
            "Driver License Information",
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
                }
                if (controller.isLicense.value == null) {
                  const Center(
                    child: Text('No data'),
                  );
                }
                final info = controller.isLicense.value;
                return Column(
                  children: [
                    TProfileElement(
                      title: 'ID',
                      value: info?['id'] ?? "",
                    ),
                    TProfileElement(
                      title: 'Class',
                      value: info?['classLicense'] ?? "",
                    ),
                    TProfileElement(
                      title: 'Name',
                      value: info?['name'] ?? "",
                    ),
                    TProfileElement(
                      title: 'DOB',
                      value: info!['dob'].toString().substring(0, 10),
                    ),
                    TProfileElement(
                      title: 'Address',
                      value: info?['address'] ?? "",
                    ),
                    TProfileElement(
                      title: 'Nationality',
                      value: info?['nation'] ?? "",
                    ),
                    TProfileElement(
                      title: 'Expire at',
                      value: info?['doe'] ?? "",
                    ),
                  ],
                );
              })),
        ));
  }
}
