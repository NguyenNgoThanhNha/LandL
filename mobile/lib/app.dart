import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/features/authentication/screens/login.dart';
import 'package:mobile/utils/themes/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: const LoginScreen(),
    );
  }
}
