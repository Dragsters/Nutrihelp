import 'package:client/add_patient_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

InputDecoration customFieldDecoration(
    {double deviceWidth, String hint, String sufftxt}) {
  return InputDecoration(
    focusColor: Colors.white,
    hoverColor: Colors.white,
    labelText: hint,
    labelStyle: const TextStyle(
      color: Colors.black,
    ),
    suffixText: sufftxt,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    focusedBorder: UnderlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(10)),
    enabledBorder: UnderlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(10)),
    border: UnderlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(10)),
    filled: true,
    fillColor: Colors.white,
  );
}

Widget template({Widget body}) {
  return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffA6E97C), Color(0xffF4F4F4)])),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: body,
      ));
}

IconButton newIconButton(
    BuildContext context, double deviceWidth, double deviceHeight) {
  return IconButton(
    onPressed: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AddPatientScreen()));
    },
    icon: Container(
        width: deviceWidth * 0.3,
        height: deviceHeight * 0.08,
        padding: const EdgeInsets.only(left: 5, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: const Color(0xff05483f))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.add_box,
              size: deviceWidth * 0.09,
            ),
            Text('New',
                style: GoogleFonts.poppins(fontSize: deviceWidth * 0.05))
          ],
        )),
    color: const Color(0xff05483f),
  );
}
