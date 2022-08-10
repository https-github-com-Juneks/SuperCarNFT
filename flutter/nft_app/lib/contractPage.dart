import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class ContractPage extends StatefulWidget {
  const ContractPage({Key? key}) : super(key: key);

  @override
  State<ContractPage> createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {
  var totalVotesA;
  var totalVotesB;

  late Client httpClient;
  late Web3Client ethClient;

  //Ethereum address
  final String myAddress = "0x0cBd52136FE6EAcCB3c0534f16974D9DE2Db14E7";

  //url from Infura
  final String blockchainUrl =
      "https://rinkeby.infura.io/v3/343f7e7be4d44389a8202a838b26e2c8";

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(blockchainUrl, httpClient);
    getTotalVotes();
    super.initState();
  }

  Future<DeployedContract> getContract() async {
    // obtain our smart contract using rootbundle to access our json file
    String abiFile = await rootBundle.loadString("assets/contract.json");
    String contractAddress = "0x674757ce53D27d4Baa3fb6E7e010F51d897a1401";
    final contract = DeployedContract(ContractAbi.fromJson(abiFile, "Voting"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> callFunction(String name) async {
    final contract = await getContract();
    final function = contract.function(name);
    final result = await ethClient
        .call(contract: contract, function: function, params: []);
    return result;
  }

  Future<void> getTotalVotes() async {
    List<dynamic> resultsA = await callFunction("getTotalVotesAlpha");
    List<dynamic> resultsB = await callFunction("getTotalVotesBeta");
    totalVotesA = resultsA[0];
    totalVotesB = resultsB[0];

    setState(() {});
  }

  Future<void> vote(bool voteAlpha) async {
    snackBar(label: "Recording vote");
    // obtain private key for write operation
    String privateKey =
        "e188f06ea30be086ed4e229978bc2915f2b0d4c73dda97babd58cc5ae01c9ae8";
    Credentials key = EthPrivateKey.fromHex(privateKey);
    // obtain our contract from abi in json file
    final contract = await getContract();

    // extract function from json file
    final function = contract.function(voteAlpha ? "voteAlpha" : "voteBeta");

    // send transaction using the our private key, function and contract
    await ethClient.sendTransaction(
        key,
        Transaction.callContract(
            contract: contract, function: function, parameters: []),
        chainId: 4);
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    snackBar(label: "verifying vote");
    // set a 20 seconds delay to allow the transaction to be verified before trying to retrieve the balance
    Future.delayed(const Duration(seconds: 20), () {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      snackBar(label: "retrieving votes");
      getTotalVotes();
      ScaffoldMessenger.of(context).clearSnackBars();
    });
  }

  snackBar({String? label}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label!),
            CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
        duration: Duration(days: 1),
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(30),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      child: Text("A"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Total Votes: ${totalVotesA ?? ""}",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      child: Text("B"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Total Votes: ${totalVotesB ?? ""}",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  vote(true);
                },
                child: Text('Vote Alpha'),
                style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  vote(false);
                },
                child: Text('Vote Beta'),
                style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              )
            ],
          )
        ],
      ),
    );
  }
}
