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

  // Constructor
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

  // Empty constructor with default values
  static OrderTotalModel empty() => OrderTotalModel(
    orderId: 0,
    orderCode: 0,
    totalAmount: 0.0,
    driverAmount: 0.0,
    systemAmount: 0.0,
    vat: 0.0,
    orderCount: 0,
    status: '',
    notes: '',
    driverId: 0,
    orderDriver: UserModel.empty(),  // Assuming UserModel has an empty constructor
    orderDate: DateTime.now(),
    endDate: DateTime.now(),
  );

  // JSON deserialization from a raw JSON string
  factory OrderTotalModel.fromRawJson(String str) =>
      OrderTotalModel.fromJson(json.decode(str));

  // JSON serialization to a raw JSON string
  String toRawJson() => json.encode(toJson());

  // JSON deserialization from Map
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

  // JSON serialization to Map
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
