import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nft_app/controller/contract_controller.dart';

class TestPage extends StatelessWidget {
  final controller = Get.put(ContractController());

  TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getTotalVotes();
    return Container(
      child: GetBuilder<ContractController>(
        builder: (controller) => Text(
          '${controller.vote.voteB}',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
