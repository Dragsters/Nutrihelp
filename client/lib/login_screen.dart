import 'package:client/resources/api_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  ApiProvider apiProvider = ApiProvider();
  String otpString = "";
  String emailString = "";
  bool _visibleLogin = true;

  bool requestOtp() {
    final form = _formKey.currentState;
    if (form.validate()) {
      apiProvider.auth(context, emailString);

      return true;
    }
    return false;
  }

  void login() {
    apiProvider.auth(context, emailString, otp: otpString);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF4FC3F7), Color(0xFFE1F5FE)])),
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
                child: Text('Health Predictor',
                    style: GoogleFonts.mcLaren(
                        textStyle: TextStyle(
                            color: Colors.lightBlue[900], fontSize: deviceWidth * 0.1, fontWeight: FontWeight.bold,))),
              ),
              AnimatedPositioned(
                  top:
                      _visibleLogin ? deviceHeight * 0.42 : deviceHeight * 0.32,
                  duration: const Duration(milliseconds: 400),
                  child: Column(children: [
                    AnimatedOpacity(
                      opacity: _visibleLogin ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 250),
                      child: Form(
                        key: _formKey,
                        child: Container(
                          width: deviceWidth * 0.8,
                          child: TextFormField(
                            validator: (val) =>
                                !EmailValidator.validate(val, true)
                                    ? 'Enter a valid Email!'
                                    : null,
                            onChanged: (value) => emailString = value,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              hoverColor: Colors.white,
                              hintText: 'Email',
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.blue, width: 2),
                                  borderRadius: BorderRadius.circular(15)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.blue, width: 2),
                                  borderRadius: BorderRadius.circular(15)),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 100),
                                  borderRadius: BorderRadius.circular(15)),
                              filled: true,
                              fillColor: Colors.lightBlue[50],
                              contentPadding: EdgeInsets.only(
                                left: deviceWidth * 0.04,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    AnimatedOpacity(
                        alwaysIncludeSemantics: true,
                        opacity: _visibleLogin ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 250),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              width: deviceWidth * 0.7,
                              child: PinCodeTextField(
                                keyboardType: TextInputType.number,
                                animationType: AnimationType.fade,
                                animationDuration:
                                    const Duration(milliseconds: 10),
                                enableActiveFill: true,
                                appContext: context,
                                length: 4,
                                onChanged: (value) {
                                  setState(() {
                                    otpString = value;
                                  });
                                },
                                cursorColor: Colors.black,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(10),
                                  activeColor: Colors.blue,
                                  fieldWidth: deviceWidth * 0.15,
                                  selectedFillColor: Colors.lightBlue[50],
                                  // selectedColor: colors,
                                  inactiveColor: Colors.lightBlue[50],
                                  disabledColor: Colors.lightBlue[50],
                                  borderWidth: 1.5,
                                  inactiveFillColor: Colors.lightBlue[50],
                                  activeFillColor: Colors.lightBlue[50],
                                ),
                              ),
                            )
                          ],
                        )),
                  ])),
              Positioned(
                  top: deviceHeight * 0.55,
                  child: TextButton(
                    onPressed: () {
                      if (_visibleLogin) {
                        if (requestOtp()) {
                          setState(() {
                            _visibleLogin = !_visibleLogin;
                          });
                        }
                      } else {
                        login();
                      }
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      minimumSize:
                          Size(deviceWidth * 0.25, deviceHeight * 0.07),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      backgroundColor: const Color(0xFF01579B),
                    ),
                    child: !_visibleLogin
                        ? Text('LOGIN',
                            style: TextStyle(fontSize: deviceWidth * 0.05))
                        : Text(' Request OTP ',
                            style: TextStyle(fontSize: deviceWidth * 0.05)),
                  ))
            ])));
  }
}
