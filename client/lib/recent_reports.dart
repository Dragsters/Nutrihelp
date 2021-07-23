import 'package:client/models/report_model.dart';
import 'package:client/resources/api_provider.dart';
import 'package:client/resources/helper.dart';
import 'package:client/view_report.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RecentReportsScreen extends StatefulWidget {
  const RecentReportsScreen({Key key}) : super(key: key);

  @override
  _RecentReportsScreenState createState() => _RecentReportsScreenState();
}

class _RecentReportsScreenState extends State<RecentReportsScreen> {
  dynamic reports;
  bool _loading = false;

  void fetchReports() async {
    try {
      setState(() {
        _loading = true;
      });
      final localStorage = await SharedPreferences.getInstance();
      final userid = localStorage.getString('userId');
      final url =
          Uri.parse("https://nutrihelpb.herokuapp.com/reports/$userid/recent");

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
    } catch (error) {
      setState(() {
        _loading = false;
      });
      throw Exception() ; 
    }
    return null;
  }

  @override
  void initState() {
    fetchReports();
  }

  String per(double p) {
    final String trimmed =
        p.toString().length > 5 ? p.toString().substring(0, 3) : p.toString();

    return "$trimmed %";
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    SizedBox hsb(val) => SizedBox(height: deviceHeight * val);
    return template(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: FractionalOffset.bottomRight,
                  colors: [Color(0xFF4FC3F7), Color(0xFFE1F5FE)])),
          child: ListView(

      children: [

          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10),
            child: Container(

              width: deviceWidth * 0.8,
              height: deviceWidth * .15,
              child: Text(
                'Recent Reports',
                style: GoogleFonts.poppins(fontSize: deviceWidth * 0.12,fontWeight: FontWeight.bold,color: const Color(0xFF01579B)),
              ),
            ),
          ),
          if (_loading)
            Container(
                width: 200,
                height: 200,
                child: const Center(child: CircularProgressIndicator()))
          else
            (reports == null || reports.length == 0)
                ? Container(
                    width: deviceWidth,
                    height: 400,
                    padding: const EdgeInsets.only(top: 200),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('assets/report-not-found.png'),
                          const Text('No recent reports found !',),
                        ]),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reports.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10, bottom: 10),
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
                                      "${reports[index].patientName}",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    hsb(0.01),
                                    Row(
                                      children: [
                                        Text(
                                            "Diabetic probability ${per(reports[index].probability)}")
                                      ],
                                    ),
                                    hsb(0.01),
                                    Container(
                                      width: deviceWidth * 0.8,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewReportScreen(
                                                      reportId:
                                                          reports[index].reportId,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                'View report',
                                                style: TextStyle(
                                                    color: Color(0xFF01579B)),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                deleteReport(context,
                                                    reports[index].reportId);
                                              },
                                              child: const Text(
                                                'delete',
                                                style:
                                                    TextStyle(color: Colors.red),
                                              ))
                                        ],
                                      ),
                                    )
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
    ),
        ));
  }
}
