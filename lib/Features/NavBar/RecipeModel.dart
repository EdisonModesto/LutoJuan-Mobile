class RecipeModel {
  final List<Recipe>? recipes;
  final List<Ingredient>? ingredients;

  RecipeModel({
    this.recipes,
    this.ingredients,
  });

  RecipeModel.fromJson(Map<String, dynamic> json)
      :
        recipes = (json['recipes'] as List?)?.map((dynamic e) => Recipe.fromJson(e as Map<String,dynamic>)).toList(),
        ingredients = (json['ingredients'] as List?)?.map((dynamic e) => Ingredient.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'recipes' : recipes?.map((e) => e.toJson()).toList(),
    "ingredients": ingredients?.map((e) => e.toJson()).toList(),
  };
}

class Recipe {
  String recipeName;
  String recipeDescription;
  String recipeCalories;
  String recipeServingSize;
  String recipeSourceUrl;
  List<Ingredient> recipeIngredients;
  String recipeInstructions;
  String recipeImageUrl;

  Recipe({
    required this.recipeName,
    required this.recipeDescription,
    required this.recipeCalories,
    required this.recipeServingSize,
    required this.recipeSourceUrl,
    required this.recipeIngredients,
    required this.recipeInstructions,
    required this.recipeImageUrl,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<dynamic> ingredientsJson = json['recipe_ingredients'] ?? [];
    List<Ingredient> ingredients = ingredientsJson.map((ingredientJson) => Ingredient.fromJson(ingredientJson)).toList();

    return Recipe(
      recipeName: json['recipe_name'] ?? '',
      recipeDescription: json['recipe_description'] ?? '',
      recipeCalories: json['recipe_calories'] ?? '',
      recipeServingSize: json['recipe_servingSize'] ?? '',
      recipeSourceUrl: json['recipe_source_url'] ?? '',
      recipeIngredients: ingredients,
      recipeInstructions: json['recipe_instructions'] ?? '',
      recipeImageUrl: json['recipe_image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'recipe_name': recipeName,
    'recipe_description': recipeDescription,
    'recipe_calories': recipeCalories,
    'recipe_source_url': recipeSourceUrl,
    'recipe_ingredients': recipeIngredients.map((ingredient) => ingredient.toJson()).toList(),
    'recipe_instructions': recipeInstructions,
    'recipe_image_url': recipeImageUrl,
  };
}

class Ingredient {
  String name;
  String calories;
  String quantity;

  Ingredient({
    required this.name,
    required this.calories,
    required this.quantity,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'] ?? '',
      calories: json['calories'] ?? '',
      quantity: json['quantity'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'calories': calories,
    'quantity': quantity,
  };
}
