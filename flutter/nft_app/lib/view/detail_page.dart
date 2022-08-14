import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UserMintPage extends StatefulWidget {
  const UserMintPage({Key? key}) : super(key: key);

  @override
  _UserMintPageState createState() => _UserMintPageState();
}

class _UserMintPageState extends State<UserMintPage> {
  PageController pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFFEAEAEA),
        title: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xff1B4DB9)),
            child: Padding(
              child: Text("NFT"),
              padding: EdgeInsets.fromLTRB(15, 2, 15, 2),
            )),
      ),
      backgroundColor: Color(0xFFEAEAEA),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 40),
          child: Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/image/porsche.png',
                      fit: BoxFit.fitHeight,
                    ),
                    width: 500,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("PORSCHE",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(
                          "911 Targa",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 8, 10, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "  연식",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  "  2022/3",
                                  style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 14),
                                )),
                          ],
                        ),
                      ),
                      width: 500,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 143, 139, 139),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 8, 10, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "  사용 기간",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  "  2022/08/02 ~ 2022/08/03",
                                  style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 14),
                                )),
                          ],
                        ),
                      ),
                      width: 500,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 143, 139, 139),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 8, 10, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "  주행 거리",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  "  122km",
                                  style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 14),
                                )),
                          ],
                        ),
                      ),
                      width: 500,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 143, 139, 139),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 8, 10, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "  무사고",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  "  2022/6/14",
                                  style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 14),
                                )),
                          ],
                        ),
                      ),
                      width: 500,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 143, 139, 139),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 8, 10, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "  정비일",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  "  2022/6/14",
                                  style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 14),
                                )),
                          ],
                        ),
                      ),
                      width: 500,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 143, 139, 139),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
