import 'package:flutter/material.dart';

class PaymentsIcons extends StatelessWidget {
  const PaymentsIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            'icons/visa.png',
            height: 40,
            package: 'flutter_credit_card',
          ),
          Image.asset(
            'icons/mastercard.png',
            height: 40,
            package: 'flutter_credit_card',
          ),
          Image.asset(
            'icons/amex.png',
            height: 40,
            package: 'flutter_credit_card',
          ),
        ],
      ),
    );
  }
}
