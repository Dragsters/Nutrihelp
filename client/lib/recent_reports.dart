import 'package:client/models/report_model.dart';
import 'package:client/resources/helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RecentReportsScreen extends StatefulWidget {
  RecentReportsScreen({Key key}) : super(key: key);

  @override
  _RecentReportsScreenState createState() => _RecentReportsScreenState();
}

class _RecentReportsScreenState extends State<RecentReportsScreen> {
  var reports;
  bool _loading = true;

  void fetchReports() async {
    final localStorage = await SharedPreferences.getInstance();
    final userid = localStorage.getString('userId');
    final url = Uri.parse("https://nutrihelpb.herokuapp.com/reports/${userid}");

    final res = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (res.statusCode == 200) {
      setState(() {
        _loading = false;
        reports = parseReports(res.body);
      });
    }
    return null;
  }

  @override
  void initState() {
    fetchReports();
  }

  String per(double p) {
    return "${(p * 100).toString().substring(0, 2)} %";
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    wsb(val) => SizedBox(width: deviceWidth * val);
    hsb(val) => SizedBox(height: deviceHeight * val);
    return template(
        body: Column(
      children: [
        hsb(0.03),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10),
              child: Container(
                width: deviceWidth * 0.8,
                child: Text(
                  'Recent Reports',
                  style: GoogleFonts.poppins(fontSize: deviceWidth * 0.1),
                ),
              ),
            )
          ],
        ),
        _loading
            ? Container(
                width: 200,
                height: 200,
                child: const Center(child: CircularProgressIndicator()))
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reports.length,
                itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Patient Name - ${reports[index].patientName}",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500),
                                ),
                                hsb(0.01),
                                Row(
                                  children: [
                                    Text(
                                        "dibetic probability ${per(reports[index].probability)}")
                                  ],
                                ),
                                hsb(0.01),
                                Container(
                                  color: Colors.black,
                                  width: deviceWidth * 0.8,
                                  height: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    width: deviceWidth * 0.7,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: deviceWidth * 0.3,
                                          height: deviceWidth * 0.1,
                                          child: Text('button'),
                                        ),
                                        Container(
                                          width: deviceWidth * 0.3,
                                          height: deviceWidth * 0.1,
                                          child: Text('button'),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ],
    ));
  }
}
