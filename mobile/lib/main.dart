import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/app.dart';
import 'package:mobile/data/repositories/authentication/authentication_repository.dart';
import 'package:mobile/features/splash/controller/splash_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await dotenv.load(fileName: "assets/config/.env");

  Get.put(SplashController());
  Get.put(AuthenticationRepository());
  HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) =>
              true; // Chấp nhận mọi chứng chỉ
  }
}
