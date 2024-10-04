import 'dart:convert';

class DeliveryModel {
  int deliveryInfoId;
  String? receiverName;
  String senderName;
  String? receiverPhone;
  String? senderPhone;
  String deliveryLocaTion;
  String longDelivery;
  String latDelivery;
  String pickUpLocation;
  String longPickUp;
  String latPickUp;
  DateTime orderDate;
  DateTime recieveDate;
  String? expectedRecieveDate;
  String? expectedDeliveryDate;
  String? deliveryDate;

  // Constructor
  DeliveryModel({
    required this.deliveryInfoId,
    this.receiverName,
    required this.senderName,
    this.receiverPhone,
    this.senderPhone,
    required this.deliveryLocaTion,
    required this.longDelivery,
    required this.latDelivery,
    required this.pickUpLocation,
    required this.longPickUp,
    required this.latPickUp,
    required this.orderDate,
    required this.recieveDate,
    this.expectedRecieveDate,
    this.expectedDeliveryDate,
    this.deliveryDate,
  });

  // Empty constructor with default values
  static DeliveryModel empty() => DeliveryModel(
    deliveryInfoId: 0,
    receiverName: '',
    senderName: '',
    receiverPhone: '',
    senderPhone: '',
    deliveryLocaTion: '',
    longDelivery: '',
    latDelivery: '',
    pickUpLocation: '',
    longPickUp: '',
    latPickUp: '',
    orderDate: DateTime.now(),
    recieveDate: DateTime.now(),
    expectedRecieveDate: '',
    expectedDeliveryDate: '',
    deliveryDate: '',
  );

  // JSON deserialization from a raw JSON string
  factory DeliveryModel.fromRawJson(String str) =>
      DeliveryModel.fromJson(json.decode(str));

  // JSON serialization to a raw JSON string
  String toRawJson() => json.encode(toJson());

  // JSON deserialization
  factory DeliveryModel.fromJson(Map<String, dynamic> json) => DeliveryModel(
    deliveryInfoId: json["deliveryInfoId"],
    receiverName: json["receiverName"] ?? "",
    senderName: json["senderName"],
    receiverPhone: json["receiverPhone"] ?? "",
    senderPhone: json["senderPhone"] ?? "",
    deliveryLocaTion: json["deliveryLocaTion"],
    longDelivery: json["longDelivery"],
    latDelivery: json["latDelivery"],
    pickUpLocation: json["pickUpLocation"],
    longPickUp: json["longPickUp"],
    latPickUp: json["latPickUp"],
    orderDate: DateTime.parse(json["orderDate"]),
    recieveDate: DateTime.parse(json["recieveDate"]),
    expectedRecieveDate: json["expectedRecieveDate"] ?? "",
    expectedDeliveryDate: json["expectedDeliveryDate"] ?? "",
    deliveryDate: json["deliveryDate"] ?? "",
  );

  // JSON serialization
  Map<String, dynamic> toJson() => {
    "deliveryInfoId": deliveryInfoId,
    "receiverName": receiverName,
    "senderName": senderName,
    "receiverPhone": receiverPhone,
    "senderPhone": senderPhone,
    "deliveryLocaTion": deliveryLocaTion,
    "longDelivery": longDelivery,
    "latDelivery": latDelivery,
    "pickUpLocation": pickUpLocation,
    "longPickUp": longPickUp,
    "latPickUp": latPickUp,
    "orderDate": orderDate.toIso8601String(),
    "recieveDate": recieveDate.toIso8601String(),
    "expectedRecieveDate": expectedRecieveDate,
    "expectedDeliveryDate": expectedDeliveryDate,
    "deliveryDate": deliveryDate,
  };
}
