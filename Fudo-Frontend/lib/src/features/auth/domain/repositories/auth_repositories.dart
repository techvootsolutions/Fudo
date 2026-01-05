import 'dart:convert';
import 'dart:developer';

import 'package:fudo/src/core/network/api_client/api_client.dart';
import 'package:fudo/src/core/network/api_service/api_constants.dart';
import 'package:fudo/src/core/network/response_method/response.dart';
import 'package:fudo/src/core/utils/constants/app_const_functions.dart';
import 'package:fudo/src/features/auth/data/models/user_model.dart';



class AuthRepository {
  final ApiClient apiClient;
  AuthRepository(this.apiClient);

  ///Register USer
  Future<Response<UserModel>> registerUser({dynamic argument}) {
    return apiClient.post(
      ApiConstants.registerUrl,
      body: argument,
      headers: commonHeader,
      (p0) => UserModel.fromJson(p0),
    );
  }

  ///Login USer
  Future<Response<UserModel>> loginUser({dynamic argument}) {
    return apiClient.post(
      ApiConstants.loginUrl,
      body: argument,
      headers: commonHeader,
      (p0) => UserModel.fromJson(p0),
      isLogin: true,
    );
  }
}
