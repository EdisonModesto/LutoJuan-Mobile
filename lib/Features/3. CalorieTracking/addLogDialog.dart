import "package:field_suggestion/field_suggestion.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hive/hive.dart";
import "package:lutojuan/Constants/Colors.dart";
import "package:lutojuan/Services/FirestoreService.dart";

import "../1. NewsFeed/Home_ViewModel.dart";
import "../NavBar/RecipeModel.dart";

class addLogDialog extends ConsumerStatefulWidget {
  const addLogDialog({
    required this.date,
    required this.meal,
    Key? key,
  }) : super(key: key);

  final date;
  final meal;

  @override
  ConsumerState createState() => _addLogDialogState();
}

class _addLogDialogState extends ConsumerState<addLogDialog> {

  var key = GlobalKey<FormState>();

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController amountCtrl = TextEditingController();
  final boxController = BoxController();

  var selectedCalories = 0.0;
  var servingSize = 0.0;


  List<DropdownMenuItem> items = [
    const DropdownMenuItem(
      value: "ml/gram",
      child: Text("ml/gram"),
    ),
    const DropdownMenuItem(
      value: "kg",
      child: Text("kg"),
    )
  ];

  var value = "ml/gram";

  @override
  void initState() {
    print(widget.date);
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
                        "Add Record",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                          height: 50,
                          child: FieldSuggestion<Recipe>(
                            textController: nameCtrl,
                            maxLines: 1,
                            search: (item, input) {
                              if (item.recipeName == input) return false;
                              return item.recipeName.toLowerCase() .contains(input.toLowerCase()) ;
                            },
                            suggestions: data.recipes,
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
                                  nameCtrl.text = data.recipes![item].recipeName;
                                  selectedCalories = double.parse(data.recipes![item].recipeCalories);
                                  servingSize = double.parse(data.recipes![item].recipeServingSize);
                                  setState(() {});
                                  boxController.close?.call();
                                },
                                title: Text(
                                  data.recipes![item].recipeName,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            },

                          )
                      ),
                  SizedBox(height: 50,),
                  /*    Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: TextFormField(
                                cursorColor:Color(0xffCF8145),
                                keyboardType: TextInputType.number,
                                controller: amountCtrl,
                                decoration: InputDecoration(
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  filled: true,
                                  fillColor: AppColors().light,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  labelText: "Amount",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            child: DropdownButton(
                              items: items,
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(10),
                              value: value,
                              iconEnabledColor: Color(0xffCF8145),
                              iconSize: 40,
                              onChanged: (value) {
                                setState(() {
                                  this.value = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),*/
                      ElevatedButton(
                        onPressed: () async {
                          if (key.currentState!.validate() && value != "Quantity") {
                            FirestoreService().addRecord(widget.date, nameCtrl.text, servingSize, selectedCalories, widget.meal);
                            Navigator.pop(context);
                          } else {
                            Fluttertoast.showToast(msg: "Please fill all fields", backgroundColor: Color(0xffCF8145), textColor: Colors.white, fontSize: 16,);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          fixedSize: Size(MediaQuery.of(context).size.width, 50),
                          backgroundColor: Color(0xffCF8145),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text("Add Record"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      error: (error, stack){
        return Center(
          child: Text(error.toString()),
        );
      },
      loading: (){
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }
}
