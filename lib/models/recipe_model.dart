import 'package:uuid/uuid.dart';

enum IngredientCategory {
  protein,
  vegetable,
  fruit,
  grains
  dairy,
  spices,
  herbs,
  condiments,
  other
}

enum DietaryTag {
  vegetarian,
  vegan,
  glutenFree,
  dairyFree,
  nutFree,
  kosher,
  halal,
  lowSodium
}

enum MealCategory {
  breakfast,
  lunch,
  dinner,
  sides,
  snacks
}

class Ingredient {
  final String id;
  String name;
  double quantity;
  String unit; 

   Ingredient({
    String? id,
    required this.name,
    this.quantity = 1.0,
    this.unit = '',
  }) :id = id ?? const Uuid().v4();

  //Method to display ingredient with optional nutritional info
  String getIngredient({bool includeNutrition = false}){
    String baseString = '$quantity $unit $name';

    if (includeNutrition && calories != null){
      baseString += ' (${calories!.toStringAsFixed(0)}cal)';
    }

    return baseString
  }
  
 
}

class Recipe {
  String id;
  String name;
  MealCategory category;
  List<Ingredient> ingredients;
  String instructions;
  String? imageUrl;
  int? prepTime;
  int? cookTime;
  int? servings;
  String? notes;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.ingredients,
    this.instructions = '',
    this.imageUrl,
    this.prepTime,
    this.cookTime,
    this.servings,
    this.notes,
  });

  int get totalTime => (prepTime ?? 0) + (cookTime ?? 0);

  void addIngredient(Ingredient ingredient) {
    ingredients.add(ingredient);
  }
  void removeIngredient(Ingredient ingredient) {
    ingredients.remove(ingredient)
  }
}

class RecipeBook {
  List<Recipe> recipes = [];

  void addRecipe(Recipe recipe) {
    recipes.add(recipe);
  }

  void removeRecipe(Recipe recipe) {
    recipes.remove(recipe);
  }

  List<Recipe> getRecipeByCategory(MealCategory category) {
    return recipes.where((recipe) => recipe.category == category).toList();
  }

  Recipe? findRecipeByName(String name) {
    try {
      return recipes.firstWhere((recipe) => recipe.name.toLowerCase() == name.toLowerCase());
    } catch (e) {
      return null;
    }
  }
}