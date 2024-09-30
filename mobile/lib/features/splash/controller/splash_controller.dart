import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart' as loc;
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mobile/features/authentication/screens/login/login.dart';
import 'package:mobile/features/authentication/screens/onboarding/onboarding.dart';
import 'package:mobile/utils/helpers/goong_handler.dart';
import 'package:permission_handler/permission_handler.dart' as per;

class SplashController extends GetxController {
  static SplashController get instance => Get.find();

  final box = GetStorage();

  @override
  void onInit() {
    requestCameraPermission();
    initializeLocationAndSave();
    super.onInit();
  }



  void initializeLocationAndSave() async {
    loc.Location location = loc.Location();
    bool? serviceEnabled;
    loc.PermissionStatus? permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) return;
    }

    if (permissionGranted == loc.PermissionStatus.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    loc.LocationData locationData = await location.getLocation();
    LatLng currentLocation =
        LatLng(locationData.latitude!, locationData.longitude!);
    String currentAddress =
        (await getParsedReverseGeocoding(currentLocation))['place'];

    box.write('latitude', locationData.latitude!);
    box.write('longitude', locationData.longitude!);
    print('${locationData.latitude!} - ${locationData.longitude!}');
    box.write('current-address', currentAddress);
    box.writeIfNull('isUpdateIdCard', false);
    box.writeIfNull('isUpdateVehicle', false);
    print(">>>>>>>>>>>>>>>>>>>>>>>>currentAddress $currentAddress");

  }

  void requestCameraPermission() async {
    per.PermissionStatus status = await per.Permission.camera.status;
    if (status.isDenied) {
      status = await per.Permission.camera.request();
      if (status.isDenied) {
        return;
      }
    }
    if (status.isPermanentlyDenied) {
      per.openAppSettings();
      return Future.error('Camera permissions are permanently denied');
    }

    per.PermissionStatus statusStorage = await per.Permission.storage.status;
    if (statusStorage.isDenied) {
      statusStorage = await per.Permission.storage.request();
      if (statusStorage.isDenied) {
        return;
      }
    }
    if (statusStorage.isPermanentlyDenied) {
      per.openAppSettings();
      return Future.error('Storage permissions are permanently denied');
    }
  }
}
