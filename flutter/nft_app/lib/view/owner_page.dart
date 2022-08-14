import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nft_app/controller/nft_controller.dart';
import 'package:nft_app/model/nft_metadata.dart';
import 'package:nft_app/utils/contract_connection.dart';
import 'package:nft_app/utils/contract_info.dart';
import 'package:nft_app/utils/ipfs.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class OwnerPage extends StatefulWidget {
  const OwnerPage({Key? key}) : super(key: key);

  @override
  _OwnerPageState createState() => _OwnerPageState();
}

class _OwnerPageState extends State<OwnerPage> {
  late List<NftMetaData> items;
  late NftController nftController;

  var connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
          name: 'SuperCarNFT',
          description: 'superCar rent NFT',
          url: 'https://supercarnft.org',
          icons: [
            'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ]));

  var _uri;
  SessionStatus? _session;

  Future mint(NftMetaData item) async {
    String hashIPFSUrl = await IPFS.uploadMetaDataToIPFS(item);
    ContractConnection.mint(hashIPFSUrl);
  }

  Future mintAll() async {
    for (int i = 0; i < items.length; i++) {
      await mint(items[i]);
    }
    setState(() {
      items = [];
      nftController.removeAll();
    });
  }

  loginUsingMetamask(BuildContext context) async {
    if (!connector.connected) {
      try {
        var session = await connector.createSession(onDisplayUri: (uri) async {
          _uri = uri;
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });
        print(session.accounts);
        print(session.chainId);
        setState(() {
          _session = session;
        });
      } catch (exception) {
        print(exception);
      }
    }
  }

  Uint8List _convertStringToUint8List(String string) {
    final List<int> codeUnits = string.codeUnits;
    final Uint8List uint8list = Uint8List.fromList(codeUnits);
    return uint8list;
  }

  @override
  void initState() {
    nftController = Get.find<NftController>();
    items = nftController.nftList;
    for (int i = 0; i < items.length; i++) {
      print(items[i].image);
    }
    super.initState();
  }

  Widget ListItemWidget(NftMetaData item, Animation<double> animation) {
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(6, 12, 10, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name +
                          "_" +
                          DateFormat("yyyy-MM-dd_HH:mm")
                              .format(DateTime.parse(item.date)),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 10),
                    )
                  ],
                ),
              ),
              width: 150,
              height: 35,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 143, 139, 139),
                  borderRadius: BorderRadius.circular(50)),
            ),
            ElevatedButton(
              onPressed: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) {
                      return Center(
                        child: LoadingAnimationWidget.waveDots(
                          color: Color.fromARGB(255, 64, 123, 172),
                          size: 50,
                        ),
                      );
                    });
                await mint(item);

                Navigator.of(context).pop();
              },
              child: Text("민팅"),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xFF1B4DB9),
                  textStyle: TextStyle(
                    fontSize: 14,
                  ),
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ],
        ),
      ),
    );
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
                            )),
                        IconButton(
                            onPressed: () {
                              loginUsingMetamask(context);
                            },
                            icon: Image.asset("assets/image/Metamask-icon.png"))
                      ],
                    ),
                    ElevatedButton(
                      child: Container(
                        child: Image.asset(
                          "assets/image/owner.png",
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
                    padding: EdgeInsets.fromLTRB(25, 10, 0, 10),
                    child: Column(
                      children: [
                        SizedBox(
                            width: 400,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                              child: Text(
                                "Management",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (_) {
                                        return Center(
                                          child:
                                              LoadingAnimationWidget.waveDots(
                                            color: Color.fromARGB(
                                                255, 64, 123, 172),
                                            size: 50,
                                          ),
                                        );
                                      });
                                  await mintAll();

                                  Navigator.of(context).pop();
                                },
                                child: Text("민팅하기"),
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF1B4DB9),
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                    ),
                                    padding:
                                        EdgeInsets.fromLTRB(25, 10, 25, 10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          child: items.length == 0
                              ? Container()
                              : AnimatedList(
                                  initialItemCount: items.length,
                                  itemBuilder: (context, idx, animation) =>
                                      ListItemWidget(items[idx], animation)),
                          width: 400,
                          height: 400,
                        )
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
