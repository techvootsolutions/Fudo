class FitnessPlanModel {
  final String? age;
  final String? weight;
  final String? height;
  final String? fitnessPlan; // Weight loss, Weight Gain, Muscle building, Fat burning
  final String? gender;
  final String? disease;
  final String? lifestyle;
  final String? allergies;
  final String? workoutType; // Gym, Indoor, Calisthenic, Outdoor, Gymnastic
  final String? workoutIntenseType;
  final String? workoutTime;

  FitnessPlanModel({
    this.age,
    this.weight,
    this.height,
    this.fitnessPlan,
    this.gender,
    this.disease,
    this.lifestyle,
    this.allergies,
    this.workoutType,
    this.workoutIntenseType,
    this.workoutTime,
  });

  // Convert fitness plan display value to API value
  String _convertFitnessPlanToApi(String? value) {
    if (value == null) return '';
    switch (value.toLowerCase()) {
      case 'weight loss':
        return 'weight_loss';
      case 'weight gain':
        return 'weight_gain';
      case 'muscle building':
        return 'muscle_building';
      case 'fat burning':
        return 'fat_burning';
      default:
        return value.toLowerCase().replaceAll(' ', '_');
    }
  }

  // Convert gender to lowercase for API
  String _convertGenderToApi(String? value) {
    if (value == null) return '';
    return value.toLowerCase();
  }

  // Convert workout type to lowercase for API
  String _convertWorkoutTypeToApi(String? value) {
    if (value == null) return '';
    return value.toLowerCase();
  }

  // Convert to API JSON format
  Map<String, dynamic> toApiJson() {
    return {
      'age': age != null ? int.tryParse(age!) : null,
      'weight': weight != null ? double.tryParse(weight!) : null,
      'height': height != null ? int.tryParse(height!) : null,
      'gender': _convertGenderToApi(gender),
      'fitness_plan': _convertFitnessPlanToApi(fitnessPlan),
      'disease': disease ?? 'None',
      'lifestyle': lifestyle ?? '',
      'allergies': allergies ?? '',
      'workout_type': _convertWorkoutTypeToApi(workoutType),
      'workout_intense_type': workoutIntenseType ?? '',
      'workout_time': workoutTime ?? '',
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'weight': weight,
      'height': height,
      'fitnessPlan': fitnessPlan,
      'gender': gender,
      'disease': disease,
      'lifestyle': lifestyle,
      'allergies': allergies,
      'workoutType': workoutType,
      'workoutIntenseType': workoutIntenseType,
      'workoutTime': workoutTime,
    };
  }
}

