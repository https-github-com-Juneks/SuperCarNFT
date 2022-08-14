import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_ipfs/flutter_ipfs.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nft_app/model/nft_metadata.dart';

class IPFS {
  static const IPFS_URL = "https://ipfs.io/ipfs/";

  static Uint8List _convertStringToUint8List(String string) {
    final List<int> codeUnits = string.codeUnits;
    final Uint8List uint8list = Uint8List.fromList(codeUnits);
    return uint8list;
  }

  static String _mapToJsonString(Map<String, dynamic> map) {
    return json.encode(map);
  }

  // JSON string을 IPFS에 업로드한 뒤 CID를 리턴
  static Future<String> uploadMetaDataToIPFS(NftMetaData map) async {
    try {
      final String json = map.toJson().toString();
      final Uint8List bytes = _convertStringToUint8List(json);

      final response = await http.post(
        Uri.parse('https://api.nft.storage/upload'),
        headers: {
          'Authorization': 'Bearer $storageKey',
          'content-type': 'image/*'
        },
        body: bytes,
      );

      final data = jsonDecode(response.body);
      final cid = data['value']['cid'];
      debugPrint('metadata CID -> ${IPFS_URL + cid}');

      return IPFS_URL + cid;
    } catch (e) {
      debugPrint('Error at IPFS Service - upload NFT meta data: $e');
      rethrow;
    }
  }

  static Future<String?> uploadFileToIPFS(File file) async {
    // upload file to ipfs
    final cid = await FlutterIpfs().uploadToIpfs(file.path);
    debugPrint("image URL -> ${IPFS_URL + cid}");
    return IPFS_URL + cid;
  }

  // file을 Pick한 뒤 IPFS로 업로드하고 CID를 리턴
  static Future<String?> uploadPickedFileToIPFS(BuildContext context) async {
    final FilePicker _picker = FilePicker.platform;

    try {
      // Pick an file
      FilePickerResult? file = await _picker.pickFiles();

      //Nothing picked
      if (file == null) {
        Fluttertoast.showToast(
          msg: '파일이 선택되지 않았습니다',
        );
        return null;
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => const ProgressDialog(
            status: 'Upload image to IPFS',
          ),
        );

        // upload file to ipfs
        final cid = await FlutterIpfs().uploadToIpfs(file.files.single.path!);
        debugPrint("image CID -> $cid");

        // Popping out the dialog box
        Navigator.pop(context);

        //Return Path
        return cid;
      }
    } catch (e) {
      debugPrint('Error at file picker: $e');
      SnackBar(
        content: Text(
          'Error at file picker: $e',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
      );
      return null;
    }
  }
}
