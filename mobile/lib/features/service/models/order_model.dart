import 'dart:convert';

import 'package:mobile/features/personalization/models/user_model.dart';
import 'package:mobile/features/service/models/delivery_model.dart';
import 'package:mobile/features/service/models/order_driver_model.dart';
import 'package:mobile/features/service/models/package_model.dart';
import 'package:mobile/features/service/models/truck_model.dart';

class OrderModel {
  int orderDetailId;
  int? orderDetailCode;
  String? reference;
  String? paymentMethod;
  String? transactionDateTime;
  double totalPrice;
  String status;
  int? vehicleTypeId;
  int? senderId;
  UserModel? userOrder;
  int orderId;
  OrderTotalModel? orderInfo;
  int productId;
  PackageModel productInfo;
  int? truckId;
  double distance;
  TruckModel? truckInfo;
  int deliveryInfoId;
  DeliveryModel deliveryInfoDetail;
  DateTime startDate;
  DateTime endDate;

  OrderModel(
      {required this.orderDetailId,
      required this.orderDetailCode,
      required this.reference,
      required this.paymentMethod,
      required this.transactionDateTime,
      required this.totalPrice,
      required this.status,
      required this.vehicleTypeId,
      required this.senderId,
      this.userOrder,
      required this.orderId,
      required this.orderInfo,
      required this.productId,
      required this.productInfo,
      required this.truckId,
      this.truckInfo,
      required this.deliveryInfoId,
      required this.deliveryInfoDetail,
      required this.startDate,
      required this.endDate,
      required this.distance});

  factory OrderModel.fromRawJson(String str) =>
      OrderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orderDetailId: json["orderDetailId"],
        orderDetailCode: json["orderDetailCode"],
        reference: json["reference"],
        paymentMethod: json["paymentMethod"],
        transactionDateTime: json["transactionDateTime"],
        totalPrice: json["totalPrice"]?.toDouble(),
        status: json["status"],
        distance: json['distance']?.toDouble(),
        vehicleTypeId: json["vehicleTypeId"],
        senderId: json["senderId"],
        userOrder: json["userOrder"] != null
            ? UserModel.fromJson(json["userOrder"])
            : null,
        orderId: json["orderId"],
        orderInfo: json["orderInfo"] != null
            ? OrderTotalModel.fromJson(json["orderInfo"])
            : null,
        productId: json["productId"],
        productInfo: PackageModel.fromJson(json["productInfo"]),
        truckId: json["truckId"],
        truckInfo: json["truckInfo"] != null
            ? TruckModel.fromJson(json["truckInfo"])
            : null,
        deliveryInfoId: json["deliveryInfoId"],
        deliveryInfoDetail: DeliveryModel.fromJson(json["deliveryInfoDetail"]),
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "orderDetailId": orderDetailId,
        "orderDetailCode": orderDetailCode,
        "reference": reference,
        "paymentMethod": paymentMethod,
        "transactionDateTime": transactionDateTime,
        "totalPrice": totalPrice,
        "status": status,
        "vehicleTypeId": vehicleTypeId,
        "senderId": senderId,
        "userOrder": userOrder?.toJson(),
        "orderId": orderId,
        "distance": distance,
        "orderInfo": orderInfo?.toJson(),
        "productId": productId,
        "productInfo": productInfo.toJson(),
        "truckId": truckId,
        "truckInfo": truckInfo?.toJson(),
        "deliveryInfoId": deliveryInfoId,
        "deliveryInfoDetail": deliveryInfoDetail.toJson(),
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
      };
}
