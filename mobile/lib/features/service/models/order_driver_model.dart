import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:mobile/features/personalization/models/user_model.dart';

class OrderTotalModel {
  int orderId;
  int orderCode;
  double totalAmount;
  double driverAmount;
  double systemAmount;
  double vat;
  int orderCount;
  String status;
  String? notes;
  int driverId;
  UserModel? orderDriver;
  DateTime orderDate;
  DateTime endDate;

  OrderTotalModel({
    required this.orderId,
    required this.orderCode,
    required this.totalAmount,
    required this.driverAmount,
    required this.systemAmount,
    required this.vat,
    required this.orderCount,
    required this.status,
    this.notes,
    required this.driverId,
    required this.orderDriver,
    required this.orderDate,
    required this.endDate,
  });

  factory OrderTotalModel.fromRawJson(String str) =>
      OrderTotalModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderTotalModel.fromJson(Map<String, dynamic> json) =>
      OrderTotalModel(
        orderId: json["orderId"],
        orderCode: json["orderCode"],
        totalAmount: json["totalAmount"].toDouble(),
        driverAmount: json["driverAmount"].toDouble(),
        systemAmount: json["systemAmount"].toDouble(),
        vat: json["vat"].toDouble(),
        orderCount: json["orderCount"],
        status: json["status"] ?? "",
        notes: json["notes"] ?? "",
        driverId: json["driverId"],
        orderDriver: json["orderDriver"] != null
            ? UserModel.fromJson(json["orderDriver"])
            : null,
        orderDate: DateTime.parse(json["orderDate"]),
        endDate: DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "orderCode": orderCode,
        "totalAmount": totalAmount,
        "driverAmount": driverAmount,
        "systemAmount": systemAmount,
        "vat": vat,
        "orderCount": orderCount,
        "status": status,
        "notes": notes,
        "driverId": driverId,
        "orderDriver": orderDriver?.toJson(),
        "orderDate": orderDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
      };
}
