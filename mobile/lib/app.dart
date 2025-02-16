import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/bindings/general_bindings.dart';
import 'package:mobile/utils/constants/colors.dart';
import 'package:mobile/utils/constants/image_strings.dart';
import 'package:mobile/utils/themes/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      home: const Scaffold(
        backgroundColor: TColors.primary,
        body: Center(
          child: SizedBox(
            height: 250, // Set a specific height to center within
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center children vertically
              children: [
                Image(
                  image: AssetImage(TImages.lightAppLogo),
                  width: 150,
                ),
                SizedBox(height: 16), // Add some spacing between the logo and the indicator
                CircularProgressIndicator(
                  color: TColors.white,
                ),
              ],
            ),
          ),
        )

      ),
    );
  }
}
