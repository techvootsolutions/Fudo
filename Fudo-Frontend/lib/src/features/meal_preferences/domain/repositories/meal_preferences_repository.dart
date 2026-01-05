import 'package:fudo/src/core/network/api_client/api_client.dart';
import 'package:fudo/src/core/network/api_service/api_constants.dart';
import 'package:fudo/src/core/network/response_method/response.dart';
import 'package:fudo/src/core/utils/constants/app_const_functions.dart';

class MealPreferencesRepository {
  final ApiClient apiClient;
  MealPreferencesRepository(this.apiClient);

  ///Submit Meal Preferences
  Future<Response<Map<String, dynamic>>> submitMealPreferences({required dynamic argument}) {
    return apiClient.put<Map<String, dynamic>>(
      ApiConstants.healthDetailsUrl,
      (p0) => Map<String, dynamic>.from(p0),
      body: argument,
      headers: commonHeaderWithToken(),
    );
  }
}

