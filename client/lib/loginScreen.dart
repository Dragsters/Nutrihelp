import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          body: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
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
                  top: deviceHeight * 0.2,
                  child: Column(
                    children: [
                      Text('NUTRIHELP',
                          style: GoogleFonts.redressed(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: deviceWidth * 0.1))),
                      SizedBox(
                        height: deviceHeight * 0.01,
                      ),
                      Container(
                        width: deviceWidth * 0.8,
                        child: TextField(
                          decoration: InputDecoration(
                            focusColor: Colors.white,
                            hoverColor: Colors.white,
                            hintText: 'Email',
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0),
                                borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0),
                                borderRadius: BorderRadius.circular(20)),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 100),
                                borderRadius: BorderRadius.circular(20)),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.only(
                              left: deviceWidth * 0.04,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          )),
    );
  }
}
