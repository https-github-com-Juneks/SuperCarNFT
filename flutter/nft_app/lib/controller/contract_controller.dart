import 'package:get/get.dart';
import 'package:nft_app/model/vote.dart';
import 'package:nft_app/provider/contract_connection.dart';

class ContractController extends GetxController {
  Vote vote = Vote(voteA: 0, voteB: 0);
  late ContractConnection connection;

  @override
  void onInit() {
    connection = ContractConnection();
    getTotalVotes();
    super.onInit();
  }

  Future getTotalVotes() async {
    BigInt voteA = await connection.getTotalVotesAlpha();
    BigInt voteB = await connection.getTotalVotesBeta();
    vote.voteA = voteA.toInt();
    vote.voteB = voteB.toInt();
    update();
  }
}
