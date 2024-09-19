import 'package:meta/meta.dart';
import 'dart:convert';

class UserModel {
  final int productId;
  final String productName;
  final int quantity;
  final String productDescription;
  final String totalDimension;
  final int weight;
  final String image;

  UserModel({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.productDescription,
    required this.totalDimension,
    required this.weight,
    required this.image,
  });

  UserModel copyWith({
    int? productId,
    String? productName,
    int? quantity,
    String? productDescription,
    String? totalDimension,
    int? weight,
    String? image,
  }) =>
      UserModel(
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        quantity: quantity ?? this.quantity,
        productDescription: productDescription ?? this.productDescription,
        totalDimension: totalDimension ?? this.totalDimension,
        weight: weight ?? this.weight,
        image: image ?? this.image,
      );

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    productId: json["productId"],
    productName: json["productName"],
    quantity: json["quantity"],
    productDescription: json["productDescription"],
    totalDimension: json["totalDimension"],
    weight: json["weight"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "productName": productName,
    "quantity": quantity,
    "productDescription": productDescription,
    "totalDimension": totalDimension,
    "weight": weight,
    "image": image,
  };
}
