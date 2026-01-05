// lib/src/features/splash/presentation/provider/splash_provider.dart
import 'package:flutter/material.dart';
import 'package:fudo/src/core/router/app_routes.dart';
import 'package:fudo/src/core/utils/navigation/navigation_services.dart';
import 'package:fudo/src/core/utils/singleton/singleton.dart';

class SplashProvider extends ChangeNotifier {
  bool _isLoading = true;

  bool get isLoading => _isLoading;

   initializeApp() async {
    // Add any initialization logic here
    await Future.delayed(const Duration(seconds: 2)); // Example delay
    if (Singleton.instance.userData?.data?.token != null) {
      if (Singleton.instance.userData?.data?.user?.healthDetail == null) {
        NavigationService.pushNamedAndRemoveUntil(AppRoutes.fitnessPlanScreen);
      } else if (Singleton
              .instance
              .userData
              ?.data
              ?.user
              ?.healthDetail
              ?.mealType == 
          null) {
        NavigationService.pushNamedAndRemoveUntil(
          AppRoutes.mealPreferencesScreen,
        );
      } else {
        NavigationService.pushNamedAndRemoveUntil(AppRoutes.mealPlanScreen);
      }
    } else {
      NavigationService.pushNamedAndRemoveUntil(AppRoutes.loginScreen);
    }
  }
}
