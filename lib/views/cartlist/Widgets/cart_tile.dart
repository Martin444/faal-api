import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Models/product_model.dart';
import '../../../controllers/cart_list_controller.dart';

class CartTile extends StatelessWidget {
  final ProductModel product;
  const CartTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartListController>(
      builder: (_) {
        return Text('adsasd');
        // if (false) {
        //   return Container(
        //     padding: const EdgeInsets.only(bottom: 10),
        //     child: Column(
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Flexible(
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     '${product.name}',
        //                     // style: primaryText1,
        //                   ),
        //                   Text(
        //                     '${product.brand} de ${product.contNeto} ${product.unity}',
        //                     // style: secundaryText,
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Flexible(
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 crossAxisAlignment: CrossAxisAlignment.end,
        //                 children: [
        //                   SizedBox(
        //                     width: 90,
        //                     child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                       children: [
        //                         GestureDetector(
        //                           onTap: () {
        //                             // _.removeItemQuantityProduct(product);
        //                           },
        //                           child: Container(
        //                             decoration: const BoxDecoration(
        //                               // color: primaryColor,
        //                             ),
        //                             child: const Icon(
        //                               Icons.remove,
        //                               color: Colors.white,
        //                             ),
        //                           ),
        //                         ),
        //                         // Text(
        //                         //   '${product.quantity}',
        //                         //   // style: primaryText,
        //                         // ),
        //                         GestureDetector(
        //                           onTap: () {
        //                             // _.addItemQuantityProduct(product);
        //                           },
        //                           child: Container(
        //                             decoration: const BoxDecoration(
        //                               // color: primaryColor,
        //                             ),
        //                             child: const Icon(
        //                               Icons.add,
        //                               color: Colors.white,
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                   const SizedBox(
        //                     height: 20,
        //                   ),
        //                   SizedBox(
        //                     width: 100,
        //                     child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.end,
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       children: [
        //                         const Text(
        //                           r'$',
        //                           // style: primaryText1,
        //                         ),
        //                         // Text(
        //                         //   '${int.parse(product.price!) * int.parse(product.quantity!)}',
        //                         //   // style: primaryText,
        //                         // ),
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //         const Divider(
        //           color: Colors.black,
        //           thickness: 1,
        //         ),
        //       ],
        //     ),
        //   );
        // } else {
        //   var tilescode = <Widget>[];
        //   for (var element in product.stock!) {
        //     tilescode.add(GestureDetector(
        //       onTap: () {
        //         _.removeBarcodeInListCart(element, product);
        //       },
        //       child: Container(
        //         width: Get.width,
        //         padding:
        //             const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        //         margin: const EdgeInsets.only(
        //           top: 10,
        //         ),
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(10),
        //           color: Colors.grey[200],
        //         ),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text('#$element', style: subtitleTextBlack),
        //             Row(
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 const Text(r'$'),
        //                 Text('${product.price}', style: subtitleTextBlack),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //     ));
        //   }
        //   return Column(
        //     children: [
        //       ExpansionTile(
        //         expandedCrossAxisAlignment: CrossAxisAlignment.end,
        //         expandedAlignment: Alignment.topCenter,
        //         childrenPadding: const EdgeInsets.all(0),
        //         tilePadding: const EdgeInsets.all(0),
        //         trailing: Column(
        //           crossAxisAlignment: CrossAxisAlignment.end,
        //           children: [
        //             Container(
        //               margin: const EdgeInsets.only(bottom: 5),
        //               width: 80,
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.end,
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 children: [
        //                   const Text(
        //                     r'$',
        //                     style: primaryText1,
        //                   ),
        //                   Text(
        //                     '${int.parse(product.price!) * int.parse(product.quantity!)}',
        //                     style: primaryText,
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             const Text('Ver detalles'),
        //           ],
        //         ),
        //         title: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Flexible(
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     '${product.name} (${product.quantity})',
        //                     style: primaryText1,
        //                   ),
        //                   Text(
        //                     '${product.brand} de ${product.contNeto} ${product.unity}',
        //                     style: secundaryText,
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //         children: [
        //           const SizedBox(
        //             height: 20,
        //           ),
        //           const Text(
        //             'Códigos de barra escaneados (toca el codigo para eliminarlo)',
        //             style: secundaryText,
        //           ),
        //           ...tilescode,
        //         ],
        //       ),
        //       const Divider(
        //         color: Colors.black,
        //         thickness: 1,
        //       ),
        //     ],
        //   );
        // }
      },
    );
  }
}
