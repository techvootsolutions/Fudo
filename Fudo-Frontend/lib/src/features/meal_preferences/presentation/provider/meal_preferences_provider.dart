import 'dart:convert';

import 'package:fudo/base_notifier.dart';
import 'package:fudo/src/core/router/app_routes.dart';
import 'package:fudo/src/core/utils/constants/app_const_functions.dart';
import 'package:fudo/src/core/utils/navigation/navigation_services.dart';
import 'package:fudo/src/features/meal_preferences/data/models/meal_preferences_model.dart';
import 'package:fudo/src/features/meal_preferences/domain/repositories/meal_preferences_repository.dart';

class MealPreferencesProvider extends BaseNotifier {
  final MealPreferencesRepository mealPreferencesRepository;

  MealPreferencesProvider(this.mealPreferencesRepository);

  // Form fields
  String? mealType;
  String? allergies;
  String? typeOfTest;
  List<String> selectedIngredients = [];
  String? ingredientCategory;
  List<String> selectedFoodPreparationMaterials = [];
  String? breadType;
  String? riceType;
  List<String> selectedSproutsMaterial = [];

  bool isLoading = false;

  // Error messages
  String? mealTypeError;
  String? typeOfTestError;
  String? ingredientCategoryError;
  String? ingredientsError;
  String? foodPreparationMaterialsError;
  String? breadTypeError;
  String? riceTypeError;
  String? sproutsMaterialError;

  // Dropdown options
  final List<String> mealTypeOptions = [
    'Veg',
    'Non Veg',
    'Vegan',
  ];
// Add these fields at the top of the class with other fields
Set<String> selectedTestTypes = {};
bool get isAllSelected => selectedTestTypes.length == 3; // Sweet, Spicy, Mild
final String allAboveOption = 'All above';

// Update the typeOfTestOptions list
final List<String> typeOfTestOptions = ['Sweet', 'Spicy', 'Mild', 'All above'];



  final List<String> ingredientCategoryOptions = [
    'Veggies',
    'Meat',
  ];

  // Ingredients lists
  final List<String> veggieIngredients = [
    // Leafy & Greens
    'Palak (Spinach)',
    'Methi (Fenugreek)',
    'Coriander',
    'Dill (Suva)',
    'Cabbage',
    'Lettuce',
    // Common Vegetables
    'Potato',
    'Onion',
    'Tomato',
    'Brinjal (Ringan)',
    'Bottle gourd (Dudhi)',
    'Ridge gourd (Turai)',
    'Sponge gourd (Galka)',
    'Tinda',
    'Pumpkin',
    'Bitter gourd (Karela)',
    'Okra (Bhindi)',
    'Capsicum',
    'Carrot',
    'Beetroot',
    'Cauliflower',
    'Green peas',
    'Sweet corn',
    // Quick-cook Veggies
    'Cucumber',
    'Radish',
    'Spring onion',
    'Zucchini (urban homes)',
    // Sprouts
    'Moong sprouts',
    'Matki sprouts',
    'Kala chana sprouts',
    'Chana sprouts',
    'Mixed sprouts (moong + matki)',
    // Legumes & Beans (Kathol)
    'Chana (Whole)',
    'Kabuli chana (Chole)',
    'Kala chana',
    'Rajma',
    'Lobia (Chawli)',
    'Vatana (White peas)',
    'Tuvar dana (fresh pigeon peas)',
    'Val (Hyacinth beans)',
    'Papdi lilva',
    'Green chana',
    // Vegan options
    'Tofu',
    'Soya chunks',
    'Soya granules',
    'Chickpeas',
    'Lentils (all dals)',
    'Peanuts',
    'Dates',
    'Raisins',
    'Jaggery (Gol)',
    'Seeds (flax, chia, pumpkin, sunflower)',
  ];

  final List<String> meatIngredients = [
    'Chicken breast',
    'Chicken thigh',
    'Chicken curry cut',
    'Eggs',
    'Goat mutton',
    'Mutton mince (keema)',
    'Rohu',
    'Catla',
    'Pomfret',
    'Surmai (Kingfish)',
    'Fish fillets (frozen)',
  ];

