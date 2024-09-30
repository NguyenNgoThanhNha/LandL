import 'dart:convert';

import 'package:mobile/features/service/models/delivery_model.dart';
import 'package:mobile/features/service/models/package_model.dart';
import 'package:mobile/features/service/models/truck_model.dart';

class OrderModel {
  int orderDetailId;
  String orderDetailCode;
  String reference;
  String paymentMethod;
  String transactionDateTime;
  double totalPrice;
  String status;
  int vehicleTypeId;
  int senderId;
  String userOrder;
  int orderId;
  String orderInfo;
  int productId;
  PackageModel productInfo;
  String truckId;
  TruckModel truckInfo;
  int deliveryInfoId;
  DeliveryModel deliveryInfoDetail;
  DateTime startDate;
  DateTime endDate;

  OrderModel({
    required this.orderDetailId,
    required this.orderDetailCode,
    required this.reference,
    required this.paymentMethod,
    required this.transactionDateTime,
    required this.totalPrice,
    required this.status,
    required this.vehicleTypeId,
    required this.senderId,
    required this.userOrder,
    required this.orderId,
    required this.orderInfo,
    required this.productId,
    required this.productInfo,
    required this.truckId,
    required this.truckInfo,
    required this.deliveryInfoId,
    required this.deliveryInfoDetail,
    required this.startDate,
    required this.endDate,
  });

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
        vehicleTypeId: json["vehicleTypeId"],
        senderId: json["senderId"],
        userOrder: json["userOrder"],
        orderId: json["orderId"],
        orderInfo: json["orderInfo"],
        productId: json["productId"],
        productInfo: PackageModel.fromJson(json["productInfo"]),
        truckId: json["truckId"],
        truckInfo: TruckModel.fromJson(json["truckInfo"]),
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
        "userOrder": userOrder,
        "orderId": orderId,
        "orderInfo": orderInfo,
        "productId": productId,
        "productInfo": productInfo.toJson(),
        "truckId": truckId,
        "truckInfo": truckInfo.toJson(),
        "deliveryInfoId": deliveryInfoId,
        "deliveryInfoDetail": deliveryInfoDetail.toJson(),
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
      };
}
