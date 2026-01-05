import 'dart:convert';

import 'package:fudo/base_notifier.dart';
import 'package:fudo/src/core/utils/constants/app_const_functions.dart';
import 'package:fudo/src/core/utils/navigation/navigation_services.dart';
import 'package:fudo/src/features/meal_plan/data/models/meal_plan_model.dart';
import 'package:fudo/src/features/meal_plan/domain/repositories/meal_plan_repository.dart';

class MealPlanProvider extends BaseNotifier {
  final MealPlanRepository mealPlanRepository;

  MealPlanProvider(this.mealPlanRepository);

  bool isLoading = false;
  MealPlanModel? mealPlan;
  String? errorMessage;

  // Track selected meals and their status for current day
  // Map<String, SelectedMeal> selectedMeals = {}; // key: "breakfast", "lunch", "dinner"
  String? currentDate;

  void init() {
    loadMealPlan();
  }

Future<void> loadMealPlan() async {
  isLoading = true;
  errorMessage = null;
  notifyListeners();

  try {
    final response = await mealPlanRepository.getMealPlan();
    response.handleResponse(
      onSuccess: (data) {
        try {
          mealPlan = MealPlanModel.fromJson(data);
          // initializeSelectedMeals();
        } catch (e, stackTrace) {
          logV("Error parsing meal plan: $e");
          logV("Stack trace: $stackTrace");
          errorMessage = "Failed to parse meal plan data: ${e.toString()}";
        }
        isLoading = false;
        notifyListeners();
      },
      onFailure: (error) {
        errorMessage = error;
        isLoading = false;
        notifyListeners();
      },
    );
  } catch (e, stackTrace) {
    logV("Error in loadMealPlan: $e");
    logV("Stack trace: $stackTrace");
    errorMessage = "Failed to load meal plan. Please try again.";
    isLoading = false;
    notifyListeners();
  }
}
  // Future<void> loadMealPlan() async {
  //   isLoading = true;
  //   errorMessage = null;
  //   notifyListeners();

  //   try {
  //     final response = await mealPlanRepository.getMealPlan();
  //     response.handleResponse(
  //       onSuccess: (data) {
  //         try {
  //           // The API response structure: { success, message, data: { response: "JSON_STRING", ... } }
  //           // Extract the response string from data.data.response
  //           final responseData = data['data'] as Map<String, dynamic>?;
  //           if (responseData != null && responseData['response'] != null) {
  //             // Parse the JSON string to get the actual meal plan data
  //             var mealPlanJsonString = responseData['response'] as String;
              
  //             // Fix invalid JSON: Replace unquoted numeric values with "g" suffix
  //             // Pattern: ": 15g, -> ": "15g",
  //             // Pattern: ": 15g\n -> ": "15g"
  //             mealPlanJsonString = mealPlanJsonString.replaceAllMapped(
  //               RegExp(r':\s*(\d+)g([,\s\n}])'),
  //               (match) {
  //                 final number = match.group(1)!;
  //                 final suffix = match.group(2)!;
  //                 return ': "${number}g"$suffix';
  //               },
  //             );
              
  //             // Also handle cases where it's at the end of a line or object
  //             mealPlanJsonString = mealPlanJsonString.replaceAllMapped(
  //               RegExp(r':\s*(\d+)g([\s]*[,\n}])'),
  //               (match) {
  //                 final number = match.group(1)!;
  //                 final suffix = match.group(2)!;
  //                 return ': "${number}g"$suffix';
  //               },
  //             );
              
  //             final mealPlanJson = jsonDecode(mealPlanJsonString) as Map<String, dynamic>;
              
  //             // Parse the meal plan JSON into MealPlanModel
  //             mealPlan = MealPlanModel.fromJson(mealPlanJson);
              
  //             if (mealPlan!.days.isNotEmpty) {
  //               currentDate = mealPlan!.days.first.date;
  //               // Initialize selected meals if not already set
  //               initializeSelectedMeals();
  //             }
  //           } else {
  //             errorMessage = "Invalid response format from server";
  //           }
  //         } catch (e) {
  //                 logV("E: $e");

  //           errorMessage = "Failed to parse meal plan data: ${e.toString()}";
  //         }
  //         isLoading = false;
  //         notifyListeners();
  //       },
  //       onFailure: (errorMessage) {
  //         this.errorMessage = errorMessage;
  //         isLoading = false;
  //         notifyListeners();
  //       },
  //     );
  //   } catch (e) {
  //     logV("E: $e");
  //     errorMessage = "Something went wrong. Please try again.";
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // void initializeSelectedMeals() {
  //   if (mealPlan == null || mealPlan!.days.isEmpty) return;

