import 'dart:convert';

import 'package:flutter/services.dart';

import '../Features/NavBar/RecipeModel.dart';

class ReadJson{
  Future<String> loadAStudentAsset() async {
    return await rootBundle.loadString('assets/json/recipes.json');
  }

  void loadData()async{
    String jsonString = await loadAStudentAsset();
    final jsonResponse = json.decode(jsonString);
    RecipeModel recipes = RecipeModel.fromJson(jsonResponse);
    for (var i = 0; i < recipes.recipes!.length; i++) {
      print(recipes.recipes![i].title);
    }
  }

}