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
      'generate \n report',
      'about us',
      'logout'
    ];
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffcaeeb4),
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
              top: deviceHeight * 0.1,
              child: Text('NutriHelp',
                  style: TextStyle(
                      color: Colors.white, fontSize: deviceWidth * 0.1))),
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
                              child: Center(
                                child: Text(tilesTitle[index]),
                              ),
                            ),
                          ));
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
