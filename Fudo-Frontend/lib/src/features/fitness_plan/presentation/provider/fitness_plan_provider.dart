import 'dart:convert';

import 'package:fudo/base_notifier.dart';
import 'package:fudo/src/core/router/app_routes.dart';
import 'package:fudo/src/core/utils/constants/app_const_functions.dart';
import 'package:fudo/src/core/utils/navigation/navigation_services.dart';
import 'package:fudo/src/features/fitness_plan/data/models/fitness_plan_model.dart';
import 'package:fudo/src/features/fitness_plan/domain/repositories/fitness_plan_repository.dart';

class FitnessPlanProvider extends BaseNotifier {
  final FitnessPlanRepository fitnessPlanRepository;
  
  FitnessPlanProvider(this.fitnessPlanRepository);

  // Form fields
  DateTime? dateOfBirth;
  String? weight;
  String? height;
  String? fitnessPlan;
  String? gender;
  String? disease;
  String? lifestyle;
  String? allergies;
  String? workoutType;
  String? workoutIntenseType;
  String? workoutTime;
  
  bool isLoading = false;

  // Error messages
  String? dateOfBirthError;
  String? weightError;
  String? heightError;
  String? fitnessPlanError;
  String? genderError;
  String? workoutTypeError;
  String? workoutIntenseTypeError;
  String? workoutTimeError;

  // Dropdown options
  final List<String> fitnessPlanOptions = [
    'Weight loss',
    'Weight Gain',
    'Muscle building',
    'Fat burning',
  ];

  final List<String> genderOptions = [
    'Male',
    'Female',
    'Other',
  ];

  final List<String> workoutTypeOptions = [
    'Gym',
    'Indoor',
    'Calisthenic',
    'Outdoor',
    'Gymnastic',
  ];

  final List<String> workoutTimeOptions = [
    '30 minutes',
    '1 hour',
    '2 hours',
    '60 minutes',
    '90 minutes',
    '120 minutes',
    'More then 150 minutes',

  ];

  void init() {
    // Initialize any default values if needed
    notifyListeners();
  }

  void setDateOfBirth(DateTime? date) {
    dateOfBirth = date;
    if (dateOfBirth == null) {
      dateOfBirthError = "Date of birth is required";
    } else {
      dateOfBirthError = null;
    }
    notifyListeners();
  }

  String? getDateOfBirthDisplay() {
    if (dateOfBirth == null) return null;
    // Format: yyyy-MM-dd
    final year = dateOfBirth!.year.toString();
    final month = dateOfBirth!.month.toString().padLeft(2, '0');
    final day = dateOfBirth!.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  int? getCalculatedAge() {
    if (dateOfBirth == null) return null;
    final now = DateTime.now();
    int age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }

  void setWeight(String? val) {
    weight = val;
    if (weight == null || weight!.isEmpty) {
      weightError = "Weight is required";
    } else if (double.tryParse(weight!) == null || double.parse(weight!) <= 0) {
      weightError = "Please enter a valid weight";
    } else {
      weightError = null;
    }
    notifyListeners();
  }

  void setHeight(String? val) {
    height = val;
    if (height == null || height!.isEmpty) {
      heightError = "Height is required";
    } else if (double.tryParse(height!) == null || double.parse(height!) <= 0) {
      heightError = "Please enter a valid height";
    } else {
      heightError = null;
    }
    notifyListeners();
  }

  void setFitnessPlan(String? val) {
    fitnessPlan = val;
    if (fitnessPlan == null || fitnessPlan!.isEmpty) {
      fitnessPlanError = "Fitness plan is required";
    } else {
      fitnessPlanError = null;
    }
    notifyListeners();
  }

  void setGender(String? val) {
    gender = val;
    if (gender == null || gender!.isEmpty) {
      genderError = "Gender is required";
    } else {
      genderError = null;
    }
    notifyListeners();
  }

  void setDisease(String? val) {
    disease = val;
    notifyListeners();
  }

  void setLifestyle(String? val) {
    lifestyle = val;
    notifyListeners();
  }

  void setAllergies(String? val) {
    allergies = val;
    notifyListeners();
  }

  void setWorkoutType(String? val) {
    workoutType = val;
    if (workoutType == null || workoutType!.isEmpty) {
      workoutTypeError = "Workout type is required";
    } else {
      workoutTypeError = null;
    }
    notifyListeners();
  }

  void setWorkoutIntenseType(String? val) {
    workoutIntenseType = val;
    if (workoutIntenseType == null || workoutIntenseType!.isEmpty) {
      workoutIntenseTypeError = "Workout intense type is required";
    } else {
      workoutIntenseTypeError = null;
    }
    notifyListeners();
  }

  void setWorkoutTime(String? val) {
    workoutTime = val;
    if (workoutTime == null || workoutTime!.isEmpty) {
      workoutTimeError = "Workout time is required";
    } else {
      workoutTimeError = null;
    }
    notifyListeners();
  }

  bool validateForm() {
    bool isValid = true;

    if (dateOfBirth == null) {
      dateOfBirthError = "Date of birth is required";
      isValid = false;
    }

    if (weight == null || weight!.isEmpty) {
      weightError = "Weight is required";
      isValid = false;
    }

    if (height == null || height!.isEmpty) {
      heightError = "Height is required";
      isValid = false;
    }

    if (fitnessPlan == null || fitnessPlan!.isEmpty) {
      fitnessPlanError = "Fitness plan is required";
      isValid = false;
    }

    if (gender == null || gender!.isEmpty) {
      genderError = "Gender is required";
      isValid = false;
    }

    if (workoutType == null || workoutType!.isEmpty) {
      workoutTypeError = "Workout type is required";
      isValid = false;
    }

    if (workoutIntenseType == null || workoutIntenseType!.isEmpty) {
      workoutIntenseTypeError = "Workout intense type is required";
      isValid = false;
    }

    if (workoutTime == null || workoutTime!.isEmpty) {
      workoutTimeError = "Workout time is required";
      isValid = false;
    }

    notifyListeners();
    return isValid;
  }

  FitnessPlanModel getFormData() {
    return FitnessPlanModel(
      age: getCalculatedAge()?.toString(),
      weight: weight,
      height: height,
      fitnessPlan: fitnessPlan,
      gender: gender,
      disease: disease,
      lifestyle: lifestyle,
      allergies: allergies,
      workoutType: workoutType,
      workoutIntenseType: workoutIntenseType,
      workoutTime: workoutTime,
    );
  }

  Future<void> submitForm() async {
    if (!validateForm()) {
      return;
    }

    isLoading = true;
    notifyListeners();

    final formData = getFormData();
    final apiJson = formData.toApiJson();
    final body = jsonEncode(apiJson);

    try {
      await fitnessPlanRepository
          .submitHealthDetails(argument: body)
          .then((value) => value.handleResponse(
                onSuccess: (data) {
                  isLoading = false;
                  notifyListeners();
              NavigationService.pushNamedAndRemoveUntil(AppRoutes.mealPreferencesScreen);
                },
                onFailure: (errorMessage) {
                  isLoading = false;
                  errorDialog(
                    errorMessage,
                    NavigationService.navigatorKey.currentContext!,
                  );
                  notifyListeners();
                },
              ));
    } catch (e) {
      isLoading = false;
      errorDialog(
        "Something went wrong. Please try again.",
        NavigationService.navigatorKey.currentContext!,
      );
      notifyListeners();
    }
  }

  @override
  void onDispose() {
    // Clean up if needed
  }
}

