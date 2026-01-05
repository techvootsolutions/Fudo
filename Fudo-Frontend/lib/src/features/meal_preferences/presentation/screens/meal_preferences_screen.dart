import 'package:flutter/material.dart';
import 'package:fudo/injection_container.dart' show sl;
import 'package:fudo/src/features/meal_preferences/presentation/provider/meal_preferences_provider.dart';
import 'package:provider/provider.dart';

class MealPreferencesScreen extends StatelessWidget {
  const MealPreferencesScreen({super.key});

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider<MealPreferencesProvider>(
      create: (_) => sl<MealPreferencesProvider>()..init(),
      child: Builder(builder: (context) => const MealPreferencesScreen()),
    );
  }

 void _showIngredientsDialog(BuildContext context) async {
  final mealProvider = Provider.of<MealPreferencesProvider>(context, listen: false);
  // Create a local copy of the selected ingredients
  final tempSelectedIngredients = Set<String>.from(mealProvider.selectedIngredients);

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: const Text("Select Ingredients"),
            content: Container(
              width: double.maxFinite,
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: mealProvider.getAvailableIngredients().length,
                  itemBuilder: (context, index) {
                    final ingredient = mealProvider.getAvailableIngredients()[index];
                    return CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(ingredient),
                      value: tempSelectedIngredients.contains(ingredient),
                      onChanged: (bool? isChecked) {
                        setStateDialog(() {
                          if (isChecked == true) {
                            tempSelectedIngredients.add(ingredient);
                          } else {
                            tempSelectedIngredients.remove(ingredient);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Update the provider with the new selection
                  mealProvider.selectedIngredients.clear();
                  mealProvider.selectedIngredients.addAll(tempSelectedIngredients);
                  if (mealProvider.selectedIngredients.isNotEmpty) {
                    mealProvider.ingredientsError = null;
                  }
                  mealProvider.notifyListeners();
                  Navigator.of(context).pop();
                },
                child: const Text('Done'),
              ),
            ],
          );
        },
      );
    },
  );
}

  void _showTastePreferencesDialog(BuildContext context) async {
    final mealProvider = Provider.of<MealPreferencesProvider>(context, listen: false);
    // Create a local copy of the selected test types
    final tempSelectedTestTypes = Set<String>.from(mealProvider.selectedTestTypes);
    final allAboveOption = mealProvider.allAboveOption;
    final baseOptions = mealProvider.typeOfTestOptions.where((t) => t != allAboveOption).toList();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            bool isAllSelected = tempSelectedTestTypes.length == baseOptions.length;
            
            return AlertDialog(
              title: const Text("Select Taste Preferences"),
              content: Container(
                width: double.maxFinite,
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: mealProvider.typeOfTestOptions.length,
                    itemBuilder: (context, index) {
                      final type = mealProvider.typeOfTestOptions[index];
                      bool isChecked;
                      
                      if (type == allAboveOption) {
                        isChecked = isAllSelected;
                      } else {
                        isChecked = tempSelectedTestTypes.contains(type);
                      }
                      
                      return CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(type),
                        value: isChecked,
                        onChanged: (bool? isChecked) {
                          setStateDialog(() {
                            if (type == allAboveOption) {
                              if (isChecked == true) {
                                // Select all base options
                                tempSelectedTestTypes.clear();
                                tempSelectedTestTypes.addAll(baseOptions);
                              } else {
                                // Deselect all
                                tempSelectedTestTypes.clear();
                              }
                            } else {
                              if (isChecked == true) {
                                tempSelectedTestTypes.add(type);
                              } else {
                                tempSelectedTestTypes.remove(type);
                              }
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // Update the provider with the new selection
                    mealProvider.selectedTestTypes.clear();
                    mealProvider.selectedTestTypes.addAll(tempSelectedTestTypes);
                    if (mealProvider.selectedTestTypes.isNotEmpty) {
                      mealProvider.typeOfTestError = null;
                    }
                    mealProvider.notifyListeners();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }
  void _showFoodPreparationMaterialsDialog(
    BuildContext context,
    MealPreferencesProvider provider,
  ) async {
    // Create a local copy of the selected food preparation materials
    final tempFoodPreparationMaterials = Set<String>.from(provider.selectedFoodPreparationMaterials);

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: const Text("Select Oils and Spices"),
            content: Container(
              width: double.maxFinite,
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.foodPreparationMaterials.length,
                  itemBuilder: (context, index) {
                    final material = provider.foodPreparationMaterials[index];
                    return CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(material),
                      value: tempFoodPreparationMaterials.contains(material),
                      onChanged: (bool? isChecked) {
                        setStateDialog(() {
                          if (isChecked == true) {
                            tempFoodPreparationMaterials.add(material);
                          } else {
                            tempFoodPreparationMaterials.remove(material);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Update the provider with the new selection
                  provider.selectedFoodPreparationMaterials.clear();
                  provider.selectedFoodPreparationMaterials.addAll(tempFoodPreparationMaterials);
                  if (provider.selectedFoodPreparationMaterials.isNotEmpty) {
                    provider.foodPreparationMaterialsError = null;
                  }
                  provider.notifyListeners();
                  Navigator.of(context).pop();
                },
                child: const Text('Done'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showSproutsMaterialDialog(
    BuildContext context,
    MealPreferencesProvider provider,
  ) {
      final tempSelectedIngredients = Set<String>.from(provider.selectedSproutsMaterial);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: const Text("Select Sprouts Material"),
            content: Container(
                          width: double.maxFinite,

              child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: ListView.builder(
                                      shrinkWrap: true,

                    itemCount: provider.sproutsMaterialOptions.length,
                    itemBuilder: (context, index) {
                      final material = provider.sproutsMaterialOptions[index];
                      return CheckboxListTile(
                        title: Text(material),
                        value: tempSelectedIngredients.contains(material),
                      onChanged: (bool? isChecked) {
                             setStateDialog(() {
                          if (isChecked == true) {
                            tempSelectedIngredients.add(material);
                          } else {
                            tempSelectedIngredients.remove(material);
                          }
                        });                                                   setStateDialog(() {
              
                          // provider.toggleSproutsMaterial(material);
                                                                              });
                        },
                      );
                    },
                  ),
                ),
            ),actions: [
               TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
                TextButton(
                onPressed: () {
                  // Update the provider with the new selection
                  provider.selectedSproutsMaterial.clear();
                  provider.selectedSproutsMaterial.addAll(tempSelectedIngredients);
                  if (provider.selectedSproutsMaterial.isNotEmpty) {
                    provider.sproutsMaterialError = null;
                  }
                  provider.notifyListeners();
                  Navigator.of(context).pop();
                },
                child: const Text('Done'),
              ),
            ],
          );
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealProvider = Provider.of<MealPreferencesProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Set Your Meal Preferences",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Meal Type Dropdown
            DropdownButtonFormField<String>(
              value: mealProvider.mealType,
              decoration: InputDecoration(
                labelText: "Meal Type",
                prefixIcon: const Icon(Icons.restaurant),
                border: const OutlineInputBorder(),
                errorText: mealProvider.mealTypeError,
                isDense: true,
              ),
              selectedItemBuilder: (BuildContext context) {
                return mealProvider.mealTypeOptions.map((String option) {
                  return SizedBox(
                    width: double.infinity,
                    child: Text(
                      option,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  );
                }).toList();
              },
              items: mealProvider.mealTypeOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    option,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                );
              }).toList(),
              onChanged: (val) => mealProvider.setMealType(val),
            ),
            const SizedBox(height: 20),

            // Allergies Text Field
            TextField(
              onChanged: (val) => mealProvider.setAllergies(val),
              decoration: const InputDecoration(
                labelText: "Allergies (Optional)",
                hintText: "Enter any allergies",
                prefixIcon: Icon(Icons.warning),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Taste Preferences Selection Button
            OutlinedButton(
              onPressed: () => _showTastePreferencesDialog(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.centerLeft,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.restaurant_menu),
                    const SizedBox(width: 8),
                    Text(
                      mealProvider.selectedTestTypes.isEmpty
                          ? "Select Taste Preferences"
                          : "Taste Preferences (${mealProvider.selectedTestTypes.length})",
                    ),
                  ],
                ),
              ),
            ),
            if (mealProvider.typeOfTestError != null) ...[
              const SizedBox(height: 5),
              Text(
                mealProvider.typeOfTestError!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 12,
                ),
              ),
            ],
            if (mealProvider.selectedTestTypes.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: mealProvider.selectedTestTypes.map((type) {
                  return Chip(
                    label: Text(type),
                    onDeleted: () => mealProvider.toggleTestType(type),
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 20),

            // Ingredients Selection Button
            if (mealProvider.mealType != null &&
                mealProvider.mealType!.isNotEmpty) ...[
              OutlinedButton(
                onPressed: () => _showIngredientsDialog(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.centerLeft,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.checklist),
                      const SizedBox(width: 8),
                      Text(
                        mealProvider.selectedIngredients.isEmpty
                            ? "Select Ingredients"
                            : "Ingredients (${mealProvider.selectedIngredients.length})",
                      ),
                    ],
                  ),
                ),
              ),
              if (mealProvider.ingredientsError != null) ...[
                const SizedBox(height: 5),
                Text(
                  mealProvider.ingredientsError!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
            if (mealProvider.selectedIngredients.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: mealProvider.selectedIngredients.take(5).map((
                  ingredient,
                ) {
                  return Chip(
                    label: Text(ingredient),
                    onDeleted: () => mealProvider.toggleIngredient(ingredient),
                  );
                }).toList(),
              ),
              if (mealProvider.selectedIngredients.length > 5)
                Text(
                  " + ${mealProvider.selectedIngredients.length - 5} more",
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
            ],
            const SizedBox(height: 20),

            // Food Preparation Materials Button
            OutlinedButton(
              onPressed: () =>
                  _showFoodPreparationMaterialsDialog(context, mealProvider),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.centerLeft,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.kitchen),
                    const SizedBox(width: 8),
                    Text(
                      mealProvider.selectedFoodPreparationMaterials.isEmpty
                          ? "Select Oils and Spices"
                          : "Oils and Spices (${mealProvider.selectedFoodPreparationMaterials.length})",
                    ),
                  ],
                ),
              ),
            ),
            if (mealProvider.foodPreparationMaterialsError != null) ...[
              const SizedBox(height: 5),
              Text(
                mealProvider.foodPreparationMaterialsError!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 12,
                ),
              ),
            ],
            if (mealProvider.selectedFoodPreparationMaterials.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: mealProvider.selectedFoodPreparationMaterials
                    .take(5)
                    .map((material) {
                      return Chip(
                        label: Text(material),
                        onDeleted: () => mealProvider
                            .toggleFoodPreparationMaterial(material),
                      );
                    })
                    .toList(),
              ),
              if (mealProvider.selectedFoodPreparationMaterials.length > 5)
                Text(
                  " + ${mealProvider.selectedFoodPreparationMaterials.length - 5} more",
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
            ],
            const SizedBox(height: 20),

            // Bread Type Dropdown
            DropdownButtonFormField<String>(
              value: mealProvider.breadType,
              decoration: InputDecoration(
                labelText: "Bread Type",
                prefixIcon: const Icon(Icons.bakery_dining),
                border: const OutlineInputBorder(),
                errorText: mealProvider.breadTypeError,
                isDense: true,
              ),
              selectedItemBuilder: (BuildContext context) {
                return mealProvider.breadTypeOptions.map((String option) {
                  return SizedBox(
                    width: double.infinity,
                    child: Text(
                      option,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  );
                }).toList();
              },
              items: mealProvider.breadTypeOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    option,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                );
              }).toList(),
              onChanged: (val) => mealProvider.setBreadType(val),
            ),
            const SizedBox(height: 20),

            // Rice Type Dropdown
            DropdownButtonFormField<String>(
              value: mealProvider.riceType,
              decoration: InputDecoration(
                labelText: "Rice Type",
                prefixIcon: const Icon(Icons.rice_bowl),
                border: const OutlineInputBorder(),
                errorText: mealProvider.riceTypeError,
                isDense: true,
              ),
              selectedItemBuilder: (BuildContext context) {
                return mealProvider.riceTypeOptions.map((String option) {
                  return SizedBox(
                    width: double.infinity,
                    child: Text(
                      option,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  );
                }).toList();
              },
              items: mealProvider.riceTypeOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    option,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                );
              }).toList(),
              onChanged: (val) => mealProvider.setRiceType(val),
            ),
            const SizedBox(height: 20),

            // Sprouts Material Button
            OutlinedButton(
              onPressed: () =>
                  _showSproutsMaterialDialog(context, mealProvider),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.centerLeft,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.eco),
                    const SizedBox(width: 8),
                    Text(
                      mealProvider.selectedSproutsMaterial.isEmpty
                          ? "Select Sprouts Material"
                          : "Sprouts Material (${mealProvider.selectedSproutsMaterial.length})",
                    ),
                  ],
                ),
              ),
            ),
            if (mealProvider.sproutsMaterialError != null) ...[
              const SizedBox(height: 5),
              Text(
                mealProvider.sproutsMaterialError!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 12,
                ),
              ),
            ],
            if (mealProvider.selectedSproutsMaterial.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: mealProvider.selectedSproutsMaterial.map((material) {
                  return Chip(
                    label: Text(material),
                    onDeleted: () =>
                        mealProvider.toggleSproutsMaterial(material),
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 30),

            // Submit Button
            ElevatedButton(
              onPressed: mealProvider.isLoading
                  ? null
                  : () {
                    print("mealProvider.isLoading");
                      mealProvider.submitForm();
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: mealProvider.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      "SUBMIT",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
