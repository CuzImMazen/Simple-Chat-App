// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/Widgets/button.dart';
import 'package:chat_app/Widgets/text_field.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/pages/signIn_page..dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpPage extends StatefulWidget {
  static final String id = '2';

  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var key = GlobalKey<FormState>();

  String email = "";

  String password = "";

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: key,
            child: Column(
              children: [
                Spacer(flex: 2),
                Image.asset('assets/images/scholar.png'),
                Text(
                  "ITE Chat",
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: "Pacifico",
                    color: Colors.white,
                  ),
                ),
                Spacer(flex: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 35),
                CustomTextField(
                  hide: false,
                  hintText: "Email",
                  onChanged: (value) => email = value.trim(),
                ),
                SizedBox(height: 25),
                CustomTextField(
                  hide: true,
                  hintText: "Password",
                  onChanged: (value) => password = value.trim(),
                ),
                SizedBox(height: 35),

                GestureDetector(
                  onTap: () async {
                    if (key.currentState!.validate()) {
                      try {
                        setState(() {
                          isLoading = true;
                        });

                        await signUp();
                        setState(() {
                          isLoading = false;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('SignUp Successful'),
                          ),
                        );
                        Navigator.pushNamed(context, SigninPage.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          setState(() {
                            isLoading = false;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                'The password provided is too weak.',
                              ),
                            ),
                          );
                        } else if (e.code == 'email-already-in-use') {
                          setState(() {
                            isLoading = false;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                'The account already exists for that email.',
                              ),
                            ),
                          );
                        } else {
                          setState(() {
                            isLoading = false;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Invalid Email.'),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: CustomButton(text: "SignUp"),
                ),
                SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(" "),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        "SignIn",
                        style: TextStyle(
                          color: Color(0xff6b89a2),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
