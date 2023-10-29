import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipeapp/models/recipeModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.deepPurpleAccent),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<RecipeModel> _recipe = [];

  Future<void> loadRecipeData() async {
    final String jsonContent =
        await rootBundle.loadString("assets/recipeData/recipes/json");
    final List<dynamic> jsonList = json.decode(jsonContent);
    for (var jsonRecipe in jsonList) {
      _recipe.add(RecipeModel(
        jsonRecipe["id"],
        jsonRecipe['name'],
        jsonRecipe['desc'],
        jsonRecipe['ingredients'],
        jsonRecipe['method'],
        jsonRecipe['imageUrl'],
      ));
    }
    setState(() {
      super.initState();
      loadRecipeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Recipe App"),
        elevation: 5,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              ListView.builder(
                itemCount: _recipe.length,
                itemBuilder: (context, index) {
                  final _singleRecipe = _recipe[index];
                  return Card(
                    child: ListTile(
                      title: Text(_singleRecipe.name),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
