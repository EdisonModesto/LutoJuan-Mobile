import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
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
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1, top: size.height * 0.05, bottom: size.height * 0.035),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Profile",
                style: GoogleFonts.lato(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height:25),
              Expanded(
                child: Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors().primary,
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
                padding: EdgeInsets.only(top: 15, bottom: 15, right: 25, left: 25),
                decoration: BoxDecoration(
                  color: Color(0xffD9D9D9),
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: RichText(
                  text: TextSpan(
                    text: "Name: ",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors().primary,
                    ),
                    children: [
                      TextSpan(
                        text: "Edison Modesto",
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
                padding: EdgeInsets.only(top: 15, bottom: 15, right: 25, left: 25),
                decoration: BoxDecoration(
                    color: Color(0xffD9D9D9),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: RichText(
                  text: TextSpan(
                    text: "Age: ",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors().primary,
                    ),
                    children: [
                      TextSpan(
                        text: "20",
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
                padding: EdgeInsets.only(top: 15, bottom: 15, right: 25, left: 25),
                decoration: BoxDecoration(
                    color: Color(0xffD9D9D9),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: RichText(
                  text: TextSpan(
                    text: "Weight: ",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors().primary,
                    ),
                    children: [
                      TextSpan(
                        text: "Not Recorded",
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
                padding: EdgeInsets.only(top: 15, bottom: 15, right: 25, left: 25),
                decoration: BoxDecoration(
                    color: Color(0xffD9D9D9),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: RichText(
                  text: TextSpan(
                    text: "Height: ",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors().primary,
                    ),
                    children: [
                      TextSpan(
                        text: "Not Recorded",
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
                padding: EdgeInsets.only(top: 15, bottom: 15, right: 25, left: 25),
                decoration: BoxDecoration(
                    color: Color(0xffD9D9D9),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: RichText(
                  text: TextSpan(
                    text: "Goal: ",
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors().primary,
                    ),
                    children: [
                      TextSpan(
                        text: "Lose Fat",
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
                  AuthService().signOut();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  fixedSize: const Size(409, 50),
                  backgroundColor: AppColors().primary,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6))
                  ),
                ),
                child: const Text('FAQS'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
