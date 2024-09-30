import 'dart:convert';

import 'package:mobile/features/personalization/models/user_model.dart';

class TruckModel {
  int truckId;
  String truckName;
  String status;
  String plateCode;
  String color;
  int totalBill;
  String manufacturer;
  String vehicleModel;
  String frameNumber;
  String engineNumber;
  String loadCapacity;
  double dimensionsLength;
  double dimensionsWidth;
  double dimensionsHeight;
  int vehicleTypeId;
  dynamic truckType;
  int userId;
   UserModel truckUser;

  TruckModel({
    required this.truckId,
    required this.truckName,
    required this.status,
    required this.plateCode,
    required this.color,
    required this.totalBill,
    required this.manufacturer,
    required this.vehicleModel,
    required this.frameNumber,
    required this.engineNumber,
    required this.loadCapacity,
    required this.dimensionsLength,
    required this.dimensionsWidth,
    required this.dimensionsHeight,
    required this.vehicleTypeId,
    required this.truckType,
    required this.userId,
    required this.truckUser,
  });

  factory TruckModel.fromRawJson(String str) =>
      TruckModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TruckModel.fromJson(Map<String, dynamic> json) => TruckModel(
        truckId: json["truckId"],
        truckName: json["truckName"],
        status: json["status"],
        plateCode: json["plateCode"],
        color: json["color"],
        totalBill: json["totalBill"],
        manufacturer: json["manufacturer"],
        vehicleModel: json["vehicleModel"],
        frameNumber: json["frameNumber"],
        engineNumber: json["engineNumber"],
        loadCapacity: json["loadCapacity"],
        dimensionsLength: json["dimensionsLength"]?.toDouble(),
        dimensionsWidth: json["dimensionsWidth"]?.toDouble(),
        dimensionsHeight: json["dimensionsHeight"]?.toDouble(),
        vehicleTypeId: json["vehicleTypeId"],
        truckType: json["truckType"],
        userId: json["userId"],
        truckUser: UserModel.fromJson(json["truckUser"]),
      );

  Map<String, dynamic> toJson() => {
        "truckId": truckId,
        "truckName": truckName,
        "status": status,
        "plateCode": plateCode,
        "color": color,
        "totalBill": totalBill,
        "manufacturer": manufacturer,
        "vehicleModel": vehicleModel,
        "frameNumber": frameNumber,
        "engineNumber": engineNumber,
        "loadCapacity": loadCapacity,
        "dimensionsLength": dimensionsLength,
        "dimensionsWidth": dimensionsWidth,
        "dimensionsHeight": dimensionsHeight,
        "vehicleTypeId": vehicleTypeId,
        "truckType": truckType,
        "userId": userId,
        "truckUser": truckUser,
      };
}