  // Food preparation materials (Oils and Spices)
  final List<String> foodPreparationMaterials = [
    // Oils
    'Olive oil',
    'Groundnut oil',
    'Mustard oil',
    'Coconut oil',
    'Sesame oil',
    // Common Spices
    'Turmeric',
    'Cumin',
    'Coriander powder',
    'Red chili powder',
    'Garam masala',
    'Black pepper',
    'Cardamom',
    'Cinnamon',
    'Cloves',
    'Bay leaves',
    'Fenugreek seeds',
    'Mustard seeds',
    'Asafoetida (Hing)',
    'Ginger',
    'Garlic',
    'Curry leaves',
  ];

  // Bread types
  final List<String> breadTypeOptions = [
    'Rotli / Phulka',
    'Bhakri (Bajra / Jowar)',
    'Thepla',
    'Paratha',
    'Puri',
    'Bread (white / brown)',
    'Multigrain bread',
    'Pav',
    'Whole wheat',
  ];

  // Rice types
  final List<String> riceTypeOptions = [
    'Regular white rice',
    'Basmati rice',
    'Brown rice',
    'Hand-pounded rice (semi-polished)',
  ];

  // Sprouts materials
  final List<String> sproutsMaterialOptions = [
    'Mung beans',
    'Matki sprouts',
    'Kala chana sprouts',
    'Chana sprouts',
    'Chickpeas',
    'Mixed sprouts (moong + matki)',
  ];

  void init() {
    notifyListeners();
  }

  void setMealType(String? val) {
    mealType = val;
    if (mealType == null || mealType!.isEmpty) {
      mealTypeError = "Meal type is required";
    } else {
      mealTypeError = null;
      // Clear selected ingredients and error when meal type changes
      selectedIngredients.clear();
      ingredientsError = null;
    }
    notifyListeners();
  }

  void setAllergies(String? val) {
    allergies = val;
    notifyListeners();
  }

  void setTypeOfTest(String? val) {
    typeOfTest = val;
    if (typeOfTest == null || typeOfTest!.isEmpty) {
      typeOfTestError = "Type of test is required";
    } else {
      typeOfTestError = null;
    }
    notifyListeners();
  }

  void setIngredientCategory(String? val) {
    ingredientCategory = val;
    if (ingredientCategory == null || ingredientCategory!.isEmpty) {
      ingredientCategoryError = "Ingredient category is required";
    } else {
      ingredientCategoryError = null;
      // Clear selected ingredients and error when category changes
      selectedIngredients.clear();
      ingredientsError = null;
    }
    notifyListeners();
  }

void toggleIngredient(String ingredient) {
  if (selectedIngredients.contains(ingredient)) {
    selectedIngredients.remove(ingredient);
  } else {
    selectedIngredients.add(ingredient);
  }
  if (selectedIngredients.isNotEmpty) {
    ingredientsError = null;
  }
  notifyListeners();
}

  bool isIngredientSelected(String ingredient) {
    return selectedIngredients.contains(ingredient);
  }

  List<String> getAvailableIngredients() {
    if (mealType == 'Veg' || mealType == 'Vegan') {
      return veggieIngredients;
    } else if (mealType == 'Non Veg') {
      return meatIngredients;
    }
    return [];
  }

  void toggleFoodPreparationMaterial(String material) {
    if (selectedFoodPreparationMaterials.contains(material)) {
      selectedFoodPreparationMaterials.remove(material);
    } else {
      selectedFoodPreparationMaterials.add(material);
    }
    // Clear error when materials are selected
    if (selectedFoodPreparationMaterials.isNotEmpty) {
      foodPreparationMaterialsError = null;
    }
    notifyListeners();
  }

  bool isFoodPreparationMaterialSelected(String material) {
    return selectedFoodPreparationMaterials.contains(material);
  }

  void setBreadType(String? val) {
    breadType = val;
    if (breadType == null || breadType!.isEmpty) {
      breadTypeError = "Bread type is required";
    } else {
      breadTypeError = null;
    }
    notifyListeners();
  }

