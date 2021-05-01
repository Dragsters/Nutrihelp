import 'dart:convert';
import 'package:client/dashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;

class Apiprovider {
  Client client = Client();
  auth(BuildContext context, String email, {String otp = ''}) async {
    var url = Uri.parse("https://nutrihelpb.herokuapp.com/auth");

    var jsonBody = otp == ''
        ? jsonEncode({
            'email': email,
          })
        : jsonEncode({
            'email': email,
            'otp': otp,
          });
    print(jsonBody);
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
      var data = jsonDecode(res.body);
      String status = data['msg'];
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(status)));
      if (otp != '' && data['ok'] == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashBoardScreen(),
          ),
        );
      }
    }
  }
}
