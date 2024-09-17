import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mobile/features/authentication/screens/onboarding/onboarding.dart';
import 'package:mobile/utils/helpers/goong_handler.dart';

class SplashController extends GetxController {
  static SplashController get instance => Get.find();


  @override
  void onInit() {
    super.onInit();
    initializeLocationAndSave();
  }

  void initializeLocationAndSave() async {
    Location location = Location();
    bool? serviceEnabled;
    PermissionStatus? permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    if (permissionGranted == PermissionStatus.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    LocationData locationData = await location.getLocation();
    LatLng currentLocation =
        LatLng(locationData.latitude!, locationData.longitude!);
    String currentAddress =
        (await getParsedReverseGeocoding(currentLocation))['place'];

    final box = GetStorage();
    box.write('latitude', locationData.latitude!);
    box.write('longitude', locationData.longitude!);
    box.write('current-address', currentAddress);
    print(">>>>>>>>>>>>>>>>>>>>>>>>currentAddress $currentAddress" );
    

    Get.offAll(() => const OnboardingScreen());
  }
}
