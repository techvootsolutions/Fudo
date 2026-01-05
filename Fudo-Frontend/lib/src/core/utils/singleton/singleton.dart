import 'dart:ui';

import 'package:fudo/src/core/utils/sharedpref/shared_pref.dart';
import 'package:fudo/src/features/auth/data/models/user_model.dart';

class Singleton {
  Singleton._privateConstructor();

  static final Singleton _instance = Singleton._privateConstructor();

  static Singleton get instance => _instance;
  UserModel? userData;
  String? deviceToken = '';
  String? authToken = '';
  bool isOnBoardingCompleted = false;
  Locale? selectedLocal;
  String? deviceName = '';
  String? deviceCountry = '';
  String? deviceType = '';
  String? osVersion = '';
  String? appVersion = "1.0.0";

  // Future getToken() async {
  //   try {
  //     deviceToken = await FirebaseMessaging.instance.getToken();
  //   } catch (e) {
  //     logV("deviceToken Error: ${e}");

  //     deviceToken = "device_token_12345";
  //   }
  //   logV("deviceToken: ${deviceToken}");
  //   // deviceToken = "device_token_12345";
  //   return deviceToken;
  // }

  void clearOnLogout() {
    userData = null;
    authToken = null;
    SharedPref.instance.clear();
  }
}
