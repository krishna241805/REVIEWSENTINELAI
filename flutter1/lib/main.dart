import 'package:flutter/material.dart';
import 'package:flutter1/upload_screen.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Loginpage(), debugShowCheckedModeBanner: false);
  }
}
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'get.dart';
//
// void main() {
//   runApp(const MaterialApp(
//       debugShowCheckedModeBanner: false,
//
//       home: MyApp()));
// }
