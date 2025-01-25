import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'widgets/recipe_card.dart';
import 'pages/recipe_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchRecepies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            var sampleRecipes = snapshot.data as List<Recipe>;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Recipes'),
                centerTitle: true,
              ),
              body: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: sampleRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = sampleRecipes[index];
                  return RecipeCard(
                    recipe: recipe,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RecipeDetailPage(recipe: recipe),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }
        });

    // var sampleRecipes = await fetchRecepies();

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Recipes'),
    //     centerTitle: true,
    //   ),
    //   body: GridView.builder(
    //     padding: const EdgeInsets.all(16),
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //       childAspectRatio: 0.75,
    //       crossAxisSpacing: 16,
    //       mainAxisSpacing: 16,
    //     ),
    //     itemCount: sampleRecipes.length,
    //     itemBuilder: (context, index) {
    //       final recipe = sampleRecipes[index];
    //       return RecipeCard(
    //         recipe: recipe,
    //         onTap: () {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => RecipeDetailPage(recipe: recipe),
    //             ),
    //           );
    //         },
    //       );
    //     },
    //   ),
    // );
  }
}
