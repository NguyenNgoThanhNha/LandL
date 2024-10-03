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


  PackageModel({
    required this.productId,
    this.productName,
    required this.typeProduct,
    required this.quantity,
    this.productDescription,
    required this.totalDismension,
    required this.weight,

    this.image,
  });

  factory PackageModel.fromRawJson(String str) =>
      PackageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(

      productId: json["productId"],
      productName: json["productName"],
      quantity: json["quantity"],
      productDescription: json["productDescription"],
      totalDismension: json["totalDismension"] ?? "",
      weight: json["weight"],
      image: json["image"],
      typeProduct: json["typeProduct"]);

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "quantity": quantity,
        "productDescription": productDescription,
        "totalDismension": totalDismension,
        "weight": weight,
        "image": image,
        "typeProduct": typeProduct
      };
}
