import 'package:get/get.dart';
import 'package:nft_app/model/nft_metadata.dart';
import 'package:nft_app/provider/contract_connection.dart';

class NftController extends GetxController {
  List<NftMetaData> nftList = [];

  appendNftList(NftMetaData nftMetaData) {
    nftList.add(nftMetaData);
    update();
  }

  removeAll() {
    nftList = [];
    update();
  }
}
