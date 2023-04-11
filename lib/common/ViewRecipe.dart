import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lutojuan/Features/NavBar/RecipeModel.dart';

class ViewRecipe extends ConsumerStatefulWidget {
  const ViewRecipe({
    required this.recipe,
    Key? key,
  }) : super(key: key);

  final Recipe recipe;

  @override
  ConsumerState createState() => _ViewRecipeState();
}

class _ViewRecipeState extends ConsumerState<ViewRecipe> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/recipeBG.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1, top: size.height * 0.05, bottom: size.height * 0.05,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.recipe.recipeName ,
                    style: GoogleFonts.fredokaOne(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff83400D)
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.recipe.recipeImageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    "Source: ${widget.recipe.recipeSourceUrl}",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Serving Size: ${widget.recipe.recipeServingSize}",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),

                  HtmlWidget(
                    widget.recipe.recipeDescription,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Ingredients" ,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(widget.recipe.recipeIngredients!.length, (index){
                      return Text(
                        "${widget.recipe.recipeIngredients![index].quantity} - ${widget.recipe.recipeIngredients![index].name}" ,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "Instructions" ,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.recipe.recipeInstructions ,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
