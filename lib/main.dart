import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/signIn_page..dart';
import 'package:chat_app/pages/signUp_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SigninPage.id: (context) => SigninPage(),
        SignUpPage.id: (context) => SignUpPage(),
        ChatPage.id: (context) => ChatPage(),
      },
      initialRoute: SigninPage.id,
      debugShowCheckedModeBanner: false,
    );
  }
}
