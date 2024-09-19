import 'package:meta/meta.dart';
import 'dart:convert';

class UserModel {
  final int id;
  final String email;
  final String userName;
  final String password;
  final String fullName;
  final String phone;
  final String city;
  final String address;
  final String link;
  final String typeAccount;

  UserModel({
    required this.id,
    required this.email,
    required this.userName,
    required this.password,
    required this.fullName,
    required this.phone,
    required this.city,
    required this.address,
    required this.link,
    required this.typeAccount,
  });

  UserModel copyWith({
    int? id,
    String? email,
    String? userName,
    String? password,
    String? fullName,
    String? phone,
    String? city,
    String? address,
    String? link,
    String? typeAccount,
  }) =>
      UserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        fullName: fullName ?? this.fullName,
        phone: phone ?? this.phone,
        city: city ?? this.city,
        address: address ?? this.address,
        link: link ?? this.link,
        typeAccount: typeAccount ?? this.typeAccount,
      );

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    email: json["email"],
    userName: json["userName"],
    password: json["password"],
    fullName: json["fullName"],
    phone: json["phone"],
    city: json["city"],
    address: json["address"],
    link: json["link"],
    typeAccount: json["typeAccount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "userName": userName,
    "password": password,
    "fullName": fullName,
    "phone": phone,
    "city": city,
    "address": address,
    "link": link,
    "typeAccount": typeAccount,
  };
}
