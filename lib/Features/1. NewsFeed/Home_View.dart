import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lutojuan/Constants/articles.dart';
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


  @override
  Widget build(BuildContext context) {
    var feedProvider = ref.watch(HomeViewModel);
    var size = MediaQuery.of(context).size;
    return SafeArea(
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
                    color: Colors.black,
                    width: 2
                  )
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search
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
                        color: chipValues[0] ? AppColors().primary : Colors.grey
                    ),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    selectedColor: Colors.white,
                    selectedShadowColor: Colors.white,
                    disabledColor: Colors.white,
                    backgroundColor: Colors.white,
                    selected: chipValues[0],
                    pressElevation: 0,
                    side: BorderSide(
                      color: chipValues[0] ? AppColors().primary : Colors.grey,
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

                    label: Text(
                      "Articles/Trivia",
                      style: GoogleFonts.lato(
                          color: chipValues[1] ? AppColors().primary : Colors.grey
                      ),
                    ),
                    labelStyle: const TextStyle(
                      color: Colors.black
                    ),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    selected: chipValues[1],
                    selectedColor: Colors.white,
                    selectedShadowColor: Colors.white,
                    disabledColor: Colors.white,
                    backgroundColor: Colors.white,
                    pressElevation: 0,
                    side: BorderSide(
                        color: chipValues[1] ? AppColors().primary : Colors.grey,
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
                    SizedBox(height: 15,),
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
                    SizedBox(height: 15,),
                    Text(
                      "Trivia of the Day",
                      style: GoogleFonts.lato(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 15,),
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
                                    Text(
                                      "Trivia Headline",
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: AppColors().primary,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Trivia Content",
                                      style: GoogleFonts.lato(
                                          fontSize: 16,
                                      ),
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
    );
  }
}
