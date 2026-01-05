import 'dart:convert';

import 'package:fudo/base_notifier.dart';
import 'package:fudo/src/core/router/app_routes.dart';
import 'package:fudo/src/core/utils/constants/app_const_functions.dart';
import 'package:fudo/src/core/utils/navigation/navigation_services.dart';
import 'package:fudo/src/core/utils/sharedpref/shared_pref.dart';
import 'package:fudo/src/core/utils/singleton/singleton.dart';

import 'package:fudo/src/features/auth/domain/repositories/auth_repositories.dart';
// Other imports would be needed for the following:
// LoginReqModel, RequestParamsType, Singleton, NavigationService, AppRoutes,
// SharedPref, PremiumNotifier, errorDialog, hideKeyboard

class LoginProvider extends BaseNotifier {
  AuthRepository authRepository;
  LoginProvider(this.authRepository);

  bool isLoading = false;
  String email = '';
  String password = '';

  String? emailError;
  String? passwordError;

  void setEmail(String val) {
    email = val;
    if (email.isEmpty) {
      emailError = "Email is required";
    } else {
      emailError = null;
    }
    notifyListeners();
  }

  void setPassword(String val) {
    password = val;
    if (password.isEmpty) {
      passwordError = "Password is required";
    } else {
      passwordError = null;
    }
    notifyListeners();
  }

  // This method would be called to initialize some data
  void init() {}

  login() async {
    bool hasError = false;
    if (email.isEmpty) {
      emailError = "Email is required";
      hasError = true;
    }

    if (password.isEmpty) {
      passwordError = "Password is required";
      hasError = true;
    }

    if (hasError) {
      notifyListeners();
    }

    isLoading = true;
    notifyListeners();

    final prams = {"email": email, "password": password};

    try {
      await authRepository
          .loginUser(argument: jsonEncode(prams))
          .then(
            (value) => value.handleResponse(
              onSuccess: (data) async {
                logV("data: ${data.toJson()}");
                isLoading = false;
                await SharedPref.instance.saveUserData(data);
                logV("token: ${data.data?.token}");
                Singleton.instance.authToken = data.data?.token;
                logV("Singleton token: ${Singleton.instance.authToken}");
                notifyListeners();
                if (data.data?.user?.healthDetail == null) {
                  NavigationService.pushNamedAndRemoveUntil(
                    AppRoutes.fitnessPlanScreen,
                  );
                } else if (data.data?.user?.healthDetail?.mealType == null) {
                  NavigationService.pushNamedAndRemoveUntil(
                    AppRoutes.mealPreferencesScreen,
                  );
                }else{
                  NavigationService.pushNamedAndRemoveUntil(
                    AppRoutes.mealPlanScreen,
                  );
                }
              },
              onFailure: (errorMessage) {
                isLoading = false;
                errorDialog(
                  errorMessage,
                  NavigationService.navigatorKey.currentContext!,
                );
                notifyListeners();
              },
            ),
          );
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void onDispose() {
    // TODO: implement onDispose
  }
}
