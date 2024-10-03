import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/widgets/appbar/appbar.dart';
import 'package:mobile/commons/widgets/appbar/tabbar.dart';
import 'package:mobile/features/service/controllers/manage_delivery/manage_delivery_controller.dart';
import 'package:mobile/features/service/screens/manage_delivery/widgets/status_tab.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/constants/text_strings.dart';
import 'package:mobile/utils/helpers/helper_functions.dart';

class ManageDeliveryScreen extends StatelessWidget {
  const ManageDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ManageDeliveryController());
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: TAppbar(
            title: Text(
              TTexts.manageDelivery,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          body: NestedScrollView(
            body: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Obx(() => TabBarView(
                children: [
                  TStatusTab(items: controller.listProcessingOrder.value),
                  TStatusTab(items: controller.listCompletedOrder.value),
                  TStatusTab(items: controller.listCancelOrder.value),
                ],
              )),
            ),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: true,
                    expandedHeight: 0,
                    flexibleSpace: const Padding(
                      padding: EdgeInsets.all(TSizes.defaultSpace),
                    ),
                    backgroundColor: THelperFunctions.isDarkMode(context)
                        ? TColors.black
                        : TColors.white,
                    bottom: TTabBar(
                        tabs: ['Processing', 'Completed', 'Cancel']
                            .map((category) => Tab(child: Text(category)))
                            .toList()))
              ];
            },
          ),
        ));
  }
}
