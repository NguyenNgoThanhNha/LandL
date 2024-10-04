import 'package:flutter/material.dart';
import 'package:mobile/utils/constants/colors.dart';
class TCircularLoader extends StatelessWidget {
  const TCircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: TColors.white,
    );
  }
}
