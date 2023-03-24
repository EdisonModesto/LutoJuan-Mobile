import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lutojuan/Features/3.%20CalorieTracking/addLogDialog.dart';
import 'package:lutojuan/Services/AuthService.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Constants/Colors.dart';

class TrackView extends ConsumerStatefulWidget {
  const TrackView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TrackViewState();
}

class _TrackViewState extends ConsumerState<TrackView> {
  var _selectedDay;
  var _focusedDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  void initState() {
    _focusedDay = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1, top: size.height * 0.05, bottom: size.height * 0.03),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Meal History",
                style: GoogleFonts.lato(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height:15),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: Border.all(width: 1, color: Colors.black),
                ),
                child: Center(
                  child: TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                    headerVisible: false,

                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay; // update `_focusedDay` here as well
                      });
                    },
                    calendarFormat: _calendarFormat,
                    onFormatChanged: (format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    },
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Breakfast",
                            style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(width: 10,),
                          IconButton(
                            padding: const EdgeInsets.all(0),
                            splashRadius: 20,
                            visualDensity: VisualDensity.compact,
                            onPressed: (){
                              showDialog(context: context, builder: (builder){
                                return addLogDialog(date: _selectedDay ?? _focusedDay, meal: "Breakfast");
                              });
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("Users").doc(AuthService().getID()).collection("Records").where("Meal", isEqualTo: "Breakfast").snapshots(),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            var a = snapshot.data?.docs.where((element) => element.data()["Date"].toDate().toString().split(" ")[0] == _focusedDay.toString().split(" ")[0]);
                            return Column(
                              children: List.generate(a!.length, (index) {
                                return Container(
                                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
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
                                            a.elementAt(index).data()["Name"],
                                            style: GoogleFonts.lato(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors().primary
                                            ),
                                          ),
                                          Text(
                                            a.elementAt(index).data()["Quantity"].toString(),
                                            style: GoogleFonts.lato(
                                                color: AppColors().grey
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        a.elementAt(index).data()["Calories"].toString(),
                                        style: GoogleFonts.lato(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            );
                          }
                          return const CircularProgressIndicator();
                        }
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lunch",
                            style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(width: 10,),
                          IconButton(
                            padding: const EdgeInsets.all(0),
                            splashRadius: 20,
                            visualDensity: VisualDensity.compact,
                            onPressed: (){
                              showDialog(context: context, builder: (builder){
                                return addLogDialog(date: _selectedDay ?? _focusedDay, meal: "Lunch");
                              });
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("Users").doc(AuthService().getID()).collection("Records").where("Meal", isEqualTo: "Lunch").snapshots(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              var a = snapshot.data?.docs.where((element) => element.data()["Date"].toDate().toString().split(" ")[0] == _focusedDay.toString().split(" ")[0]);
                              return Column(
                                children: List.generate(a!.length, (index) {
                                  return Container(
                                    padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
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
                                              a.elementAt(index).data()["Name"],
                                              style: GoogleFonts.lato(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors().primary
                                              ),
                                            ),
                                            Text(
                                              a.elementAt(index).data()["Quantity"].toString(),
                                              style: GoogleFonts.lato(
                                                  color: AppColors().grey
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          a.elementAt(index).data()["Calories"].toString(),
                                          style: GoogleFonts.lato(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              );
                            }
                            return const CircularProgressIndicator();
                          }
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Dinner",
                            style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(width: 10,),
                          IconButton(
                            padding: const EdgeInsets.all(0),
                            splashRadius: 20,
                            visualDensity: VisualDensity.compact,
                            onPressed: (){
                              showDialog(context: context, builder: (builder){
                                return addLogDialog(date: _selectedDay ?? _focusedDay, meal: "Diner");
                              });
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("Users").doc(AuthService().getID()).collection("Records").where("Meal", isEqualTo: "Diner").snapshots(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              var a = snapshot.data?.docs.where((element) => element.data()["Date"].toDate().toString().split(" ")[0] == _focusedDay.toString().split(" ")[0]);
                              return Column(
                                children: List.generate(a!.length, (index) {
                                  return Container(
                                    padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
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
                                              a.elementAt(index).data()["Name"],
                                              style: GoogleFonts.lato(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors().primary
                                              ),
                                            ),
                                            Text(
                                              a.elementAt(index).data()["Quantity"].toString(),
                                              style: GoogleFonts.lato(
                                                  color: AppColors().grey
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          a.elementAt(index).data()["Calories"].toString(),
                                          style: GoogleFonts.lato(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              );
                            }
                            return const CircularProgressIndicator();
                          }
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Snacks",
                            style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(width: 10,),
                          IconButton(
                            padding: const EdgeInsets.all(0),
                            splashRadius: 20,
                            visualDensity: VisualDensity.compact,
                            onPressed: (){
                              showDialog(context: context, builder: (builder){
                                return addLogDialog(date: _selectedDay ?? _focusedDay, meal: "Snacks");
                              });
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("Users").doc(AuthService().getID()).collection("Records").where("Meal", isEqualTo: "Snacks").snapshots(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              var a = snapshot.data?.docs.where((element) => element.data()["Date"].toDate().toString().split(" ")[0] == _focusedDay.toString().split(" ")[0]);
                              return Column(
                                children: List.generate(a!.length, (index) {
                                  return Container(
                                    padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
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
                                              a.elementAt(index).data()["Name"],
                                              style: GoogleFonts.lato(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors().primary
                                              ),
                                            ),
                                            Text(
                                              a.elementAt(index).data()["Quantity"].toString(),
                                              style: GoogleFonts.lato(
                                                  color: AppColors().grey
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          a.elementAt(index).data()["Calories"].toString(),
                                          style: GoogleFonts.lato(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              );
                            }
                            return const CircularProgressIndicator();
                          }
                      ),
                      const SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  showDialog(context: context, builder: (builder){
                    return addLogDialog(date: _selectedDay ?? _focusedDay,meal: "Snacks");
                  });
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  fixedSize: const Size(409, 53),
                  backgroundColor: AppColors().primary,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6))
                  ),
                ),
                child: const Text('Log Food'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
