import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xffA6E97C), Color(0xffF4F4F4)])),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Row(
                  children: [
                    Text(
                        'This app is developed as a part of a Minor Project submitted in  '
                        'partial fulfillment of requirement for B.Tech Degree in Computer Science and Engineering')
                  ],
                ),
                Row()
              ],
            )));
  }
}
