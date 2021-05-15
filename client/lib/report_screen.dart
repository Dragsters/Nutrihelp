import 'dart:convert';

import 'package:client/dashboard_screen.dart';
import 'package:client/models/patient_list_object_mode.dart';
import 'package:client/models/report_model.dart';
import 'package:client/resources/helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportScreen extends StatefulWidget {
  final String patientid;
  ReportScreen({this.patientid});

  @override
  _ReportScreenState createState() => _ReportScreenState(this.patientid);
}

class _ReportScreenState extends State<ReportScreen> {
  _ReportScreenState(String _temppatientid) {
    this._patientid = _temppatientid;
  }
  String _patientid;
  bool _loading = true;
  var report;
  void fetchReport() async {
    final localStorage = await SharedPreferences.getInstance();
    final userid = localStorage.getString('userId');
    final url = Uri.parse(
        "https://nutrihelpb.herokuapp.com/reports/diabetes/${userid}/${_patientid}");
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
        body: ListView(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 10),
              child: Container(
                width: deviceWidth * 0.9,
                child: Text(
                  'Prediction Report ',
                  style: GoogleFonts.poppins(fontSize: deviceWidth * 0.08),
                ),
              ),
            )
          ],
        ),
        Container(
          width: deviceWidth * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _loading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: const CircularProgressIndicator(),
                      ),
                    ],
                  )
                : Container(
                    width: deviceWidth * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularPercentIndicator(
                              radius: deviceWidth * 0.4,
                              lineWidth: deviceWidth * 0.02,
                              percent: report.probability / 100,
                              center: Text(
                                  "${(report.probability / 100).toString().substring(0, 4)} %"),
                              progressColor: Colors.green,
                            ),
                          ],
                        ),
                        Text(
                          "Dibetic prediction probability of Patient ${report.patientName} is ${(report.probability / 100).toString().substring(0, 4)} %",
                          style:
                              GoogleFonts.poppins(fontSize: deviceWidth * 0.05),
                        ),
                        hsb(0.01)
                      ],
                    ),
                  ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: deviceWidth * 0.3,
              child: TextButton(
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
                      Text('Back',
                          style: TextStyle(fontSize: deviceWidth * 0.05)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }
}
