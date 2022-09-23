// import 'package:faal/views/Payments/card_tile.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../Models/credit_card_model.dart';
// import '../../controllers/order_controller.dart';
// import '../../widgets/anim/delayed_reveal.dart';

// // ignore: must_be_immutable
// class ListCards extends StatelessWidget {
//   List<CreaditCardModel>? cards;
//   ListCards({
//     Key? key,
//     this.cards,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<OrderController>(
//       builder: (_) {
//         return SizedBox(
//           height: Get.height * 0.6,
//           child: ListView.builder(
//             itemCount: cards!.length,
//             physics: const BouncingScrollPhysics(),
//             itemBuilder: (context, index) => DelayedReveal(
//               delay: Duration(milliseconds: (index * 100)),
//               child: CreditCardTile(
//                 selected: _.selectedCard != null
//                     ? cards![index].id == _.selectedCard!.id
//                     : false,
//                 brand: cards![index].brand,
//                 cardNum: cards![index].cardNumber!.substring(8),
//                 onTaper: () {
//                   _.selectCard(cards![index]);
//                 },
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
