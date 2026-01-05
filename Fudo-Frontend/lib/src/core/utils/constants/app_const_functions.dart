import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fudo/src/core/router/app_routes.dart';
import 'package:fudo/src/core/utils/constants/storage_keys.dart';
import 'package:fudo/src/core/utils/helper/alert_dialog.dart';
import 'package:fudo/src/core/utils/navigation/navigation_services.dart';
import 'package:fudo/src/core/utils/singleton/singleton.dart';
import 'package:url_launcher/url_launcher.dart';

hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

lunchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    logV('Could not launch $url');
  }
}

logV(String s) {
  if (kDebugMode) {
    // log(s);
    print(s);
  }
}

isConnectionAvailable() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (e) {
    logV("result: E: $e");
    return false;
  }
}

getDeviceType() {
  return Platform.isAndroid
      ? "android"
      : Platform.isIOS
      ? "ios"
      : "";
}

Map<String, String> commonHeader = {
  ApiServicesHeaderKEYs.accept: "application/json",
  ApiServicesHeaderKEYs.contentType: "application/json",
};
Map<String, String> commonHeaderWithMultiPartFormData = {
  ApiServicesHeaderKEYs.contentType: "multipart/form-data",
};

// Map<String, String> commonHeaderWithToken =
commonHeaderWithMultiPartFormDataWithToken() {
  return {
    ApiServicesHeaderKEYs.contentType: "multipart/form-data",
    ApiServicesHeaderKEYs.accept: "application/json",
    ApiServicesHeaderKEYs.authorization:
        "Bearer ${Singleton.instance.authToken}",
  };
}

commonHeaderWithToken() {
  return {
    ApiServicesHeaderKEYs.accept: "application/json",
    ApiServicesHeaderKEYs.contentType: "application/json",
    ApiServicesHeaderKEYs.authorization:
        "Bearer ${Singleton.instance.authToken}",
  };
}

String getImageUrlFromName(String input) {
  var name = input;
  if (!input.contains(" ") && input.isNotEmpty) {
    name = "${input.substring(0, 1)} ${input.substring(1)}";
  }
  return "https://ui-avatars.com/api/?name=${Uri.encodeComponent(name)}";
}

clearAndGotoLogin() {
  Singleton.instance.clearOnLogout();
  NavigationService.pushNamedAndRemoveUntil(AppRoutes.loginScreen);
}

errorDialog(
  String errorMessage,
  BuildContext context, {
  VoidCallback? onSubmit,
  String? confirmButtonText,
  Widget? confirmWidget,
}) {
  return customAlert(
    showCancelBtn: false,
    isCenterAction: true,
    context: context,
    contentString: errorMessage,
    confirmButtonText: confirmButtonText,
    confirmWidget: confirmWidget,
    onSubmit:
        onSubmit ??
        () {
          print("Back call");
          NavigationService.goBack();
        },
  );
}
