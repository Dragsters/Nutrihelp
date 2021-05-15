import 'dart:convert';

import 'package:client/dashboard_screen.dart';
import 'package:client/models/patient_list_object_mode.dart';
import 'package:client/models/report_model.dart';
import 'package:client/resources/helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportScreen extends StatefulWidget {
  final Patient patient;
  ReportScreen({this.patient});

  @override
  _ReportScreenState createState() => _ReportScreenState(this.patient);
}

class _ReportScreenState extends State<ReportScreen> {
  _ReportScreenState(Patient _temppatient) {
    this._patient = _temppatient;
  }
  Patient _patient;
  bool _loading = true;
  var report;
  void fetchReport() async {
    final localStorage = await SharedPreferences.getInstance();
    final userid = localStorage.getString('userId');
    final url = Uri.parse(
        "https://nutrihelpb.herokuapp.com/reports/diabetes/${userid}/${_patient.id}");

    final res = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (res.statusCode == 200) {
      setState(() {
        _loading = false;
        report = Report.fromJson(jsonDecode(res.body));
      });
    }
    return null;
  }

  @override
  void initState() {
    fetchReport();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    wsb(val) => SizedBox(width: deviceWidth * val);
    hsb(val) => SizedBox(height: deviceHeight * val);
    return template(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: deviceWidth * 0.9,
          height: deviceHeight * 0.6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: _loading
                  ? Container(
                      width: 200,
                      height: 200,
                      child: const CircularProgressIndicator(),
                    )
                  : Container(
                      width: deviceWidth * 0.5,
                      height: deviceHeight * 0.5,
                      child: CircularPercentIndicator(
                        radius: 60.0,
                        lineWidth: 1.0,
                        percent: 1,
                        center: Text("100%"),
                        progressColor: Colors.green,
                      ),
                    ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashBoardScreen()));
          },
          style: TextButton.styleFrom(
            primary: Colors.white,
            minimumSize: Size(deviceWidth * 0.25, deviceHeight * 0.07),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            backgroundColor: const Color(0xff05483F),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.arrow_back_ios),
                Text('Back', style: TextStyle(fontSize: deviceWidth * 0.05)),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
