import 'package:flutter/material.dart';
import 'package:fudo/injection_container.dart' show sl;
import 'package:fudo/src/core/utils/constants/app_const_functions.dart';
import 'package:fudo/src/features/meal_plan/data/models/meal_plan_model.dart';
import 'package:fudo/src/features/meal_plan/presentation/provider/meal_plan_provider.dart';
import 'package:provider/provider.dart';

class MealPlanScreen extends StatelessWidget {
  const MealPlanScreen({super.key});

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider<MealPlanProvider>(
      create: (_) => sl<MealPlanProvider>()..init(),
      child: Builder(builder: (context) => const MealPlanScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealPlanProvider = context.watch<MealPlanProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Meal Plan",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              clearAndGotoLogin();
            },
            icon: const Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              mealPlanProvider.loadMealPlan();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: mealPlanProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : mealPlanProvider.errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        mealPlanProvider.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => mealPlanProvider.loadMealPlan(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : mealPlanProvider.mealPlan == null ||
                      (mealPlanProvider.mealPlan!.breakfast.isEmpty &&
                          mealPlanProvider.mealPlan!.lunch.isEmpty &&
                          mealPlanProvider.mealPlan!.dinner.isEmpty)
                  ? const Center(
                      child: Text('No meal plan available'),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Total Calories Card
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Daily Meal Plan',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Total Calories: ${_calculateTotalCalories(mealPlanProvider.mealPlan!)}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Breakfast Section
                          _buildMealSection(
                            context,
                            mealPlanProvider,
                            'breakfast',
                            'Breakfast',
                            Icons.wb_sunny,
                          ),
                          const SizedBox(height: 20),

                          // Lunch Section
                          _buildMealSection(
                            context,
                            mealPlanProvider,
                            'lunch',
                            'Lunch',
                            Icons.restaurant,
                          ),
                          const SizedBox(height: 20),

                          // Dinner Section
                          _buildMealSection(
                            context,
                            mealPlanProvider,
                            'dinner',
                            'Dinner',
                            Icons.dinner_dining,
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
    );
  }

  Widget _buildMealSection(
    BuildContext context,
    MealPlanProvider provider,
    String mealType,
    String mealTitle,
    IconData icon,
  ) {
    final meals = provider.getMealsByType(mealType);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Meal Header
            Row(
              children: [
                Icon(icon, size: 28),
                const SizedBox(width: 12),
                Text(
                  mealTitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Meal List
            if (meals.isNotEmpty)
              ...meals.map((meal) => _buildMealCard(
                    context,
                    meal,
                  ))
            else
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'No meals available',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealCard(
    BuildContext context,
    Meal meal,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Meal Name
            Text(
              meal.mealName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            // Ingredients
            if (meal.ingredients.isNotEmpty) ...[
              Text(
                'Ingredients:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: meal.ingredients.map((ingredient) {
                  return Chip(
                    label: Text(
                      ingredient,
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: Colors.blue.shade50,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
            ],
            
            // Nutrition Info
            SingleChildScrollView(
              child: Row(
                children: [
                  _buildNutritionChip('${meal.calories} cal', Colors.orange),
                  const SizedBox(width: 8),
                  _buildNutritionChip('${meal.protein}g protein', Colors.blue),
                  const SizedBox(width: 8),
                  _buildNutritionChip('${meal.carbs}g carbs', Colors.green),
                  const SizedBox(width: 8),
                  _buildNutritionChip('${meal.fat}g fats', Colors.purple),
                  // if (meal.fiber > 0) ...[
                  //   const SizedBox(width: 8),
                  //   _buildNutritionChip('${meal.fiber}g fiber', Colors.brown),
                  // ],
                ],
              ),
            ),
            
            // Image URL (if available)
            // if (meal.imageUrl.isNotEmpty) ...[
            //   const SizedBox(height: 12),
            //   ClipRRect(
            //     borderRadius: BorderRadius.circular(8),
            //     child: Image.network(
            //       meal.imageUrl,
            //       height: 150,
            //       width: double.infinity,
            //       fit: BoxFit.cover,
            //       errorBuilder: (context, error, stackTrace) {
            //         return Container(
            //           height: 150,
            //           color: Colors.grey.shade200,
            //           child: const Icon(Icons.image_not_supported),
            //         );
            //       },
            //     ),
            //   ),
            // ],
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  int _calculateTotalCalories(MealPlanModel mealPlan) {
    int total = 0;
    for (var meal in mealPlan.breakfast) {
      total += meal.calories;
    }
    for (var meal in mealPlan.lunch) {
      total += meal.calories;
    }
    for (var meal in mealPlan.dinner) {
      total += meal.calories;
    }
    return total;
  }
}

