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

  runApp(const App());
}
