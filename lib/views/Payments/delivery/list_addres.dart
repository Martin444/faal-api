import 'package:faal/controllers/address_controller.dart';
import 'package:faal/views/Payments/delivery/delivery_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/text_styles.dart';

class ListAddres extends StatefulWidget {
  const ListAddres({Key? key}) : super(key: key);

  @override
  State<ListAddres> createState() => _ListAddresState();
}

class _ListAddresState extends State<ListAddres> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(builder: (_) {
      return SizedBox(
        height: Get.height * 0.47,
        child: ListView.builder(
          itemCount: _.myAddress.length,
          itemBuilder: (context, index) {
            return DeliveryTile(
              selected: false,
              brand: Text(
                '${_.myAddress[index].address}',
                style: titleAppBar,
              ),
              onTaper: () {},
            );
          },
        ),
      );
    });
  }
}
