import 'package:client/generate_report_form.dart';
import 'package:client/models/patient_list_object_mode.dart';
import 'package:client/resources/helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GenerateReportScreen extends StatefulWidget {
  const GenerateReportScreen({Key key}) : super(key: key);

  @override
  _GenerateReportScreenState createState() => _GenerateReportScreenState();
}

class _GenerateReportScreenState extends State<GenerateReportScreen> {
  var patients;
  bool _loading = true;
  void fetchpatients() async {
    final localStorage = await SharedPreferences.getInstance();
    final userid = localStorage.getString('userId');
    final url = Uri.parse("https://nutrihelpb.herokuapp.com/patients/$userid");

    final res = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (res.statusCode == 200) {
      setState(() {
        _loading = false;
        patients = parsePatients(res.body);
      });
    }
    return null;
  }

  @override
  void initState() {
    fetchpatients();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    SizedBox wsb(val) => SizedBox(width: deviceWidth * val);
    SizedBox hsb(val) => SizedBox(height: deviceHeight * val);
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffA6E97C), Color(0xffF4F4F4)])),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            hsb(0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: deviceWidth * 0.9,
                  child: Text(
                    'Select Patient',
                    style: GoogleFonts.poppins(fontSize: deviceWidth * 0.1),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: deviceWidth * 0.9,
                    child: TextField(
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        hoverColor: Colors.white,
                        hintText: 'Search',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(
                          left: deviceWidth * 0.04,
                        ),
                      ),
                    )),
              ],
            ),
            hsb(0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: deviceWidth * 0.4,
                  height: deviceHeight * 0.08,
                  child: newIconButton(context, deviceWidth, deviceHeight),
                ),
              ],
            ),
            hsb(0.02),
            _loading
                ? Container(
                    width: 200,
                    height: 200,
                    child: const Center(child: CircularProgressIndicator()))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: patients.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GenerateReportForm(
                                      patient: patients[index],
                                    )));
                      },
                      child: Padding(
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
                                  child: Container(
                                    width: deviceWidth * 0.2,
                                    height: deviceWidth * 0.16,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        patients[index].name,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      hsb(0.01),
                                      Row(
                                        children: [
                                          Text(patients[index].gender == "M"
                                              ? "Male  "
                                              : "Female  "),
                                          const Icon(
                                            Icons.circle,
                                            size: 6,
                                          ),
                                          Text(
                                              "  ${patients[index].age.toString()} Yrs."),
                                        ],
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
                  ),
          ],
        ),
      ),
    );
  }
}
