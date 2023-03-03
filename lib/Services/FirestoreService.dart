import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lutojuan/Services/AuthService.dart';

class FirestoreService{
  void createUser(){
    FirebaseFirestore.instance.collection("Users").doc(AuthService().getID()).set({
      "Name": "User",
      "Photo": "",
      "Age": 18,
      "Weight": "Not Recorded",
      "Height": "Not Recorded",
      "Goal" : "Lose Weight"
    });
  }

  void updateUser(id, name, photo, age, weight, height, goal){
    FirebaseFirestore.instance.collection("Users").doc(id).update({
      "Name": name,
      "Photo": photo,
      "Age": age,
      "Weight": weight,
      "Height": height,
      "Goal" : goal
    });
  }


  void addRecord(date, name, quantity, calories, meal){
    FirebaseFirestore.instance.collection("Users").doc(AuthService().getID()).collection("Records").add({
      "Date": date,
      "Name": name,
      "Quantity": quantity,
      "Calories": calories,
      "Meal": meal
    });
  }

}