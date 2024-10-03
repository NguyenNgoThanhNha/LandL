import 'dart:convert';

class UserModel {
  final int? userId;
  final String? userName;
  final String? password;
  final String? fullName;
  final String? email;
  final String? avatar;
  final String? gender;
  final String? city;
  final String? address;
  final DateTime? birthDate;
  final String? otpCode;
  final String? phoneNumber;
  final String? stk;
  final String? bank;
  final String? qrCode;
  final String? accountBalance;
  final String? createBy;
  final DateTime? createDate;
  final String? modifyBy;
  final String? modifyDate;
  final String? status;
  final String? refreshToken;
  final String? typeLogin;
  final int? roleID;
  final String? userRole;

  UserModel({
    this.userId,
    this.userName,
    this.password,
    this.fullName,
    this.email,
    this.avatar,
    this.gender,
    this.city,
    this.address,
    this.birthDate,
    this.otpCode,
    this.phoneNumber,
    this.stk,
    this.bank,
    this.qrCode,
    this.accountBalance,
    this.createBy,
    this.createDate,
    this.modifyBy,
    this.modifyDate,
    this.status,
    this.refreshToken,
    this.typeLogin,
    this.roleID,
    this.userRole,
  });

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json["userId"],
    userName: json["userName"],
    password: json["password"],
    fullName: json["fullName"],
    email: json["email"],
    avatar: json["avatar"],
    gender: json["gender"],
    city: json["city"],
    address: json["address"],
    birthDate: json["birthDate"] == null ? null : DateTime.parse(json["birthDate"]),
    otpCode: json["otpCode"],
    phoneNumber: json["phoneNumber"],
    stk: json["stk"],
    bank: json["bank"],
    qrCode: json["qrCode"],
    accountBalance: json["accountBalance"],
    createBy: json["createBy"],
    createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
    modifyBy: json["modifyBy"],
    modifyDate: json["modifyDate"],
    status: json["status"],
    refreshToken: json["refreshToken"],
    typeLogin: json["typeLogin"],
    roleID: json["roleID"],
    userRole: json["userRole"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "userName": userName,
    "password": password,
    "fullName": fullName,
    "email": email,
    "avatar": avatar,
    "gender": gender,
    "city": city,
    "address": address,
    "birthDate": birthDate?.toIso8601String(),
    "otpCode": otpCode,
    "phoneNumber": phoneNumber,
    "stk": stk,
    "bank": bank,
    "qrCode": qrCode,
    "accountBalance": accountBalance,
    "createBy": createBy,
    "createDate": createDate?.toIso8601String(),
    "modifyBy": modifyBy,
    "modifyDate": modifyDate,
    "status": status,
    "refreshToken": refreshToken,
    "typeLogin": typeLogin,
    "roleID": roleID,
    "userRole": userRole,
  };
}
