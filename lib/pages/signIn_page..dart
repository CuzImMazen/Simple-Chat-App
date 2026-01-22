import 'package:chat_app/Widgets/button.dart';
import 'package:chat_app/Widgets/text_field.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/signUp_page.dart';
import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SigninPage extends StatefulWidget {
  SigninPage({super.key});

  static final String id = '1';

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
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
                      "Sign In",
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

                        await signIn();
                        setState(() {
                          isLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          await SnackBar(
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.green,
                            content: Text('Signin Successful'),
                          ),
                        );
                        Navigator.pushNamed(
                          context,
                          ChatPage.id,
                          arguments: email,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'invalid-credential') {
                          setState(() {
                            isLoading = false;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Wrong Email or Password'),
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
                  child: CustomButton(text: "SignIn"),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dont have an account?",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(" "),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, SignUpPage.id),
                      child: Text(
                        "SignUp",
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

  signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
