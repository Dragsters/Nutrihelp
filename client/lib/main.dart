import 'package:client/dashboardScreen.dart';
import 'package:client/loginScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nutrihelp',
<<<<<<< HEAD
      home: LoginScreen(),
=======
      home: DashBoardScreen()
>>>>>>> e700ff5b8fa4241e7d506de75333feea2f800a33
    );
  }
}
