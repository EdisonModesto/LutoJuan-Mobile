import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lutojuan/Services/AuthService.dart';
import 'package:lutojuan/Services/CloudService.dart';
import 'package:lutojuan/Services/FilePickerService.dart';

import '../../Constants/Colors.dart';
import '../../Services/FirestoreService.dart';

class EditProfileDialog extends ConsumerStatefulWidget {
  const EditProfileDialog({
    required this.photo,
    required this.name,
    required this.age,
    required this.weight,
    required this.height,
    required this.goal,
    Key? key,
  }) : super(key: key);

  final photo;
  final name;
  final age;
  final weight;
  final height;
  final goal;

  @override
  ConsumerState createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends ConsumerState<EditProfileDialog> {

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();
  TextEditingController weightCtrl = TextEditingController();
  TextEditingController heightCtrl = TextEditingController();

  var key = GlobalKey<FormState>();
  var goal = "Lose Weight";
  var url = "";

  @override
  void initState() {
    url = widget.photo;
    goal = widget.goal;
    nameCtrl.text = widget.name;
    ageCtrl.text = widget.age;
    weightCtrl.text = widget.weight;
    heightCtrl.text = widget.height;
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
          height: 500,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: key,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 500,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          url == "" ?
                          const CircleAvatar(
                            radius: 45,
                            child: Icon(Icons.person),
                          ) : CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(url),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              File? image = await FilePickerService().pickPhoto();
                              if(image != null){
                                url = await CloudService().uploadFile(AuthService().getID(), image);
                                setState(() {});
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors().primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text("Change Profile Picture"),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: nameCtrl,
                          style: const TextStyle(
                              fontSize: 14
                          ),
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(height: 0),
                            label: const Text("Name"),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: AppColors().grey,
                                width: 2.0,
                              ),
                            ),

                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 6.0,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your name";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          controller: ageCtrl,
                          style: const TextStyle(
                              fontSize: 14
                          ),
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(height: 0),
                            label: const Text("Age"),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: AppColors().grey,
                                width: 2.0,
                              ),
                            ),

                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 6.0,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your age";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: heightCtrl,
                                style: const TextStyle(
                                    fontSize: 14
                                ),
                                decoration: InputDecoration(
                                  errorStyle: const TextStyle(height: 0),
                                  label: const Text("Height"),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    borderSide: BorderSide(
                                      color: AppColors().grey,
                                      width: 2.0,
                                    ),
                                  ),

                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 6.0,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your height";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: weightCtrl,
                                style: const TextStyle(
                                    fontSize: 14
                                ),
                                decoration: InputDecoration(
                                  errorStyle: const TextStyle(height: 0),
                                  label: const Text("Weight"),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    borderSide: BorderSide(
                                      color: AppColors().grey,
                                      width: 2.0,
                                    ),
                                  ),

                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 6.0,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your height";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Goal: ",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          DropdownButton(
                            value: goal,
                            items: const [
                              DropdownMenuItem(
                                value: "Lose Weight",
                                child: Text(
                                  "Lose Weight"
                                ),
                              ),
                              DropdownMenuItem(
                                value: "Gain Weight",
                                child: Text(
                                  "Gain Weight"
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                goal = value.toString();
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (key.currentState!.validate()){
                            FirestoreService().updateUser(
                              AuthService().getID(),
                              nameCtrl.text,
                              url,
                              int.parse(ageCtrl.text),
                              weightCtrl.text,
                              heightCtrl.text,
                              goal,
                            );
                            Navigator.pop(context);
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
                        child: const Text("Save"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
