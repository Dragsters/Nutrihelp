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
          if (snapshot.hasData) {
            if (snapshot.data.getBool('login')) {
              return const DashBoardScreen();
            } else {
              return const LoginScreen();
            }
          } else {
            return Container();
          }
        });

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Future<SharedPreferences> prefs = await SharedPreferences.getInstance();
    // bool login = prefs.getBool('login');
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Health Predictor',
        home: futureBuilder
        // home: AboutUsScreen(),
        );
  }
}
