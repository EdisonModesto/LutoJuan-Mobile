import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lutojuan/Constants/articles.dart';
import 'package:lutojuan/Constants/trivias.dart';
import 'package:lutojuan/Features/NavBar/RecipeModel.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Constants/Colors.dart';
import 'Home_ViewModel.dart';

class HomeVIew extends ConsumerStatefulWidget {
  const HomeVIew({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomeVIewState();
}

class _HomeVIewState extends ConsumerState<HomeVIew> {
  TextEditingController _searchCtrl = TextEditingController();

  List<bool> chipValues = [true, false];

  late int seed;

  @override
  void initState() {
    DateTime now = DateTime.now();

    // Generate a seed for the Random class using the current date
    seed = now.year + now.month + now.day;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var feedProvider = ref.watch(HomeViewModel);
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff32657C),
              Color.fromRGBO(48, 100, 121, 0)
            ]
          )
        ),
        child: Padding(
          padding: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1, top: size.height * 0.05,),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Feed",
                  style: GoogleFonts.lato(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                const SizedBox(height: 15,),
                Container(
                  height: 45,
                  width: size.width,
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100),
                    ),
                    border: Border.all(
                        color: Colors.white,
                        width: 2
                    )
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 15,),
                      Expanded(
                        child: TextField(
                          controller: _searchCtrl,
                          onChanged: (val){
                            setState(() {});
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none
                          ),
                        ),
                      ),
                    ],
                  ),

                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    ChoiceChip(
                      elevation: 0,
                      label: const Text(
                        "Recipes",
                      ),
                      labelStyle: GoogleFonts.lato(
                          color: Colors.white
                      ),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      selectedColor: const Color(0xff306479),
                      selectedShadowColor: Colors.white,
                      disabledColor: const Color.fromRGBO(118, 165, 160, 0.58),
                      backgroundColor: const Color(0xff306479),
                      selected: chipValues[0],
                      pressElevation: 0,
                      side: BorderSide(
                        color: chipValues[0] ? Colors.white : const Color.fromRGBO(118, 165, 160, 0.58),
                        width: 2
                      ),
                      onSelected: (value){
                        setState(() {
                          if(value){
                            chipValues[0] = true;
                            chipValues[1] = false;
                          } else {
                            chipValues[0] = false;
                            chipValues[1] = true;
                          }
                        });
                      },
                    ),
                    const SizedBox(width: 15,),
                    ChoiceChip(
                      elevation: 0,

                      label: const Text(
                        "Articles/Trivia",
                      ),
                      labelStyle: GoogleFonts.lato(
                          color: Colors.white
                      ),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      selectedColor: const Color(0xff306479),
                      selectedShadowColor: Colors.white,
                      disabledColor: const Color.fromRGBO(118, 165, 160, 0.58),
                      backgroundColor: const Color(0xff306479),
                      selected: chipValues[1],
                      pressElevation: 0,
                      side: BorderSide(
                          color: chipValues[1] ? Colors.white : const Color.fromRGBO(118, 165, 160, 0.58),
                          width: 2
                      ),
                      onSelected: (value){
                        setState(() {
                          if(value){
                            chipValues[1] = true;
                            chipValues[0] = false;
                          } else {
                            chipValues[1] = false;
                            chipValues[0] = true;
                          }
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Expanded(
                  child: chipValues[0] ?
                      feedProvider.when(
                        data: (data){
                          data.recipes!.shuffle();

                          List<Recipe> searchResults = data.recipes!.where((element) => element.recipeName!.toLowerCase().contains(_searchCtrl.text.toLowerCase())).toList();
                          print(searchResults.length);
                          return _searchCtrl.text == "" ?
                          ListView.separated(
                            itemCount: data.recipes!.length, // Random().nextInt(data.recipes!.length),
                            itemBuilder: (context, index){
                              return InkWell(
                                onTap: (){
                                  GoRouter.of(context).push("/recipe", extra: data.recipes![index]);
                                },
                                child: Container(
                                  width: size.width,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                                      border: Border.all(color: Colors.black, width: 1)
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 18,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColors().primary,
                                                border: const Border(
                                                    right: BorderSide(
                                                        width: 1,
                                                        color: Colors.black
                                                    )
                                                )
                                            ),
                                            child: data.recipes![index].recipeImageUrl == null ? const Center(
                                              child: Text(
                                                "No Image",
                                                style: TextStyle(
                                                    color: Colors.white
                                                ),
                                              ),
                                            ) :
                                            Image.network(
                                              height: double.infinity,
                                              width: double.infinity,
                                              "${data.recipes![index].recipeImageUrl}",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 30,
                                          child: Container(
                                            color: Colors.white60,
                                            padding: const EdgeInsets.all(15),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${data.recipes![index].recipeName}",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.lato(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${data.recipes![index].recipeDescription!.replaceAll("<b>", "").replaceAll("</b>", "")}",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.lato(
                                                      fontSize: 14,
                                                      color: AppColors().grey,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "Est Calories: ${data.recipes![index].recipeCalories}",
                                                      style: GoogleFonts.lato(),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(height: 15,);
                            },
                          )
                              :
                          ListView.separated(
                            itemCount: searchResults.length, // Random().nextInt(data.recipes!.length),
                            itemBuilder: (context, index){
                              return InkWell(
                                onTap: (){
                                  GoRouter.of(context).push("/recipe", extra: searchResults![index]);
                                },
                                child: Container(
                                  width: size.width,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                                      border: Border.all(color: Colors.black, width: 1)
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 18,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColors().primary,
                                                border: const Border(
                                                    right: BorderSide(
                                                        width: 1,
                                                        color: Colors.black
                                                    )
                                                )
                                            ),
                                            child: searchResults![index].recipeImageUrl == null ? const Center(
                                              child: Text(
                                                "No Image",
                                                style: TextStyle(
                                                    color: Colors.white
                                                ),
                                              ),
                                            ) :
                                            Image.network(
                                              height: double.infinity,
                                              width: double.infinity,
                                              "${searchResults![index].recipeImageUrl}",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 30,
                                          child: Container(
                                            color: Colors.white60,
                                            padding: const EdgeInsets.all(15),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${searchResults![index].recipeName}",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.lato(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${searchResults![index].recipeDescription}",
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.lato(
                                                    fontSize: 14,
                                                    color: AppColors().grey,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "Est Calories: ${searchResults![index].recipeCalories}",
                                                      style: GoogleFonts.lato(),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(height: 15,);
                            },
                          );
                        },
                        error: (error, stack){
                          return Center(
                            child: Text(
                              error.toString(),
                              style: GoogleFonts.lato(),
                            ),
                          );
                        },
                        loading: (){
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )
                      :
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Article of the Day",
                        style: GoogleFonts.lato(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 15,),
                      InkWell(
                        onTap: (){
                          context.push("/article");

                        },
                        child: Container(
                          width: size.width,
                          height: 150,
                          decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                              border: Border.all(color: Colors.black, width: 1)
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                           child: Center(
                             child: Text(
                              "Open Article",
                              style: GoogleFonts.lato(
                                color: AppColors().primary,
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                          ),
                        ),
                           ),
                    ),
                  ),
                      ),
                      const SizedBox(height: 15,),
                      Text(
                        "Trivia of the Day",
                        style: GoogleFonts.lato(
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Container(
                        width: size.width,
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            border: Border.all(color: Colors.black, width: 1)
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 30,
                                child: Container(
                                  color: Colors.white60,
                                  width: size.width,
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AutoSizeText(
                                        triviaList![Random(seed).nextInt(triviaList.length-1)].trivia,
                                        style: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff306479),
                                        ),
                                        textAlign: TextAlign.center,
                                        minFontSize: 0,
                                        maxFontSize: 18,
                                        maxLines: 3,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      AutoSizeText(
                                        "Source: ${triviaList![Random(seed).nextInt(triviaList.length-1)].source}",
                                        style: GoogleFonts.lato(),
                                        textAlign: TextAlign.center,
                                        minFontSize: 0,
                                        maxFontSize: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
