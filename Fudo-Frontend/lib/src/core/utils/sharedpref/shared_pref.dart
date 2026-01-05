import 'dart:convert';

import 'package:fudo/src/core/utils/constants/app_const_functions.dart';
import 'package:fudo/src/core/utils/constants/storage_keys.dart';
import 'package:fudo/src/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../singleton/singleton.dart' show Singleton;

class SharedPref {
  SharedPref._privateConstructor();

  static final SharedPref _instance = SharedPref._privateConstructor();

  static SharedPref get instance => _instance;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  saveUserData(UserModel? value) async {
    // value?.data?.token = Singleton.instance.authToken;
    Singleton.instance.userData = value;
    final SharedPreferences prefs = await _prefs;
    logV("saveUserData json: ${json.encode(value?.toJson())}");
    prefs.setString(PreferenceKeys.saveUserData, json.encode(value?.toJson()));
  }

  getUserData() async {
    final SharedPreferences prefs = await _prefs;
    final data = prefs.getString(PreferenceKeys.saveUserData);
    if (data != null) {
      logV("User Data : $data");
      UserModel userData = UserModel.fromJson(json.decode(data));
      logV("userData.data?.token != null: ${userData.data?.token != null}");
      if (userData.data?.token != null) {
        Singleton.instance.userData = userData;
        Singleton.instance.authToken = userData.data?.token;
      }
    }
  }

  read(String key) async {
    final SharedPreferences prefs = await _prefs;

    // List ff = [];
    return await json.decode(prefs.getString(key).toString());
  }

  save(String key, value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, json.encode(value));
  }

  void clear() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(PreferenceKeys.saveUserData);
    prefs.remove(PreferenceKeys.dontShowCategoryDialog);
  }
}
