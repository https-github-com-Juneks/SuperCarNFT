import 'package:flutter/material.dart';
import 'package:nft_app/provider/contract_connection.dart';

class ContractPage extends StatefulWidget {
  const ContractPage({Key? key}) : super(key: key);

  @override
  State<ContractPage> createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {
  var totalVotesA;
  var totalVotesB;
  late ContractConnection connection;

  @override
  void initState() {
    connection = ContractConnection();
    init();
    super.initState();
  }

  init() async {
    totalVotesA = await connection.getTotalVotesAlpha();
    totalVotesB = await connection.getTotalVotesBeta();
    setState(() {});
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
                  connection.vote(true);
                },
                child: Text('Vote Alpha'),
                style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  connection.vote(false);
                  setState(() {});
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
