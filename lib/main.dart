import 'package:calculator/screens/calculator.dart';
import 'package:calculator/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

 Future <void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   runApp(MyApp());
}
class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     title: "Email and Password Login",
     theme: ThemeData(),
     debugShowCheckedModeBanner: false,
     home: Calculator(),
    );
  }
}
