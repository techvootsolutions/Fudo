

import 'package:fudo/src/core/network/api_client/api_client.dart';
import 'package:fudo/src/features/auth/domain/repositories/auth_repositories.dart';
import 'package:fudo/src/features/auth/presentation/provider/login_provider.dart';
import 'package:fudo/src/features/auth/presentation/provider/registration_provider.dart';
import 'package:fudo/src/features/fitness_plan/domain/repositories/fitness_plan_repository.dart';
import 'package:fudo/src/features/fitness_plan/presentation/provider/fitness_plan_provider.dart';
import 'package:fudo/src/features/meal_preferences/domain/repositories/meal_preferences_repository.dart';
import 'package:fudo/src/features/meal_preferences/presentation/provider/meal_preferences_provider.dart';
import 'package:fudo/src/features/meal_plan/domain/repositories/meal_plan_repository.dart';
import 'package:fudo/src/features/meal_plan/presentation/provider/meal_plan_provider.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
Future<void> initializeDependencies(GetIt sl) async {
  sl.registerSingleton<ApiClient>(ApiClient());


  ///Auth
  sl.registerSingleton<AuthRepository>(AuthRepository(sl()));
  sl.registerFactory(() => LoginProvider(sl()));
  sl.registerFactory(() => RegistrationProvider(sl()));

  ///Fitness Plan
  sl.registerSingleton<FitnessPlanRepository>(FitnessPlanRepository(sl()));
  sl.registerFactory(() => FitnessPlanProvider(sl()));

  ///Meal Preferences
  sl.registerSingleton<MealPreferencesRepository>(MealPreferencesRepository(sl()));
  sl.registerFactory(() => MealPreferencesProvider(sl()));

  ///Meal Plan
  sl.registerSingleton<MealPlanRepository>(MealPlanRepository(sl()));
  sl.registerFactory(() => MealPlanProvider(sl()));

}
