
import 'package:flutter/material.dart';
import 'package:fudo/src/features/auth/presentation/screens/login_screen.dart';
import 'package:fudo/src/features/auth/presentation/screens/register_screen.dart';
import 'package:fudo/src/features/fitness_plan/presentation/screens/fitness_plan_screen.dart';
import 'package:fudo/src/features/meal_preferences/presentation/screens/meal_preferences_screen.dart';
import 'package:fudo/src/features/meal_plan/presentation/screens/meal_plan_screen.dart';
import 'package:fudo/src/features/splash/presentation/screens/splash_screen.dart';

class AppRoutes {
  /// Auth Screens
  static const String splashScreen = '/SplashScreen';
  static const String loginScreen = '/LoginScreen';
  static const String signupScreen = '/SignupScreen';

  static const String providerProfileScreen = '/ProviderProfileScreen';
  static const String fitnessPlanScreen = '/FitnessPlanScreen';
  static const String mealPreferencesScreen = '/MealPreferencesScreen';
  static const String mealPlanScreen = '/MealPlanScreen';

  static Map<String, WidgetBuilder> get routes => {
            splashScreen: (_) => const SplashScreen(),

    loginScreen: (context) => LoginScreen.builder(context),
    signupScreen: (context) => RegisterScreen.builder(context),
    fitnessPlanScreen: (context) => FitnessPlanScreen.builder(context),
    mealPreferencesScreen: (context) => MealPreferencesScreen.builder(context),
    mealPlanScreen: (context) => MealPlanScreen.builder(context),
    // splashScreen: (context) => SplashScreen),
    
  };
}
