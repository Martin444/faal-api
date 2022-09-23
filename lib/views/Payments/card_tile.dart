import 'package:flutter/material.dart';

import '../../utils/colors.dart';

// ignore: must_be_immutable
class CreditCardTile extends StatelessWidget {
  bool selected;
  String? brand;
  String? cardNum;
  VoidCallback onTaper;
  CreditCardTile({
    required this.selected,
    required this.brand,
    required this.cardNum,
    required this.onTaper,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTaper();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: selected ? kredDesensa : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'icons/$brand.png',
                  height: 50,
                  package: 'flutter_credit_card',
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  cardNum!.replaceAll('X', '*'),
                  style: const TextStyle(
                    fontFamily: 'halter',
                    fontSize: 16,
                    package: 'flutter_credit_card',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
