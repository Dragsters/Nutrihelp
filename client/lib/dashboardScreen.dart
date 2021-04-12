import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffcaeeb4),
      body: Stack(
        children: [
          ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                height: deviceHeight * 0.35,
                width: deviceWidth,
                color: Color(0xff05483f),
              )),
          GridView.builder(
              itemCount: 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: ((MediaQuery.of(context).size.width) * 4) /
                    (MediaQuery.of(context).size.height) /
                    2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {},
                    child: Card(
                      elevation: 2.0,
                      child: Container(
                        color: Colors.amber,
                        height: deviceHeight * 0.07,
                        width: deviceWidth * 0.1,
                      ),
                    ));
              }),
        ],
      ),
    );
  }
}
