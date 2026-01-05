// In meal_preferences_model.dart, update the class:

class MealPreferencesModel {
  final String? mealType;
  final String? allergies;
  final String? typeOfTest;
  final List<String>? ingredients;
  final String? ingredientCategory;
  final List<String>? foodPreparationMaterials;
  final String? breadType;
  final String? riceType;
  final List<String>? sproutsMaterial;
  final Set<String> selectedTestTypes;

  MealPreferencesModel({
    this.mealType,
    this.allergies,
    this.typeOfTest,
    this.ingredients,
    this.ingredientCategory,
    this.foodPreparationMaterials,
    this.breadType,
    this.riceType,
    this.sproutsMaterial,
    required this.selectedTestTypes,
  });

  Map<String, dynamic> toApiJson() {
    return {
      'meal_type': mealType?.toLowerCase().replaceAll(' ', '_') ?? '',
      'allergies': allergies ?? '',
      'type_of_test': selectedTestTypes.join(', '),
      'ingredients': ingredients ?? [],
      'ingredient_category': ingredientCategory?.toLowerCase() ?? '',
      'food_preparation_materials': foodPreparationMaterials ?? [],
      'bread_type': breadType ?? '',
      'rice_type': riceType ?? '',
      'sprouts_material': sproutsMaterial ?? [],
    };
  }

  // ... rest of the model code ...
}