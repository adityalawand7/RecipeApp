import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipeModel.dart';

class RecipeDetail extends StatelessWidget {
  final RecipeModel recipe;
  const RecipeDetail({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(recipe.imageUrl), 
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(recipe.desc),
                SizedBox(height: 16),
                Text('Ingredients: ${recipe.ingredients}'),
                SizedBox(height: 16),
                Text('Method: ${recipe.method}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
