import 'dart:convert';

import 'package:lutojuan/Constants/endpoints.dart';
import 'package:lutojuan/Features/NavBar/RecipeModel.dart';
import 'package:http/http.dart' as http;

class NPointService{

  Future<RecipeModel> makeApiCall() async {
    var response = await http.get(Uri.parse(npointEndpoint));
    if (response.statusCode == 200) {
      //print(response.body);
      final jsonData = jsonDecode(response.body);
      RecipeModel recipes = RecipeModel.fromJson(jsonData);
      return recipes;
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
    return RecipeModel(recipes: []);
  }

}