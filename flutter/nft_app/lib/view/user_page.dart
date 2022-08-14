import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nft_app/controller/nft_controller.dart';
import 'package:nft_app/model/nft_metadata.dart';
import 'package:nft_app/utils/ipfs.dart';
import 'package:nft_app/view/detail_page.dart';
import 'package:nft_app/view/owner_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:path_provider/path_provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  PageController pageViewController = PageController();
  late NftController nftController;

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final tempFile = await File('${(await getTemporaryDirectory()).path}/$path')
        .create(recursive: true);
    final file = await tempFile.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  Future uploadImageToIPFS(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 15,
                ),
                Text("IPFS Uploading...")
              ]),
            ),
          );
        });

    File file = await getImageFileFromAssets("image/screenshot.jpg");
    String? hashIPFSUrl = await IPFS.uploadFileToIPFS(file);

    Navigator.of(context).pop();

    return hashIPFSUrl;
  }

  @override
  void initState() {
    nftController = Get.find<NftController>();
    print(nftController.nftList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Color(0xFFEAEAEA),
      ),
      backgroundColor: Color(0xFFEAEAEA),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.menu,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.search,
                              size: 30,
                            ))
                      ],
                    ),
                    ElevatedButton(
                      child: Container(
                        child: Image.asset(
                          "assets/image/user.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OwnerPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 50),
                          // maximumSize: const Size(50, 50),
                          shape: const CircleBorder(),
                          primary: Color(0xFFEAEAEA)),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Container(
                            width: double.infinity,
                            height: 250,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 40),
                                  child: PageView(
                                    controller: pageViewController,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      ClipRRect(
                                        child: Image.asset(
                                          'assets/image/porsche.png',
                                          width: 100,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      ClipRRect(
                                        child: Image.asset(
                                          'assets/image/porsche.png',
                                          width: 100,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      ClipRRect(
                                        child: Image.asset(
                                          'assets/image/porsche.png',
                                          width: 100,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, 1),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 20),
                                    child: SmoothPageIndicator(
                                      controller: pageViewController,
                                      count: 3,
                                      axisDirection: Axis.horizontal,
                                      onDotClicked: (i) {
                                        pageViewController.animateToPage(
                                          i,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                      },
                                      effect: const ExpandingDotsEffect(
                                        expansionFactor: 2,
                                        spacing: 10,
                                        radius: 16,
                                        dotWidth: 10,
                                        dotHeight: 10,
                                        dotColor: Color(0xFF9E9E9E),
                                        activeDotColor: Color(0xFF3F51B5),
                                        paintStyle: PaintingStyle.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Column(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 13, 0, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "사용 기간",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 6, 0, 0),
                                            child:
                                                Text("2022/08/02 ~ 2202/08/03"),
                                          )
                                        ],
                                      ),
                                    ),
                                    width: 120,
                                    height: 90,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFEAEAEA),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Container(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(15, 13, 0, 0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "주행 거리",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 6, 0, 0),
                                              child: Text(" 122km"),
                                            )
                                          ],
                                        ),
                                      ),
                                      width: 120,
                                      height: 90,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFEAEAEA),
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(15, 13, 0, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "사고 이력",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 6, 0, 0),
                                          child: Text("무사고"),
                                        )
                                      ],
                                    ),
                                  ),
                                  width: 120,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFEAEAEA),
                                      borderRadius: BorderRadius.circular(25)),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Container(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 13, 0, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "정비일",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 6, 0, 0),
                                            child: Text("2022/6/14"),
                                          )
                                        ],
                                      ),
                                    ),
                                    width: 120,
                                    height: 90,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFEAEAEA),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 13),
                            child: ElevatedButton(
                              onPressed: () async {
                                String hashIPFSUrl =
                                    await uploadImageToIPFS(context);
                                NftMetaData nftMetaData = NftMetaData(
                                    name: "PORSHCE",
                                    date: DateTime.now().toString(),
                                    attributes: "testAttributes",
                                    description: "testDescription",
                                    image: hashIPFSUrl);
                                nftController.appendNftList(nftMetaData);
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserMintPage(),
                                  ),
                                );
                              },
                              child: Text("반납하기"),
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF1B4DB9),
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                            ))
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
