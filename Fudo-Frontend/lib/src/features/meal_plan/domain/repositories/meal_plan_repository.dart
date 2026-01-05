import 'dart:convert';

import 'package:fudo/src/core/network/api_client/api_client.dart';
import 'package:fudo/src/core/network/api_service/api_constants.dart';
import 'package:fudo/src/core/network/response_method/response.dart';
import 'package:fudo/src/core/utils/constants/app_const_functions.dart';

class MealPlanRepository {
  final ApiClient apiClient;
  MealPlanRepository(this.apiClient);

  /// Get Meal Plan
  Future<Response<Map<String, dynamic>>> getMealPlan({
    String planType = 'daily',
    bool useFeedback = false,
  }) {
    final body = {
      // "action": "meal_plan",
      "action": "health_recommendations",
      "data": {
        "plan_type": planType,
        "use_feedback": useFeedback,
      },
    };
    return apiClient.post<Map<String, dynamic>>(
      ApiConstants.mealPlanUrl,
      (p0) => Map<String, dynamic>.from(p0),
      body: jsonEncode(body),
      headers: commonHeaderWithToken(),
    );
  }

  /// Update Meal Status
  Future<Response<Map<String, dynamic>>> updateMealStatus({
    required dynamic argument,
  }) {
    return apiClient.put<Map<String, dynamic>>(
      ApiConstants.mealPlanStatusUrl, // You'll need to add this constant
      (p0) => Map<String, dynamic>.from(p0),
      body: argument,
      headers: commonHeaderWithToken(),
    );
  }
}