  void setRiceType(String? val) {
    riceType = val;
    if (riceType == null || riceType!.isEmpty) {
      riceTypeError = "Rice type is required";
    } else {
      riceTypeError = null;
    }
    notifyListeners();
  }

  void toggleSproutsMaterial(String material) {
    if (selectedSproutsMaterial.contains(material)) {
      selectedSproutsMaterial.remove(material);
    } else {
      selectedSproutsMaterial.add(material);
    }
    // Clear error when sprouts material is selected
    if (selectedSproutsMaterial.isNotEmpty) {
      sproutsMaterialError = null;
    }
    notifyListeners();
  }

  bool isSproutsMaterialSelected(String material) {
    return selectedSproutsMaterial.contains(material);
  }

  bool validateForm() {
    bool isValid = true;

    if (mealType == null || mealType!.isEmpty) {
      mealTypeError = "Meal type is required";
      isValid = false;
    }

   if (selectedTestTypes.isEmpty) {
    typeOfTestError = "Please select at least one taste preference";
    isValid = false;
  }

    if (selectedIngredients.isEmpty) {
      ingredientsError = "Please select at least one ingredient";
      isValid = false;
    }

    if (selectedFoodPreparationMaterials.isEmpty) {
      foodPreparationMaterialsError = "Please select at least one oil or spice";
      isValid = false;
    }

    if (breadType == null || breadType!.isEmpty) {
      breadTypeError = "Bread type is required";
      isValid = false;
    }

    if (riceType == null || riceType!.isEmpty) {
      riceTypeError = "Rice type is required";
      isValid = false;
    }

    if (selectedSproutsMaterial.isEmpty) {
      sproutsMaterialError = "Please select at least one sprouts material";
      isValid = false;
    }

    notifyListeners();
    return isValid;
  }

 



// In meal_preferences_provider.dart, update the class fields and methods:



// Add these methods to the class
void toggleTestType(String type) {
  if (type == allAboveOption) {
    if (isAllSelected) {
      selectedTestTypes.clear();
    } else {
      selectedTestTypes = Set.from(typeOfTestOptions.where((t) => t != allAboveOption));
    }
  } else {
    if (selectedTestTypes.contains(type)) {
      selectedTestTypes.remove(type);
    } else {
      selectedTestTypes.add(type);
    }
  }
  
  if (selectedTestTypes.isNotEmpty) {
    typeOfTestError = null;
  }
  
  notifyListeners();
}

bool isTestTypeSelected(String type) {
  if (type == allAboveOption) {
    return isAllSelected;
  }
  return selectedTestTypes.contains(type);
}



// Update the existing getFormData method
MealPreferencesModel getFormData() {
  // Derive ingredientCategory from mealType for API compatibility
  String? derivedIngredientCategory;
  if (mealType == 'Veg' || mealType == 'Vegan') {
    derivedIngredientCategory = 'Veggies';
  } else if (mealType == 'Non Veg') {
    derivedIngredientCategory = 'Meat';
  }
  
  return MealPreferencesModel(
    mealType: mealType,
    allergies: allergies,
    typeOfTest: selectedTestTypes.join(', '),
    ingredients: selectedIngredients,
    ingredientCategory: derivedIngredientCategory,
    foodPreparationMaterials: selectedFoodPreparationMaterials,
    breadType: breadType,
    riceType: riceType,
    sproutsMaterial: selectedSproutsMaterial,
    selectedTestTypes: selectedTestTypes,
  );
}
  Future<void> submitForm() async {
    if (!validateForm()) {
    }else{

    isLoading = true;
    notifyListeners();

    final formData = getFormData();
    final apiJson = formData.toApiJson();
    final body = jsonEncode(apiJson);

    try {
      await mealPreferencesRepository
          .submitMealPreferences(argument: body)
          .then((value) => value.handleResponse(
                onSuccess: (data) {
                  isLoading = false;
                  notifyListeners();
                  NavigationService.pushNamedAndRemoveUntil(AppRoutes.mealPlanScreen);
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
  }

  @override
  void onDispose() {
    // Clean up if needed
  }
}

