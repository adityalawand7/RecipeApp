import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipeapp/models/recipeModel.dart';
import 'package:recipeapp/pages/recipeDetail.dart';
import 'package:recipeapp/utils/routes.dart';

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
      initialRoute: MyRoutes.recipeDetail,
      // routes: {
      //   MyRoutes.homePage:(context) => HomePage(),
      //   MyRoutes.recipeDetail: (context) => RecipeDetail(),
      // },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RecipeModel> _recipe = [];

  Future<void> loadRecipeData() async {
    final String jsonContent =
        await rootBundle.loadString("assets/recipeData/recipes.json");
    final Map<String, dynamic> jsonData = json.decode(jsonContent);

    if (jsonData.containsKey("recipes")) {
      final List<dynamic> jsonList = jsonData["recipes"];
      for (var jsonRecipe in jsonList) {
        _recipe.add(RecipeModel(
          jsonRecipe["id"],
          jsonRecipe["name"],
          jsonRecipe["desc"],
          jsonRecipe["ingredients"],
          jsonRecipe["method"],
          jsonRecipe["imageUrl"],
        ));
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadRecipeData();
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
            height: double.infinity,
            padding: EdgeInsets.all(15),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _recipe.length,
              itemBuilder: (context, index) {
                final _singleRecipe = _recipe[index];
                // print(_singleRecipe);
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetail(recipe: _singleRecipe),));
                    },
                    leading: Image.network(_singleRecipe.imageUrl),
                    title: Text(_singleRecipe.name),
                    subtitle: Text(_singleRecipe.desc),
                  ),
                );
              },
            )),
      ),
    );
  }
}
