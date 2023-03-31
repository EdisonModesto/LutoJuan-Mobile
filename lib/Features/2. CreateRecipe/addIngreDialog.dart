import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lutojuan/Features/NavBar/RecipeModel.dart';

import '../../Constants/Colors.dart';
import '../1. NewsFeed/Home_ViewModel.dart';
import 'CreateViewModel.dart';

class addIngreDialog extends ConsumerStatefulWidget {
  const addIngreDialog({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _addIngreDialogState();
}

class _addIngreDialogState extends ConsumerState<addIngreDialog> {
  var key = GlobalKey<FormState>();

  TextEditingController nameCtrl = TextEditingController();
  final boxController = BoxController();

  List<DropdownMenuItem> items = [
    const DropdownMenuItem(
      value: "Quantity",
      child: Text("Quantity"),
    )
  ];

  var value = "Quantity";

  Ingredient selectedIngredient = Ingredient(name: "", quantity: "", calories: "");

  @override
  void initState() {
    //print(widget.date);
    for(int i = 1; i < 10; i++){
      items.add(DropdownMenuItem(
        value: "$i",
        child: Text("$i"),
      ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ingredients = ref.watch(HomeViewModel);
    return ingredients.when(
      data: (data){
        return Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              height: 250,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Add Ingredient",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                          height: 50,
                          child: FieldSuggestion<Ingredient>(
                            textController: nameCtrl,
                            maxLines: 1,
                            search: (item, input) {
                              if (item.name == input) return false;
                              return item.name.toLowerCase() .contains(input.toLowerCase()) ;
                            },
                            suggestions: data.ingredients,
                            inputDecoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              filled: true,
                              fillColor: AppColors().light,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              labelText: "Ingredient Name",
                            ),
                            itemBuilder: (context, item) {
                              return ListTile(
                                onTap: () {
                                  nameCtrl.text = data.ingredients![item].name;
                                  selectedIngredient = data.ingredients![item];
                                  setState(() {});
                                  boxController.close?.call();
                                },
                                title: Text(
                                  data.ingredients![item].name,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            },

                          )

                        /*TextFormField(
                      cursorColor: AppColors().primary,
                      controller: nameCtrl,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        fillColor: AppColors().light,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        labelText: "Ingredient Name",
                      ),
                    ),*/
                      ),
                      Visibility(
                        visible: selectedIngredient.name != "",
                        child: DropdownButton(
                          items: items,
                          isExpanded: true,
                          borderRadius: BorderRadius.circular(10),
                          value: value,
                          iconEnabledColor: const Color(0xffE0C552),
                          iconSize: 40,
                          onChanged: (value) {
                            setState(() {
                              selectedIngredient.quantity = value.toString();
                              selectedIngredient.calories = (double.parse(selectedIngredient.calories) * double.parse(value.toString())).toString();
                              this.value = value.toString();
                            });
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          ref.read(ingredientProvider.notifier).addIngredient(selectedIngredient);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          fixedSize: Size(MediaQuery.of(context).size.width, 50),
                          backgroundColor: const Color(0xffE0C552),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text("Add Ingredient"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      error: (error, stack) {
        return Center(
          child: Text(error.toString()),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      )
    );
  }
}
