import 'package:mobile/utils/constants/sizes.dart';
import 'package:mobile/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TRoundedIcon extends StatelessWidget {
  const TRoundedIcon(
      {super.key,
      this.height,
      this.width,
      this.size = TSizes.lg,
      required this.icon,
      this.color,
      this.backgroundColor,
      this.onPressed});

  final double? height, width, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ??
            (dark
                ? Colors.black.withOpacity(0.9)
                : Colors.white.withOpacity(0.9)),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color,
          size: size,
        ),
      ),
    );
  }
}
