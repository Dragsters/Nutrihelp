import 'package:client/dashboardScreen.dart';
import 'package:client/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences isLogin;

  bool logged;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    isLogin = await SharedPreferences.getInstance();
    logged = isLogin.getBool('login') == null ? false : true;
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              logged ? DashBoardScreen() : LoginScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xffA6E97C), Color(0xffF4F4F4)])),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Stack(alignment: AlignmentDirectional.topCenter, children: [
              Positioned(
                  right: deviceWidth * -0.15,
                  child: Image.asset(
                    'assets/images/upperloginscreen.png',
                    height: deviceHeight * 0.25,
                  )),
              Positioned(
                  left: deviceWidth * -0.15,
                  bottom: 0,
                  child: Image.asset(
                    'assets/images/lowerloginscreen.png',
                    height: deviceHeight * 0.25,
                  )),
              Positioned(
                top: deviceHeight * 0.4,
                child: Text('NutriHelp',
                    style: GoogleFonts.berkshireSwash(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: deviceWidth * 0.14,
                            letterSpacing: 2))),
              ),
            ])));
  }
}
