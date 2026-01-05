import 'dart:convert';

class MealPlanModel {
  final List<Meal> breakfast;
  final List<Meal> lunch;
  final List<Meal> dinner;

  MealPlanModel({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
  });

  factory MealPlanModel.fromJson(Map<String, dynamic> json) {
    // Handle the nested response structure
    Map<String, dynamic>? responseData;
    
    if (json['data'] != null) {
      final data = json['data'];
      
      // Convert to Map<String, dynamic> if it's a Map
      Map<String, dynamic>? dataMap;
      if (data is Map<String, dynamic>) {
        dataMap = data;
      } else if (data is Map) {
        dataMap = Map<String, dynamic>.from(data);
      }
      
      if (dataMap != null) {
        final response = dataMap['response'];
        
        if (response is String && response.isNotEmpty) {
          // If response is a string, parse it
          try {
            responseData = jsonDecode(response) as Map<String, dynamic>?;
          } catch (e) {
            // If parsing fails, responseData remains null
          }
        } else if (response is Map) {
          // Convert to Map<String, dynamic>
          responseData = Map<String, dynamic>.from(response);
        } else if (response == null) {
          // Response is null - meal plan might not be generated yet
          // Return empty meal plan
          return MealPlanModel(
            breakfast: [],
            lunch: [],
            dinner: [],
          );
        }
      }
    }

    // Get the meal data
    Map<String, dynamic> mealData = {};
    if (responseData != null && responseData['data'] != null) {
      final data = responseData['data'];
      if (data is Map<String, dynamic>) {
        mealData = data;
      } else if (data is Map) {
        mealData = Map<String, dynamic>.from(data);
      }
    }

    return MealPlanModel(
      breakfast: (mealData['breakfast'] as List<dynamic>?)
              ?.map((meal) {
                if (meal is Map<String, dynamic>) {
                  return Meal.fromJson(meal);
                } else if (meal is Map) {
                  return Meal.fromJson(Map<String, dynamic>.from(meal));
                }
                return null;
              })
              .whereType<Meal>()
              .toList() ??
          [],
      lunch: (mealData['lunch'] as List<dynamic>?)
              ?.map((meal) {
                if (meal is Map<String, dynamic>) {
                  return Meal.fromJson(meal);
                } else if (meal is Map) {
                  return Meal.fromJson(Map<String, dynamic>.from(meal));
                }
                return null;
              })
              .whereType<Meal>()
              .toList() ??
          [],
      dinner: (mealData['dinner'] as List<dynamic>?)
              ?.map((meal) {
                if (meal is Map<String, dynamic>) {
                  return Meal.fromJson(meal);
                } else if (meal is Map) {
                  return Meal.fromJson(Map<String, dynamic>.from(meal));
                }
                return null;
              })
              .whereType<Meal>()
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'breakfast': breakfast.map((meal) => meal.toJson()).toList(),
      'lunch': lunch.map((meal) => meal.toJson()).toList(),
      'dinner': dinner.map((meal) => meal.toJson()).toList(),
    };
  }

  // Helper method to get all meals for a specific type
  List<Meal> getMealsByType(String mealType) {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return breakfast;
      case 'lunch':
        return lunch;
      case 'dinner':
        return dinner;
      default:
        return [];
    }
  }
}

class Meal {
  final String mealName;
  final List<String> ingredients;
  final int calories;
  final int protein;
  final int carbs;
  final int fat;
  final int fiber;
  final String imagePrompt;
  final String imageUrl;

  Meal({
    required this.mealName,
    required this.ingredients,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
    required this.imagePrompt,
    required this.imageUrl,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      mealName: json['meal_name'] as String? ?? 'Unnamed Meal',
      ingredients: (json['ingredients'] as List<dynamic>?)
              ?.map((ingredient) => ingredient.toString())
              .toList() ??
          [],
      calories: (json['calories'] as num?)?.toInt() ?? 0,
      protein: (json['protein'] as num?)?.toInt() ?? 0,
      carbs: (json['carbs'] as num?)?.toInt() ?? 0,
      fat: (json['fat'] as num?)?.toInt() ?? 0,
      fiber: (json['fiber'] as num?)?.toInt() ?? 0,
      imagePrompt: json['image_prompt'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meal_name': mealName,
      'ingredients': ingredients,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'fiber': fiber,
      'image_prompt': imagePrompt,
      'image_url': imageUrl,
    };
  }
}