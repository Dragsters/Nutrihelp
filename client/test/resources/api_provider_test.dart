import 'package:client/resources/api_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert';

void main() {
  test('Request Otp API mocking', () async {
    final apiprovider = Apiprovider();
    apiprovider.client = MockClient((request) async {
      return Response(
          jsonEncode({"msg": "Check Mail for OTP", "ok": true}), 200);
    });
  });
  test('login', () async {
    final apiprovider = Apiprovider();
    apiprovider.client = MockClient((request) async {
      return Response(jsonEncode({"msg": "login success", "ok": true}), 200);
    });
  });
}
