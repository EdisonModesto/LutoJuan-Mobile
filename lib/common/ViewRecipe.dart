import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lutojuan/Features/NavBar/RecipeModel.dart';
import 'package:url_launcher/url_launcher.dart';

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
          padding: EdgeInsets.only(top: size.height * 0.05, bottom: size.height * 0.05,),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/recipeBG.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1),
                  child: Text(
                    widget.recipe.recipeName ,
                    style: GoogleFonts.fredokaOne(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff83400D)
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  height: 200,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1,),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    image: DecorationImage(
                      image: NetworkImage(widget.recipe.recipeImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.only(left: size.width * 0.08, right: size.width * 0.08),
                  decoration: BoxDecoration(
                      color:const Color.fromRGBO(255, 255, 255, 0.42),
                      border: Border.all(
                          style: BorderStyle.solid,
                          width: 2
                      ),
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  padding: EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Source: ",
                          style: GoogleFonts.fredoka(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: "${widget.recipe.recipeSourceUrl}",
                              style: GoogleFonts.fredoka(
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  final Uri _url = Uri.parse(widget.recipe.recipeSourceUrl);

                                  if (!await launchUrl(_url)) {
                                  throw Exception('Could not launch $_url');
                                  }
                                },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Serving Size: ${widget.recipe.recipeServingSize}",
                        style:  GoogleFonts.fredoka(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                          widget.recipe.recipeDescription,
                        style:  GoogleFonts.fredoka(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Ingredients" ,
                        style: GoogleFonts.fredoka(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(widget.recipe.recipeIngredients!.length, (index){
                          return Text(
                            "${widget.recipe.recipeIngredients![index].quantity}g - ${widget.recipe.recipeIngredients![index].name}" ,
                            style:   GoogleFonts.fredoka(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Instructions" ,
                        style: GoogleFonts.fredoka(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.recipe.recipeInstructions ,
                        style:  GoogleFonts.fredoka(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
