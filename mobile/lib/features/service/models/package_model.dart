import 'dart:convert';

class PackageModel {
  final int productId;
  final String? productName;
  final int quantity;
  final String? productDescription;
  final String totalDismension;
  final String weight;
  final String? image;
  final String? typeProduct;
  final int senderId;

  // Constructor
  PackageModel(
      {required this.productId,
      this.productName,
      required this.typeProduct,
      required this.quantity,
      this.productDescription,
      required this.totalDismension,
      required this.weight,
      this.image,
      required this.senderId});

  // Empty constructor with default values
  static PackageModel empty() => PackageModel(
      productId: 0,
      productName: '',
      quantity: 0,
      productDescription: '',
      totalDismension: '',
      weight: '',
      image: '',
      typeProduct: '',
      senderId: 0);

  // JSON deserialization from a raw JSON string
  factory PackageModel.fromRawJson(String str) =>
      PackageModel.fromJson(json.decode(str));

  // JSON serialization to a raw JSON string
  String toRawJson() => json.encode(toJson());

  // JSON deserialization from a Map
  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
      productId: json["productId"],
      productName: json["productName"],
      quantity: json["quantity"],
      productDescription: json["productDescription"],
      totalDismension: json["totalDismension"] ?? "",
      weight: json["weight"],
      image: json["image"],
      typeProduct: json["typeProduct"],
      senderId: json["senderId"]);

  // JSON serialization to a Map
  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "quantity": quantity,
        "productDescription": productDescription,
        "totalDismension": totalDismension,
        "weight": weight,
        "image": image,
        "typeProduct": typeProduct,
        "senderId": senderId
      };
}
