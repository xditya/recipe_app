import 'dart:convert';

import 'package:http/http.dart' as http;

class Recipe {
  final String name;
  final String imageUrl;
  final String instructions;
  final List<dynamic> ingredients;

  Recipe({
    required this.name,
    required this.imageUrl,
    required this.instructions,
    required this.ingredients,
  });
}

Future<List<Recipe>> fetchRecepies() {
  var data = http
      .get(Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=a'));
  return data.then((response) {
    var allData = response.body;
    var jsonData = const JsonDecoder().convert(allData);
    var meals = jsonData['meals'];
    List<Recipe> recipes = [];
    for (int i = 0; i < meals.length; i++) {
      var meal = meals[i];
      var ingredients = [];
      for (var i = 1; i <= 20; i++) {
        if (meal['strIngredient$i'] != '') {
          ingredients.add(meal['strIngredient$i']);
        }
      }
      recipes.add(Recipe(
        name: meal['strMeal'],
        imageUrl: meal['strMealThumb'],
        instructions: meal['strInstructions'],
        ingredients: ingredients,
      ));
    }
    return recipes;
  });
}

// // Sample data
// final List<Recipe> sampleRecipes = [
//   Recipe(
//     name: 'Spaghetti Carbonara',
//     imageUrl:
//         'https://images.unsplash.com/photo-1612874742237-6526221588e3?ixlib=rb-4.0.3',
//     description:
//         'Classic Italian pasta dish with eggs, cheese, pancetta, and pepper',
//     ingredients: [
//       'Spaghetti',
//       'Eggs',
//       'Pecorino Romano',
//       'Pancetta',
//       'Black Pepper'
//     ],
//     instructions: [
//       'Cook pasta in salted water',
//       'Fry pancetta until crispy',
//       'Mix eggs and cheese',
//       'Combine all ingredients',
//     ],
//     cookingTime: '25 mins',
//   ),
//   Recipe(
//     name: 'Chicken Tikka Masala',
//     imageUrl:
//         'https://images.unsplash.com/photo-1588166524941-3bf61a9c41db?ixlib=rb-4.0.3',
//     description: 'Creamy and aromatic Indian curry with tender chicken pieces',
//     ingredients: ['Chicken', 'Yogurt', 'Tomatoes', 'Cream', 'Spices'],
//     instructions: [
//       'Marinate chicken in yogurt and spices',
//       'Grill chicken until charred',
//       'Prepare curry sauce',
//       'Combine chicken and sauce',
//     ],
//     cookingTime: '45 mins',
//   ),
//   Recipe(
//     name: 'Greek Salad',
//     imageUrl:
//         'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-4.0.3',
//     description: 'Fresh Mediterranean salad with feta cheese and olives',
//     ingredients: ['Cucumber', 'Tomatoes', 'Red Onion', 'Feta Cheese', 'Olives'],
//     instructions: [
//       'Chop vegetables',
//       'Combine ingredients',
//       'Add dressing',
//       'Toss gently',
//     ],
//     cookingTime: '15 mins',
//   ),
// ];
