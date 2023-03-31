import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lutojuan/Features/4.%20Profile/editProfileDialog.dart';
import 'package:lutojuan/Features/ViewModels/GlobalViewModels.dart';
import 'package:lutojuan/Services/AuthService.dart';

import '../../Constants/Colors.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var userData = ref.watch(userProvider);
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.0, 0.0),
            radius: 2.0,
            colors: [
              Color(0xffD4486E),
              Colors.transparent,
            ],
          )
        ),
        child: Padding(
          padding: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1, top: size.height * 0.05, bottom: size.height * 0.035),
          child: SizedBox(
            child: userData.when(
              data: (data){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Profile",
                          style: GoogleFonts.lato(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (builder){
                                    return EditProfileDialog(
                                      photo: data.data()!["Photo"],
                                      name: data.data()!["Name"],
                                      age: data.data()!["Age"].toString(),
                                      weight: data.data()!["Weight"],
                                      height: data.data()!["Height"],
                                      goal: data.data()!["Goal"],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                AuthService().signOut();
                              },
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height:25),
                    Expanded(
                      child: Center(
                        child: data.data()!["Photo"] != "" ? CircleAvatar(
                          radius: 60,
                          backgroundColor:const Color(0xffD4486E),
                          child: ClipOval(
                            child: Image.network(
                              "${data.data()!["Photo"]}",
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ) :
                        const CircleAvatar(
                          radius: 60,
                          backgroundColor: Color(0xffD4486E),
                          child: Icon(
                            CupertinoIcons.person,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height:10),
                    Container(
                      width: size.width,
                      height: 50,
                      padding: const EdgeInsets.only(top: 15, bottom: 15, right: 25, left: 25),
                      decoration: const BoxDecoration(
                          color: Color(0xffD9D9D9),
                          borderRadius: BorderRadius.all(Radius.circular(12))
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: "Name: ",
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color:const Color(0xffD4486E),
                          ),
                          children: [
                            TextSpan(
                              text: "${data.data()!["Name"]}",
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height:10),
                    Container(
                      width: size.width,
                      height: 50,
                      padding: const EdgeInsets.only(top: 15, bottom: 15, right: 25, left: 25),
                      decoration: const BoxDecoration(
                          color: Color(0xffD9D9D9),
                          borderRadius: BorderRadius.all(Radius.circular(12))
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: "Age: ",
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xffD4486E),
                          ),
                          children: [
                            TextSpan(
                              text: data.data()!["Age"].toString(),
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height:10),
                    Container(
                      width: size.width,
                      height: 50,
                      padding: const EdgeInsets.only(top: 15, bottom: 15, right: 25, left: 25),
                      decoration: const BoxDecoration(
                          color: Color(0xffD9D9D9),
                          borderRadius: BorderRadius.all(Radius.circular(12))
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: "Weight: ",
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xffD4486E),
                          ),
                          children: [
                            TextSpan(
                              text: data.data()!["Weight"],
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height:10),
                    Container(
                      width: size.width,
                      height: 50,
                      padding: const EdgeInsets.only(top: 15, bottom: 15, right: 25, left: 25),
                      decoration: const BoxDecoration(
                          color: Color(0xffD9D9D9),
                          borderRadius: BorderRadius.all(Radius.circular(12))
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: "Height: ",
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xffD4486E),
                          ),
                          children: [
                            TextSpan(
                              text: data.data()!["Height"],
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height:10),
                    Container(
                      width: size.width,
                      height: 50,
                      padding: const EdgeInsets.only(top: 15, bottom: 15, right: 25, left: 25),
                      decoration: const BoxDecoration(
                          color: Color(0xffD9D9D9),
                          borderRadius: BorderRadius.all(Radius.circular(12))
                      ),
                      child: RichText(
                        text: TextSpan(
                          text: "Goal: ",
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xffD4486E),
                          ),
                          children: [
                            TextSpan(
                              text: data.data()!["Goal"],
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height:10),

                    ElevatedButton(
                      onPressed: () {

                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        fixedSize: const Size(409, 50),
                        backgroundColor: const Color(0xffD4486E),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))
                        ),
                      ),
                      child: const Text('FAQS'),
                    ),
                  ],
                );
              },
              error: (error, stack){
                return Center(
                  child: Text(error.toString()),
                );
              },
              loading: (){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
