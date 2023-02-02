import 'package:dio/dio.dart';

class Spoonacular{

  void getRecipes()async{
    try{
      var response = await Dio().get("https://api.spoonacular.com/recipes/716429/information?apiKey=5633245e8b5c498ca2c11c272252eb85&includeNutrition=true");
      print(response);
    }catch(e){

    }
  }
}