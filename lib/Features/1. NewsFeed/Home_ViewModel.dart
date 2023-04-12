
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lutojuan/Services/JsonReadService.dart';
import 'package:lutojuan/data/NPointService.dart';

import '../NavBar/RecipeModel.dart';

var HomeViewModel = FutureProvider((ref) async {
  String jsonString = await ReadJson().loadRecipe();
  final jsonResponse = json.decode(jsonString);
  RecipeModel recipes = await NPointService().makeApiCall();
  return recipes;
});