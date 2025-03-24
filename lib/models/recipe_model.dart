enum MealCategory {
  breakfast,
  lunch,
  dinner,
  sides,
  snacks
}

class Ingredient {
  String name;
  double quantity;
  String unit; 

   Ingredient({
    required this.name,
    this.quantity = 1.0,
    this.unit = '',
  });

  String displayString() { 
  return quantity > 0 
    ? '$quantity $unit $name' 
    : name; 
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