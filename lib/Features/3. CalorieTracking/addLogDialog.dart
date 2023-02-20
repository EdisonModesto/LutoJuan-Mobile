import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hive/hive.dart";
import "package:lutojuan/Constants/Colors.dart";
import "package:lutojuan/Services/FirestoreService.dart";

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

  List<DropdownMenuItem> items = [
    const DropdownMenuItem(
      value: "Quantity",
      child: Text("Quantity"),
    )
  ];

  var value = "Quantity";

  @override
  void initState() {
    print(widget.date);
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
                    child: TextFormField(
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
                        labelText: "Food Name",
                      ),
                    ),
                  ),
                  DropdownButton(
                    items: items,
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(10),
                    value: value,
                    iconEnabledColor: AppColors().primary,
                    iconSize: 40,
                    onChanged: (value) {
                      setState(() {
                        this.value = value.toString();
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (key.currentState!.validate() && value != "Quantity") {
                        FirestoreService().addRecord(widget.date, nameCtrl.text, double.parse(value), 150.0, widget.meal);
                        Navigator.pop(context);
                      } else {
                        Fluttertoast.showToast(msg: "Please fill all fields", backgroundColor: AppColors().primary, textColor: Colors.white, fontSize: 16,);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      backgroundColor: AppColors().primary,
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
  }
}
