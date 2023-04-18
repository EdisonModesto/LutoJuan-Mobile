import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lutojuan/Constants/Colors.dart';
import 'package:lutojuan/Features/0.%20Authentication/SignUp_View.dart';
import 'package:lutojuan/Features/0.%20Authentication/loginLoading.dart';
import 'package:lutojuan/Features/NavBar/Nabar.dart';
import 'package:lutojuan/Services/AuthService.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> with SingleTickerProviderStateMixin {
  var key = GlobalKey<FormState>();
  var _emailCtrl = TextEditingController();
  var _passCtrl = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Padding(
              padding: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1, top: size.height * 0.1, bottom: size.height * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Color(0xffD4486E),
                    backgroundImage: AssetImage("assets/images/lutoLogo.png"),
                  ),
                  Form(
                    key: key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: GoogleFonts.lato(
                            fontSize: 26,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                          height: 50,
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                            controller: _emailCtrl,
                            style: const TextStyle(
                                fontSize: 14
                            ),
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(height: 0),
                              label: const Text("Email"),
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
                          ),
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                          height: 50,
                          child: TextFormField(
                            obscureText: true,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                            controller: _passCtrl,
                            style: const TextStyle(
                                fontSize: 14
                            ),
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(height: 0),
                              label: const Text("Password"),
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
                          ),
                        ),
                        const SizedBox(height: 10,),
                        ElevatedButton(
                          onPressed: () {
                            if(key.currentState!.validate()){
                              showDialog(context: context, builder: (builder){
                                return LoginLoading(
                                  email: _emailCtrl.text,
                                  pass: _passCtrl.text,
                                );
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please fill up all the fields",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                            //AuthService().signIn(_emailCtrl.text, _passCtrl.text);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            fixedSize: const Size(409, 50),
                            backgroundColor: const Color(0xffD4486E),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6))
                            ),
                          ),
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go('/Signup');
                                },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      RichText(
                        text: TextSpan(
                          text: "Forgot Password? ",
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: "Reset",
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  if (_emailCtrl.text.isNotEmpty) {
                                    try {
                                      FirebaseAuth.instance.sendPasswordResetEmail(email: _emailCtrl.text);
                                      Fluttertoast.showToast(
                                          msg: "Password reset link has been sent to your email",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    } on FirebaseAuthException catch (e) {
                                      Fluttertoast.showToast(
                                          msg: "No user found for that email",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Please enter your email above",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )

                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
