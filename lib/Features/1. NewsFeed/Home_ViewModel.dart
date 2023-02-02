
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lutojuan/Services/JsonReadService.dart';

import '../NavBar/RecipeModel.dart';

var HomeViewModel = FutureProvider((ref) async {
  String jsonString = await ReadJson().loadAStudentAsset();
  final jsonResponse = json.decode(jsonString);
  RecipeModel recipes = RecipeModel.fromJson(jsonResponse);
  return recipes;
});