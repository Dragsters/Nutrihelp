import 'dart:convert';
import 'package:http/http.dart' show Client;

class Apiprovider {
  Client client = Client();
  auth() async {
    var url = Uri.parse("https://nutrihelpb.herokuapp.com/auth");

    var jsonBody = jsonEncode({
      'username': '',
      'password': '',
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
      var data = (jsonDecode(res.body)['data']);
      print(data);
    }
  }
}
