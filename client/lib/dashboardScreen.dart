import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const tilesTitle = [
      'Add patient',
      'recent reports',
      'patients',
      'generate report',
      'about us',
      'logout'
    ];
    const tilesIcons = [
      Icons.person_add_alt_1,
      Icons.list,
      Icons.view_sidebar,
      Icons.assignment,
      Icons.person_pin,
      Icons.logout
    ];

    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffA6E97C), Color(0xffF4F4F4)])),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  height: deviceHeight * 0.35,
                  width: deviceWidth,
                  color: Color(0xff05483f),
                )),
            Positioned(
              top: deviceHeight * 0.16,
              child: Container(
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
            ),
            Positioned(
                top: deviceHeight * 0.09,
                child: Text('NutriHelp',
                    style: GoogleFonts.redressed(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: deviceWidth * 0.1)))),
            Column(
              children: [
                SizedBox(
                  height: deviceHeight * 0.2,
                ),
                Container(
                  height: deviceHeight * 0.75,
                  width: deviceWidth * 0.9,
                  child: GridView.builder(
                      itemCount: 6,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:
                            ((MediaQuery.of(context).size.width) * 4) /
                                (MediaQuery.of(context).size.height) /
                                2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 3.0,
                              child: Container(
                                height: deviceHeight * 0.07,
                                width: deviceWidth * 0.1,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(tilesIcons[index],
                                          size: deviceWidth * 0.15),
                                      color: Color(0xff05483f),
                                    ),
                                    Text(
                                      tilesTitle[index],
                                      style: TextStyle(
                                          color: Color(0xff05483f),
                                          fontSize: deviceWidth * 0.04,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
