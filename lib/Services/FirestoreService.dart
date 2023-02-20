import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lutojuan/Services/AuthService.dart';

class FirestoreService{
  void createUser(){
    FirebaseFirestore.instance.collection("Users").doc(AuthService().getID()).set({
      "Name": "User",
      "Age": 18,
      "Weight": "Not Recorded",
      "Height": "Not Recorded",
      "Goal" : "Lose Fat"
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