import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;

class Apiprovider {
  Client client = Client();
  auth(String email, {String otp = ''}) async {
    var url = Uri.parse("https://nutrihelpb.herokuapp.com/auth");

    var jsonBody = jsonEncode({
      'email': email,
      'otp': otp,
    });
    print(jsonBody);
    // var decodedBody = jsonDecode(jsonBody);
    // print(decodedBody['token']);

    final res = await http.post(
      url,
      body: jsonBody,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);

      print(data);
    }
  }
}
