import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lutojuan/Features/NavBar/RecipeModel.dart';

class ViewRecipe extends ConsumerStatefulWidget {
  const ViewRecipe({
    required this.recipe,
    Key? key,
  }) : super(key: key);

  final Recipes recipe;

  @override
  ConsumerState createState() => _ViewRecipeState();
}

class _ViewRecipeState extends ConsumerState<ViewRecipe> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1, top: size.height * 0.05, bottom: size.height * 0.05,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.recipe.title}" ,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("${widget.recipe.image}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                 "Servings: ${widget.recipe.servings}" ,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                HtmlWidget(
                  "${widget.recipe.summary}",
                ),
                const SizedBox(height: 20),
                Text(
                  "Ingredients" ,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(widget.recipe.extendedIngredients!.length, (index){
                    return Text(
                      "${widget.recipe.extendedIngredients![index].amount} - ${widget.recipe.extendedIngredients![index].originalName}" ,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),

                Text(
                  "Instructions" ,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "${widget.recipe.instructions}" ,
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
    );
  }
}
