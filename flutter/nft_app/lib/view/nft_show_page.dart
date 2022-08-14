import 'package:flutter/material.dart';
import 'package:nft_app/provider/contract_connection.dart';
import 'package:nft_app/view/detail_page.dart';

class NftShowPage extends StatefulWidget {
  const NftShowPage({Key? key}) : super(key: key);

  @override
  _NftShowPageState createState() => _NftShowPageState();
}

class _NftShowPageState extends State<NftShowPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future getNftTokens() async {
    return await ContractConnection.getNftTokens();
  }

  Widget listViewWidget() {
    return const ListTile(
      title: Text('Lorem ipsum dolor...'),
      subtitle: Text('Lorem ipsum dolor...'),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Color(0xFF303030),
        size: 20,
      ),
      tileColor: Color(0xFFF5F5F5),
      dense: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: BackButton(onPressed: () => Navigator.pop(context)),
          automaticallyImplyLeading: false,
          title: Text('NFT 조회'),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: FutureBuilder(
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if ((snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.none) &&
                !snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: snapshot.data[0].length,
                  itemBuilder: (context, idx) {
                    return Text(snapshot.data[0][idx][1]);
                  });
            }
          },
          future: getNftTokens(),
        ));
  }
}
