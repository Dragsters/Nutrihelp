import 'dart:convert';
import 'package:client/dashboard_screen.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  Client client = Client();
  dynamic auth(BuildContext context, String email, {String otp = ''}) async {
    final url = Uri.parse("https://nutrihelpb.herokuapp.com/auth");

    final jsonBody = otp == ''
        ? jsonEncode({
            'email': email,
          })
        : jsonEncode({
            'email': email,
            'otp': otp,
          });

    // var decodedBody = jsonDecode(jsonBody);
    // print(decodedBody['token']);

    final res = await client.post(
      url,
      body: jsonBody,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final status = data['msg'].toString();
      final userId = data['userid'].toString();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(status)));
      if (otp != '' && data['ok'] == true) {
        final SharedPreferences isLogin = await SharedPreferences.getInstance();
        isLogin.setBool('login', true);
        isLogin.setString('userId', userId);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DashBoardScreen(),
          ),
        );
      }
    }
  }
}

void postPatient(BuildContext context, String name, String gender, int age,
    String mobile) async {
  final url = Uri.parse("https://nutrihelpb.herokuapp.com/patients");
  final SharedPreferences localStorage = await SharedPreferences.getInstance();
  final String userid = localStorage.getString('userId');
  final jsonBody = jsonEncode({
    "userid": userid,
    "patient": {"age": age, "gender": gender, "mobile": mobile, "name": name}
  });

  final res = await http.post(
    url,
    body: jsonBody,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (res.statusCode == 200) {
    final data = jsonDecode(res.body);
    final status = data['msg'].toString();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(status)));
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Something wrong')));
  }
}
