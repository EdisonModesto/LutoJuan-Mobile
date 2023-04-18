import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lutojuan/Constants/Colors.dart';
import 'package:lutojuan/Features/1.%20NewsFeed/Home_ViewModel.dart';
import 'package:lutojuan/Features/2.%20CreateRecipe/CreateViewModel.dart';
import 'package:lutojuan/Features/2.%20CreateRecipe/addIngreDialog.dart';

import '../NavBar/RecipeModel.dart';

class CreateView extends ConsumerStatefulWidget {
  const CreateView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CreateViewState();
}

class _CreateViewState extends ConsumerState<CreateView> with SingleTickerProviderStateMixin {

  late FlutterGifController controller;

  @override
  void initState() {
    controller = FlutterGifController(vsync: this);
    controller.repeat(min:0, max:20, period:const Duration(milliseconds: 1500));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Ingredient> ingredient = ref.watch(ingredientProvider);
    var recipeProvider = ref.watch(HomeViewModel);

    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: recipeProvider.when(
        data: (data){

          var matchedIngredients = data.recipes!.where((element){
            int recipeLength = element.recipeIngredients.length;
            int matchCounter = 0;
            for(int i = 0; i < element.recipeIngredients.length; i++){
              for(int j = 0; j < ingredient.length; j++){
                var formattedQuantity = ingredient[j].quantity.split(" ");
                double convertedQuantity = 0.0;
                if(formattedQuantity[1] == "kg"){
                  convertedQuantity = double.parse(formattedQuantity[0]) * 1000;
                } else {
                  print(formattedQuantity);
                  convertedQuantity = double.parse(formattedQuantity[0]);
                }
                if(element.recipeIngredients[i].name == ingredient[j].name && convertedQuantity >= double.parse(element.recipeIngredients[i].quantity)){
                  matchCounter += 1;
                }
              }
            }
            return matchCounter == recipeLength;
          }).toList();

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffFAECB3),
                  Color(0xffFFFFFF),
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1, top: size.height * 0.05, bottom: size.height * 0.03),
              child: SizedBox(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Transform.translate(
                        offset: const Offset(0, -75),
                        child: SizedBox(
                          height: 175,
                            width: 175,
                            child: GifImage(
                              controller: controller,
                              image: const AssetImage("assets/images/vector1.gif"),
                              fit: BoxFit.cover,
                            )
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create Recipe",
                          style: GoogleFonts.lato(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height:15),
                        Text(
                          "Get a recipe based on your ingredients",
                          style: GoogleFonts.lato(
                              fontSize: 16,
                              color: AppColors().grey
                          ),
                        ),
                        const SizedBox(height:15),
                        InkWell(
                          onTap: (){
                            if(matchedIngredients.isNotEmpty) {
                              GoRouter.of(context).push("/recipe", extra: matchedIngredients[0]);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                              border: Border.all(width: 1, color: Colors.black),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  matchedIngredients.isEmpty ? "No recipe found" : matchedIngredients[0].recipeName,
                                  style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff7A6C2D)
                                  ),
                                ),
                                Text(
                                  matchedIngredients.isEmpty ? "0Kcal" : matchedIngredients[0].recipeCalories.toString() + "Kcal",
                                  style: GoogleFonts.lato(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height:15),
                        const Divider(
                          height: 2,
                          thickness: 3,
                          color: Colors.black,
                        ),
                        const SizedBox(height:15),
                        Expanded(
                            child: ListView.separated(
                              itemCount: ingredient.length,
                              itemBuilder: (context, index){
                                return Dismissible(
                                  key: Key(ingredient[index].name),
                                  onDismissed: (direction){
                                    ref.read(ingredientProvider.notifier).removeIngredient(ingredient[index].name);
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.white60,
                                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                                      border: Border.all(width: 1, color: Colors.black),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${ingredient[index].name}",
                                              style: GoogleFonts.lato(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color(0xff7A6C2D)

                                              ),
                                            ),
                                            Text(
                                              "Quantity: ${ingredient[index].quantity}",
                                              style: GoogleFonts.lato(
                                                  color: AppColors().grey
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${double.parse(ingredient[index].calories).toStringAsFixed(2)}Kcal",
                                          style: GoogleFonts.lato(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return const SizedBox(height: 10,);
                              },
                            )
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(context: context, builder: (builder){
                              return const addIngreDialog();
                            }).whenComplete((){
                              setState(() {});
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            fixedSize: const Size(409, 53),
                            backgroundColor: const Color(0xffE0C552),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6))
                            ),
                          ),
                          child: const Text('Add Ingredient'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        error: (error, stack){
          return const Center(
            child: Text("Error"),
          );
        },
        loading: (){
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
