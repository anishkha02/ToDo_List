import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todolist/auth/authscreen.dart';
import 'package:todolist/screens/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> usersnapshot) {
          if (usersnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (usersnapshot.hasData && usersnapshot.data != null) {
            return Home();
          } else {
            return AuthScreen();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.purple),
    );
  }
}
