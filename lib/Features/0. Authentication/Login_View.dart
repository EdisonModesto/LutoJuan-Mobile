import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lutojuan/Constants/Colors.dart';
import 'package:lutojuan/Features/0.%20Authentication/SignUp_View.dart';
import 'package:lutojuan/Features/NavBar/Nabar.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  var key = GlobalKey<FormState>();
  var _emailCtrl = TextEditingController();
  var _passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1, top: size.height * 0.1, bottom: size.height * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundColor: AppColors().primary,
                child: const Icon(Icons.person_outline, color: Colors.white,),
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
                    TextFormField(
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
                    const SizedBox(height: 10,),
                    TextFormField(
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
                    const SizedBox(height: 10,),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>AppNavBar()));
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        fixedSize: const Size(409, 53),
                        backgroundColor: AppColors().primary,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))
                        ),
                      ),
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>SignupView()));
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
