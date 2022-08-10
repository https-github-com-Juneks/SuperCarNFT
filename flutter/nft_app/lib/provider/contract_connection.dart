import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:nft_app/utils/contract_info.dart';
import 'package:web3dart/web3dart.dart';

class ContractConnection {
  ContractConnection._privateConstructor();
  static final ContractConnection _instance =
      ContractConnection._privateConstructor();

  factory ContractConnection() {
    return _instance;
  }

  Future<DeployedContract> _getContract() async {
    // obtain our smart contract using rootbundle to access our json file
    String abiFile = await rootBundle.loadString(ContractInfo.abiFileName);
    String contractAddress = ContractInfo.contractAddress;
    final contract = DeployedContract(
        ContractAbi.fromJson(abiFile, ContractInfo.contractName),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> _callFunction(String name) async {
    final contract = await _getContract();
    final function = contract.function(name);
    var ethClient = Web3Client(ContractInfo.blockChainUrl, Client());
    final result = await ethClient
        .call(contract: contract, function: function, params: []);
    return result;
  }

  Future getTotalVotesAlpha() async {
    List<dynamic> result = await _callFunction("getTotalVotesAlpha");
    return result[0];
  }

  Future getTotalVotesBeta() async {
    List<dynamic> result = await _callFunction("getTotalVotesBeta");
    return result[0];
  }

  Future<void> vote(bool voteAlpha) async {
    // obtain private key for write operation
    String privateKey = ContractInfo.privateKey;
    Credentials key = EthPrivateKey.fromHex(privateKey);
    // obtain our contract from abi in json file
    final contract = await _getContract();

    // extract function from json file
    final function = contract.function(voteAlpha ? "voteAlpha" : "voteBeta");

    // send transaction using the our private key, function and contract
    var ethClient = Web3Client(ContractInfo.blockChainUrl, Client());
    await ethClient.sendTransaction(
        key,
        Transaction.callContract(
            contract: contract, function: function, parameters: []),
        chainId: 4);
  }
}
