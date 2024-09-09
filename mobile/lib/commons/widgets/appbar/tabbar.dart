import 'package:flutter/material.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/device/device_utility.dart';
import 'package:mobile/utils/helpers/helper_functions.dart';
class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  const TTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? TColors.black : Colors.white,
      child: TabBar(
          isScrollable: true,
          indicatorColor: TColors.primary,
          unselectedLabelColor: TColors.darkGrey,
          labelColor: THelperFunctions.isDarkMode(context)
              ? TColors.white
              : TColors.primary,
          tabs: tabs),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
