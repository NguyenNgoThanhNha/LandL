import 'package:mobile/commons/widgets/loader/animation_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) =>
          PopScope(
            canPop: false,
            child: Container(
              color: Colors.transparent,
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 250,
                  ),
                  TAnimationLoader(text: text, animation: animation)
                ],
              ),
            ),
          ),
    );
  }

  static void stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
