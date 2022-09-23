import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Widgets/personal_data.dart';
import 'Widgets/resume_card.dart';
import 'Widgets/type_payment.dart';

class PaymentDetailsPage extends StatefulWidget {
  const PaymentDetailsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PaymentDetailsPageState createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: Get.height - 30,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 30),
                Text(
                  'Detalles de compra',
                  // style: primaryText,
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                SizedBox(height: 10),
                ResumeCard(),
                SizedBox(height: 20),
                DataPersonal(),
                SizedBox(height: 20),
                TypePayment(),
                Spacer(),
                // ActionsBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
