class HealthDetail {
  final int? id;
  final int? userId;
  final int? age;
  final String? weight;
  final String? height;
  final String? gender;
  final String? fitnessPlan;
  final String? disease;
  final String? lifestyle;
  final String? allergies;
  final String? workoutType;
  final String? workoutIntenseType;
  final String? workoutTime;
  final String? mealType;
  final String? typeOfTest;
  final String? ingredients;
  final String? ingredientCategory;
  final String? foodPreparationMaterials;
  final String? breadType;
  final String? riceType;
  final String? sproutsMaterial;
  final String? createdAt;
  final String? updatedAt;

  HealthDetail({
    this.id,
    this.userId,
    this.age,
    this.weight,
    this.height,
    this.gender,
    this.fitnessPlan,
    this.disease,
    this.lifestyle,
    this.allergies,
    this.workoutType,
    this.workoutIntenseType,
    this.workoutTime,
    this.mealType,
    this.typeOfTest,
    this.ingredients,
    this.ingredientCategory,
    this.foodPreparationMaterials,
    this.breadType,
    this.riceType,
    this.sproutsMaterial,
    this.createdAt,
    this.updatedAt,
  });

  factory HealthDetail.fromJson(Map<String, dynamic> json) {
    return HealthDetail(
      id: json["id"] as int?,
      userId: json["user_id"] as int?,
      age: json["age"] as int?,
      weight: json["weight"] as String?,
      height: json["height"] as String?,
      gender: json["gender"] as String?,
      fitnessPlan: json["fitness_plan"] as String?,
      disease: json["disease"] as String?,
      lifestyle: json["lifestyle"] as String?,
      allergies: json["allergies"] as String?,
      workoutType: json["workout_type"] as String?,
      workoutIntenseType: json["workout_intense_type"] as String?,
      workoutTime: json["workout_time"] as String?,
      mealType: json["meal_type"] as String?,
      typeOfTest: json["type_of_test"] as String?,
      ingredients: json["ingredients"] as String?,
      ingredientCategory: json["ingredient_category"] as String?,
      foodPreparationMaterials: json["food_preparation_materials"] as String?,
      breadType: json["bread_type"] as String?,
      riceType: json["rice_type"] as String?,
      sproutsMaterial: json["sprouts_material"] as String?,
      createdAt: json["created_at"] as String?,
      updatedAt: json["updated_at"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "age": age,
      "weight": weight,
      "height": height,
      "gender": gender,
      "fitness_plan": fitnessPlan,
      "disease": disease,
      "lifestyle": lifestyle,
      "allergies": allergies,
      "workout_type": workoutType,
      "workout_intense_type": workoutIntenseType,
      "workout_time": workoutTime,
      "meal_type": mealType,
      "type_of_test": typeOfTest,
      "ingredients": ingredients,
      "ingredient_category": ingredientCategory,
      "food_preparation_materials": foodPreparationMaterials,
      "bread_type": breadType,
      "rice_type": riceType,
      "sprouts_material": sproutsMaterial,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}

