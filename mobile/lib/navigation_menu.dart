import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mobile/features/personalization/screens/setting/setting.dart';
import 'package:mobile/features/service/screens/earnings/earnings.dart';
import 'package:mobile/features/service/screens/home/home.dart';
import 'package:mobile/features/service/screens/manage_delivery/manage_delivery.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.black : Colors.white,
          indicatorColor: darkMode
              ? TColors.white.withOpacity(0.1)
              : TColors.primary.withOpacity(0.3),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Iconsax.calendar), label: 'Delivery'),
            NavigationDestination(
                icon: Icon(Iconsax.money_recive4), label: 'Earnings'),
            NavigationDestination(icon: Icon(Iconsax.setting_2), label: 'Setting'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const ManageDeliveryScreen(),
    const EarningsScreen(),
    const SettingsScreen()
  ];
}
