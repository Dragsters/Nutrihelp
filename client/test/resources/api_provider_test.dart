import 'package:client/resources/api_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert';

void main() {
  testWidgets('api provider ...', (tester) async {
    // setup the test
    Apiprovider apiprovider = Apiprovider();
    apiprovider.client = MockClient((request) {});
  });
}
