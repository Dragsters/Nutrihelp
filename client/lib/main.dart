import 'package:client/aboutus_screen.dart';
import 'package:client/dashboard_screen.dart';
import 'package:client/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

FutureBuilder<SharedPreferences> futureBuilder =
    FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          var hasdata = snapshot.data == null ? false : true;
          if (hasdata) {
            var islogin = snapshot.data.getBool('login') == null ? false : true;
            if (islogin) {
              return const DashBoardScreen();
            } else {
              return const LoginScreen();
            }
          } else {
            return LoginScreen();
          }
        });

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Health Predictor',
        home: futureBuilder);
  }
}
