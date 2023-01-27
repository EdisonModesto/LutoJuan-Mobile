import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constants/Colors.dart';

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
                ListView.separated(
                  itemCount: 4,
                  itemBuilder: (context, index){
                    return Container(
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
                                child: const Center(
                                  child: Icon(Icons.image, color: Colors.white,),
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
                                      "Recipe Title",
                                      style: GoogleFonts.lato(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Recipe Description",
                                      style: GoogleFonts.lato(
                                        fontSize: 14,
                                        color: AppColors().grey
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Est Calories: 500",
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
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 15,);
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
                            child: const Center(
                              child: Icon(Icons.image, color: Colors.white,),
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
                                  "Recipe Title",
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Recipe Description",
                                  style: GoogleFonts.lato(
                                      fontSize: 14,
                                      color: AppColors().grey
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Est Calories: 500",
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
