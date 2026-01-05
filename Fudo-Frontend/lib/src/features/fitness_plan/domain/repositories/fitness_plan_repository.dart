import 'package:fudo/src/core/network/api_client/api_client.dart';
import 'package:fudo/src/core/network/api_service/api_constants.dart';
import 'package:fudo/src/core/network/response_method/response.dart';
import 'package:fudo/src/core/utils/constants/app_const_functions.dart';

class FitnessPlanRepository {
  final ApiClient apiClient;
  FitnessPlanRepository(this.apiClient);

  ///Submit Health Details
  Future<Response<Map<String, dynamic>>> submitHealthDetails({required dynamic argument}) {
    return apiClient.post<Map<String, dynamic>>(
      ApiConstants.healthDetailsUrl,
      (p0) => Map<String, dynamic>.from(p0),
      body: argument,
      headers: commonHeaderWithToken(),
    );
  }
}

