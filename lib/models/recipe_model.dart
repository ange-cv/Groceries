import 'package:uuid/uuid.dart';
import 'dart:math';

enum IngredientCategory {
  protein,
  vegetable,
  fruit,
  grains
  dairy,
  spices,
  herbs,
  condiments,
  nuts,
  seafood,
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
  lowSodium,
  lowCarb,
  keto,
  paleo
}

enum MealCategory {
  breakfast,
  lunch,
  dinner,
  sides,
  snacks,
  dessert,
  appetizer
}

enum UnitType {
  volume,
  weight,
  unknown
}

class UnitConverter {
  static final Map<String, double> volumeConversions = {
    'ml': 1.0,
    'tsp': 4.93,
    'tbsp': 14.79,
    'floz': 29.57,
    'cup': 236.59,
    'pt': 473.18,
    'qt': 946.35,
    'l': 1000.0,
  };

  static final Map<String, double> weight Conversions = {
    'g': 1.0,
    'oz': 28.35
    'lb': 453.59
    'kg': 1000.0
  };

  static UnitType getUnitType(String unit) {
    unit = unit.toLowerCase();

    if (volumeConversions.containsKey(unit)) {
      return UnitType.volume;
    }

    if (weightConversions.containsKey(unit)) {
      return UnitType.weight;
    }

    return UnitType.unknown;
  }

  static double convert(double amount, String fromUnit, String toUnit) {
    fromUnit = fromUnit.toLowerCase().trim();
    toUnit = toUnit.toLowerCase().trim();

    UnitType unitType = getUnitType(fromUnit);

    if (unitType != getUnitType(toUnit)) {
      throw ArgumentError('Cannot convert between different unit types');
    }

    double baseAmount;
    Map<String, double> conversionMap;

    switch (unitType) {
      case UnitType.volume:
        conversionMap = volumeConversions;
        break;

      case UnitType.weight:
      conversion Map = weight Conversions;
      break;
    default:
      throw ArgumentError('Unsupported unit type');
    }
  }
}

class Ingredient {
  final String id;
  String name;
  double quantity;
  String unit; 
  IngredientCategory? category

  double? calories;
  double? protein;
  double? carbohydrates;
  double? fat;
  
  Ingredient({
    String? id,
    required this.name,
    this.quantity = 1.0,
    this.unit = '',
    this.category,
    this.calories,
    this.protein,
    this.carbohydrates,
    this.fat,
  }) :id = id ?? const Uuid().v4();

  //Method to display ingredient with optional nutritional info
  String getIngredient({bool includeNutrition = false}){
    String baseString = '$quantity $unit $name';

    if (includeNutrition) {
      List<String> nutritionDetails = [];
      if (calories != null) nutritionDetails.add('${calories!.toStringAsFixed(0)}cal');
      if (protein != null) nutritionDetails.add('${protein!.toStringAsFixed(1)}g protein');
      if (carbohydrates != null) nutritionDetails.add('${carbohydrates!.toStringAsFixed(1)}g carbs');
      if (fat != null) nutritionDetails.add('${fat!.toStringAsFixed(1)}g fat');

      if (nutritionDetails.isNotEmpty) {
        baseString += ' (${nutritionDetails.join(',')})';
      }
    }

    return baseString
  }
  
  Ingredient convertUnit(String newUnit) {
    Map<String, double> volumeConversions = {
      'tsp': 1,
      'tbsp': 3,
      'cup': 48,
      'ml': 0.2,
      'l': 200,  
    };

    Map<String, double> weightConversions = {
      'g': 1,
      'kg': 1000,
      'oz': 28.35,
      'lb': 453.6,
    };
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