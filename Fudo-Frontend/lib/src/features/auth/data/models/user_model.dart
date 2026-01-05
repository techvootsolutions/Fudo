// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';
import 'package:fudo/src/features/auth/data/models/health_detail_model.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  bool? success;
  String? message;
  Data? data;

  UserModel({this.success, this.message, this.data});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  User? user;
  String? token;
  HealthDetail? healthDetail;
  bool? hasHealthDetails;
  String? tokenType;
  int? expiresIn;

  Data({
    this.user,
    this.token,
    this.healthDetail,
    this.hasHealthDetails,
    this.tokenType,
    this.expiresIn,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"],
    healthDetail: json["health_detail"] == null
        ? null
        : HealthDetail.fromJson(json["health_detail"] as Map<String, dynamic>),
    hasHealthDetails: json["has_health_details"],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "token": token,
    "health_detail": healthDetail?.toJson(),
    "has_health_details": hasHealthDetails,
    "token_type": tokenType,
    "expires_in": expiresIn,
  };
}

class User {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  HealthDetail? healthDetail;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.healthDetail,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] as int?,
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    healthDetail: json["health_detail"] == null
        ? null
        : HealthDetail.fromJson(json["health_detail"] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "health_detail": healthDetail?.toJson(),
  };
}
