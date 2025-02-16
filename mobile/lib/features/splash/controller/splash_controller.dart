import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mobile/utils/helpers/goong_handler.dart';
import 'package:permission_handler/permission_handler.dart' as per;

class SplashController extends GetxController {
  static SplashController get instance => Get.find();

  final box = GetStorage();

  @override
  void onInit() async {
    super.onInit();
    await getCurrentLocation();
    await requestCameraPermission();
  }
  Future<void> getCurrentLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle accordingly
      return;
    }

    // Request location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    LatLng currentLocation = LatLng(position.latitude, position.longitude);

    // Use your existing function to reverse geocode the location
    String currentAddress = (await getParsedReverseGeocoding(currentLocation))['place'];

    // Store the location and address in local storage
    GetStorage box = GetStorage();
    box.write('latitude', position.latitude);
    box.write('longitude', position.longitude);
    print('${position.latitude} - ${position.longitude}');
    box.write('current-address', currentAddress);
    box.writeIfNull('isUpdateIdCard', false);
    box.writeIfNull('isUpdateVehicle', false);
    print(">>>>>>>>>>>>>>>>>>>>>>>>currentAddress $currentAddress");
  }


  Future<void> requestCameraPermission() async {
    try {
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
    } catch (e) {
      print("Failed to request permissions: $e");
    }
  }
}