  //   final todayMeals = mealPlan!.days.first.meals;
  //   for (var meal in todayMeals) {
  //     final key = meal.mealType.toLowerCase();
  //     if (!selectedMeals.containsKey(key)) {
  //       selectedMeals[key] = SelectedMeal(
  //         mealType: meal.mealType,
  //         optionNumber: meal.optionNumber,
  //         status: MealStatus.pending,
  //       );
  //     }
  //   }
  // }

  // Get meals for a specific meal type (breakfast, lunch, dinner)
List<Meal> getMealsByType(String mealType) {
  return mealPlan?.getMealsByType(mealType) ?? [];
}

  // // Select a meal option
  // void selectMealOption(String mealType, int optionNumber) {
  //   final key = mealType.toLowerCase();
  //   selectedMeals[key] = SelectedMeal(
  //     mealType: mealType,
  //     optionNumber: optionNumber,
  //     status: MealStatus.pending,
  //   );
  //   notifyListeners();
  // }

  // // Get selected meal for a meal type
  // SelectedMeal? getSelectedMeal(String mealType) {
  //   return selectedMeals[mealType.toLowerCase()];
  // }

  // // Get selected meal option number
  // int? getSelectedOptionNumber(String mealType) {
  //   return selectedMeals[mealType.toLowerCase()]?.optionNumber;
  // }

  // // Mark meal as done
  // Future<void> markMealAsDone(String mealType) async {
  //   final key = mealType.toLowerCase();
  //   final selectedMeal = selectedMeals[key];
  //   if (selectedMeal == null) {
  //     errorDialog(
  //       "Please select a meal option first",
  //       NavigationService.navigatorKey.currentContext!,
  //     );
  //     return;
  //   }

  //   selectedMeal.status = MealStatus.done;
  //   selectedMeal.completedAt = DateTime.now();
  //   notifyListeners();

  //   await updateMealStatus(selectedMeal);
  // }

  // // Mark meal as skipped
  // Future<void> markMealAsSkipped(String mealType) async {
  //   final key = mealType.toLowerCase();
  //   final selectedMeal = selectedMeals[key];
  //   if (selectedMeal == null) {
  //     errorDialog(
  //       "Please select a meal option first",
  //       NavigationService.navigatorKey.currentContext!,
  //     );
  //     return;
  //   }

  //   selectedMeal.status = MealStatus.skipped;
  //   selectedMeal.completedAt = DateTime.now();
  //   notifyListeners();

  //   await updateMealStatus(selectedMeal);
  // }

  // // Mark meal as missed
  // Future<void> markMealAsMissed(String mealType) async {
  //   final key = mealType.toLowerCase();
  //   final selectedMeal = selectedMeals[key];
  //   if (selectedMeal == null) {
  //     errorDialog(
  //       "Please select a meal option first",
  //       NavigationService.navigatorKey.currentContext!,
  //     );
  //     return;
  //   }

  //   selectedMeal.status = MealStatus.missed;
  //   selectedMeal.completedAt = DateTime.now();
  //   notifyListeners();

  //   await updateMealStatus(selectedMeal);
  // }

  // // Update meal status on server
  // Future<void> updateMealStatus(SelectedMeal selectedMeal) async {
  //   try {
  //     final body = jsonEncode(selectedMeal.toJson());
  //     final response = await mealPlanRepository.updateMealStatus(argument: body);
  //     response.handleResponse(
  //       onSuccess: (data) {
  //         // Status updated successfully
  //       },
  //       onFailure: (errorMessage) {
  //         this.errorMessage = errorMessage;
  //         errorDialog(
  //           errorMessage,
  //           NavigationService.navigatorKey.currentContext!,
  //         );
  //         notifyListeners();
  //       },
  //     );
  //   } catch (e) {
  //     errorDialog(
  //       "Failed to update meal status. Please try again.",
  //       NavigationService.navigatorKey.currentContext!,
  //     );
  //   }
  // }

  // // Check if all meals for the day are marked
  // bool areAllMealsMarked() {
  //   if (selectedMeals.isEmpty) return false;
  //   return selectedMeals.values.every((meal) =>
  //       meal.status == MealStatus.done ||
  //       meal.status == MealStatus.skipped ||
  //       meal.status == MealStatus.missed);
  // }

  // // Check if a specific meal is marked
  // bool isMealMarked(String mealType) {
  //   final selectedMeal = selectedMeals[mealType.toLowerCase()];
  //   if (selectedMeal == null) return false;
  //   return selectedMeal.status != MealStatus.pending;
  // }

  // // Get meal status
  // MealStatus? getMealStatus(String mealType) {
  //   return selectedMeals[mealType.toLowerCase()]?.status;
  // }

  // // Check if user can proceed to next day
  // bool canProceedToNextDay() {
  //   return areAllMealsMarked();
  // }

  @override
  void onDispose() {
    // Clean up if needed
  }
}

