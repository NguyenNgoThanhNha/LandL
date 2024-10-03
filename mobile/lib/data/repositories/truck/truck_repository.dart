import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/features/service/models/truck_model.dart';
import 'package:mobile/utils/http/http_client.dart';
import 'package:mobile/utils/http/response_props.dart';

class TruckRepository extends GetxController {
  TruckRepository get instance => Get.find();
  final box = GetStorage();

  Future<ResponseProps> getAllTruckType() async {
    try {
      return await THttpClient.get('VehicleType/GetAllVehicleType');
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  Future<TruckModel?> getAllTruck() async {
    try {
      final userId = box.read('userId');
      final response =
          await THttpClient.get('Truck/GetTruckOfUser?userId=$userId');
      if (response.success) {
        print(">>>>>>>>>>>>>>>>>>>>>>>>");
        print(response.result?.data);
        print("??????????????????");
        return TruckModel.fromJson(
            response.result?.data as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      throw 'Something went wrong';
    }
  }

  Future<ResponseProps> createTruck(
      String name,
      String plateCode,
      String color,
      String manufacturer,
      String frameNumber,
      String engineNumber,
      String model,
      String loadCapacity,
      int length,
      int width,
      int height,
      int type) async {
    try {
      return await THttpClient.post('Truck/CreateTruck', {
        "truckName": name,
        "status": "active",
        "plateCode": plateCode,
        "color": color,
        "totalBill": 1000,
        "manufacturer": manufacturer,
        "vehicleModel": model,
        "frameNumber": frameNumber,
        "engineNumber": engineNumber,
        "loadCapacity": loadCapacity,
        "dimensionsLength": length,
        "dimensionsWidth": width,
        "dimensionsHeight": height,
        "vehicleTypeId": type,
      });
    } catch (e) {
      throw 'Something went wrong';
    }
  }
}
