import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String currentText = "";
  bool _visible = true;
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
                top: deviceHeight * 0.3,
                child: Text('NUTRIHELP',
                    style: GoogleFonts.redressed(
                        textStyle: TextStyle(
                            color: Colors.black, fontSize: deviceWidth * 0.1))),
              ),
              AnimatedPositioned(
                  top: _visible ? deviceHeight * 0.42 : deviceHeight * 0.32,
                  duration: Duration(milliseconds: 400),
                  child: Column(children: [
                    AnimatedOpacity(
                      opacity: _visible ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 250),
                      child: Container(
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
                    ),
                    SizedBox(height: 10),
                    AnimatedOpacity(
                        alwaysIncludeSemantics: true,
                        opacity: _visible ? 0.0 : 1.0,
                        duration: Duration(milliseconds: 250),
                        child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: deviceWidth * 0.7,
                                  child: PinCodeTextField(
                                    keyboardType: TextInputType.number,
                                    animationType: AnimationType.fade,
                                    animationDuration:
                                        Duration(milliseconds: 10),
                                    enableActiveFill: true,
                                    appContext: context,
                                    length: 4,
                                    onChanged: (value) {
                                      print(value);
                                      setState(() {
                                        currentText = value;
                                      });
                                    },
                                    cursorColor: Colors.black,
                                    pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(10),
                                      fieldWidth: deviceWidth * 0.15,
                                      selectedFillColor: Colors.white,
                                      // selectedColor: colors,
                                      inactiveColor: Colors.white,
                                      disabledColor: Colors.white,
                                      borderWidth: 1.5,
                                      inactiveFillColor: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ))),
                  ])),
              Positioned(
                  top: deviceHeight * 0.55,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _visible = !_visible;
                      });
                    },
                    child: _visible
                        ? Text(
                            ' Request OTP ',
                            style: TextStyle(fontSize: deviceWidth * 0.051),
                          )
                        : Text('LOGIN',
                            style: TextStyle(fontSize: deviceWidth * 0.05)),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      minimumSize:
                          Size(deviceWidth * 0.25, deviceHeight * 0.07),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      backgroundColor: Color(0xff05483F),
                    ),
                  ))
            ])));
  }
}
