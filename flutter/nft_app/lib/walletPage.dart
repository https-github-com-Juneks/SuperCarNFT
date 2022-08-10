import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
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

  loginUsingMetamask(BuildContext context) async {
    if (!connector.connected) {
      try {
        var session = await connector.createSession(onDisplayUri: (uri) async {
          _uri = uri;
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });
        print(session.accounts[0]);
        print(session.chainId);
        setState(() {
          _session = session;
        });
      } catch (exception) {
        print(exception);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    connector.on(
        'connect',
        (session) => setState(() {
              _session = _session;
            }));
    connector.on(
        'session_update',
        (SessionStatus payload) => setState(() {
              _session = payload;
              print(payload.accounts[0]);
            }));
    connector.on(
        'disconnect',
        (payload) => setState(() {
              _session = null;
            }));

    return Center(
      child: _session != null
          ? Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '계좌주소',
                    style: GoogleFonts.merriweather(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    '${_session?.accounts[0]}',
                    style: GoogleFonts.merriweather(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  )
                ],
              ),
            )
          : ElevatedButton(
              onPressed: () => loginUsingMetamask(context),
              child: const Text("지갑을 연결하세요!"),
            ),
    );
  }
}
