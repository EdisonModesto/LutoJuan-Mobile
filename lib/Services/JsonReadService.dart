import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:lutojuan/Features/NavBar/ArticleModel.dart';

import '../Features/NavBar/RecipeModel.dart';

class ReadJson{
  Future<String> loadRecipe() async {
    return await rootBundle.loadString('assets/json/recipes.json');
  }

  void loadRecipeData()async{
    String jsonString = await loadRecipe();
    final jsonResponse = json.decode(jsonString);
    RecipeModel recipes = RecipeModel.fromJson(jsonResponse);
    for (var i = 0; i < recipes.recipes!.length; i++) {
      print(recipes.recipes![i].title);
    }
  }

  Future<String> loadArticle() async {
    return await rootBundle.loadString('assets/json/articles.json');
  }

  void loadArticleData()async{
    String jsonString = await loadRecipe();
    final jsonResponse = json.decode(jsonString);
    Article article = Article.fromJson(jsonResponse);
  }

}