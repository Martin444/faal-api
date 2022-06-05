import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import '../Models/product_model.dart';
import '../views/cartlist/cart_list_page.dart';
import 'products_controller.dart';

class CartListController extends GetxController {
  List<ProductModel>? listCart = [];
  int totalPrice = 0;

  var products = Get.find<ProductsController>();

  clearList() {
    listCart = [];
    totalPrice = 0;
    update();
  }

  selectExistProductInList(ProductModel prod) {
    try {
      var exist = listCart!.indexWhere((element) => element.id == prod.id);

      printInfo(info: exist.toString());
      if (exist == -1) {
        addInCartWithOutBarcode(prod, 1);
        Get.back();
      } else {
        addItemQuantityProduct(prod);

        Get.back();
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  // validateExistProductInList(ProductModel prod) {
  //   try {
  //     var exist = listCart!.indexWhere((element) => element.id == prod.id);

  //     if (exist == -1) {
  //       printInfo(info: exist.toString());
  //       addInCartWithOutBarcode(prod, 1);
  //       Get.to(
  //         () => const CartListPage(),
  //         transition: Transition.leftToRight,
  //       );
  //     } else {
  //       addItemQuantityProduct(prod);

  //       Get.to(
  //         () => const CartListPage(),
  //         transition: Transition.leftToRight,
  //       );
  //     }
  //   } catch (e) {
  //     printError(info: e.toString());
  //   }
  // }

  // removeBarcodeInListCart(int code, ProductModel prod) {
  //   printInfo(info: code.toString());
  //   try {
  //     var exist = listCart!.indexWhere((element) => element.id == prod.id);

  //     if (exist != -1) {
  //       listCart![exist].stock!.remove(code);
  //       listCart![exist].quantity = listCart![exist].stock!.length.toString();
  //       if (listCart![exist].stock!.isEmpty) {
  //         listCart!.removeAt(exist);
  //       }
  //       getTotalPrice();
  //     }
  //   } catch (e) {
  //     printError(info: e.toString());
  //   }
  // }

// // para productos sin condigo de barra
//   removeItemQuantityProduct(ProductsModel prod) {
//     try {
//       var exist = listCart!.indexWhere((element) => element.id == prod.id);
//       if (exist != -1) {
//         var newQuantity = int.parse(listCart![exist].quantity!) - 1;

//         if (newQuantity > 0) {
//           var newProd = ProductsModel(
//             id: prod.id,
//             name: prod.name,
//             brand: prod.brand,
//             contNeto: prod.contNeto,
//             unity: prod.unity,
//             image: prod.image,
//             image64: prod.image64,
//             price: prod.price,
//             barcode: prod.barcode,
//             quantity: '$newQuantity',
//             limit: prod.limit,
//             alarm: prod.alarm,
//           );

//           listCart![exist] = newProd;
//           update();
//           getTotalPrice();
//         } else {
//           listCart!.removeWhere((element) => element.id == prod.id);
//           getTotalPrice();
//           update();
//         }
//       }
//     } catch (e) {
//       printError(info: e.toString());
//     }
//   }

  addItemQuantityProduct(ProductModel prod) {
    try {
      var exist = listCart!.indexWhere((element) => element.id == prod.id);
      if (exist != -1) {
        var newQuantity = listCart![exist].quantity! + 1;
        update();

        // var quantyAlarm = listCart![exist].limit! - newQuantity;
        if (true) {
          // if (quantyAlarm == prod.alarm) {
          //   Get.dialog(
          //     AlarmProduct(
          //       limit: quantyAlarm,
          //       nameProduct: prod.name,
          //     ),
          //     barrierDismissible: false,
          //   );
          // }

          var newProd = ProductModel(
            id: prod.id,
            name: prod.name,
            price: prod.price.toString(),
            quantity: newQuantity,
          );

          listCart![exist] = newProd;
          // getTotalPrice();
          update();
        }
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  addInCartWithOutBarcode(ProductModel prod, int quantity) {
    var newProd = ProductModel(
      id: prod.id,
      name: prod.name,
      price: prod.price,
      quantity: quantity,
    );

    listCart!.add(newProd);
    update();
  }

  bool validatinExistInList(ProductModel prod) {
    try {
      var exist = listCart!.indexWhere((element) => element.id == prod.id);

      if (exist == -1) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      printError(info: e.toString());
      throw Exception('Error validatinExistInList');
    }
  }

  //   getTotalPrice();
  // }

  // addProductWithBarcode() async {
  //   var resultado = '';
  //   try {
  //     do {
  //       int barcodeScanRes = int.parse(await FlutterBarcodeScanner.scanBarcode(
  //         "#ff6666",
  //         "LISTO",
  //         false,
  //         ScanMode.BARCODE,
  //       ));

  //       if (barcodeScanRes != -1) {
  //         for (var e in products.myProducts) {
  //           var search = e.stock!.contains(barcodeScanRes);
  //           // printInfo(info: e.stock!.toString());
  //           if (search) {
  //             var exist = listCart!.indexWhere((element) => element.id == e.id);
  //             if (exist == -1) {
  //               var quantity = 1;
  //               var newProd = ProductsModel(
  //                 id: e.id,
  //                 name: e.name,
  //                 brand: e.brand,
  //                 contNeto: e.contNeto,
  //                 unity: e.unity,
  //                 image: e.image,
  //                 image64: e.image64,
  //                 price: e.price,
  //                 barcode: e.barcode,
  //                 quantity: quantity.toString(),
  //                 stock: [barcodeScanRes],
  //               );

  //               listCart!.add(newProd);
  //               getTotalPrice();
  //               update();
  //             } else {
  //               var barcodeExist =
  //                   listCart![exist].stock!.contains(barcodeScanRes);

  //               if (barcodeExist) {
  //                 // addItemQuantityProduct(e);
  //                 resultado = '-1';
  //                 update();
  //                 return;
  //               } else {
  //                 printInfo(info: 'No existe $barcodeScanRes');
  //                 var quantity = int.parse(listCart![exist].quantity!) + 1;
  //                 listCart![exist].stock!.add(barcodeScanRes);
  //                 var newProd = ProductsModel(
  //                   id: e.id,
  //                   name: e.name,
  //                   brand: e.brand,
  //                   contNeto: e.contNeto,
  //                   unity: e.unity,
  //                   image: e.image,
  //                   image64: e.image64,
  //                   price: e.price,
  //                   barcode: e.barcode,
  //                   quantity: quantity.toString(),
  //                   stock: listCart![exist].stock,
  //                 );
  //                 listCart![exist] = newProd;
  //                 getTotalPrice();
  //                 update();
  //               }
  //             }
  //           } else {
  //             resultado = '2';
  //             update();
  //           }
  //         }
  //       } else {
  //         resultado = '-1';
  //         update();
  //       }
  //       printInfo(info: resultado);
  //       if (resultado == '2') {
  //         resultado = '-1';
  //         update();
  //         Get.showSnackbar(
  //           GetBar(
  //             message: 'No se encontró en el inventario',
  //             snackPosition: SnackPosition.TOP,
  //             duration: const Duration(seconds: 2),
  //           ),
  //         );
  //       }
  //     } while (resultado != '-1');
  //   } catch (e) {
  //     printError(info: e.toString());
  //   }

  // getTotalPrice() {
  //   totalPrice = 0;
  //   for (var e in listCart!) {
  //     totalPrice += int.parse(e.price!) * int.parse(e.quantity!);
  //   }
  //   update();
  // }

  // Controlladores de venta
  String? _nameSeller = 'Vendedor 1';
  File? photoSeller = File('assets/profile.jpg');
  String? get nameSeller => _nameSeller;

  String? _errorNameSeller;
  String? get errorNameSeller => _errorNameSeller;

  String? _errorNameBuyer;
  File? photoBuyer;
  String? get errorNameBuyer => _errorNameBuyer;

  String? _nameBuyer = 'Comprador 1';
  String? get nameBuyer => _nameBuyer;

  bool? _targetPay = false;
  bool? get targetPay => _targetPay;

  setTargetPay(bool value) {
    _targetPay = value;
    update();
  }

  setNameSeller(String? value) {
    _nameSeller = value;
    printInfo(info: _nameSeller!);
    update();
  }

  setNameBuyer(String? value) {
    _nameBuyer = value;
    update();
  }

  // processBuy() async {
  //   _errorNameSeller = null;
  //   _errorNameBuyer = null;
  //   update();
  //   if (_nameSeller!.isNotEmpty) {
  //     if (_nameBuyer!.isNotEmpty) {
  //       photoBuyer = await getImageFileFromAssets('profile.jpg');
  //       photoSeller = await getImageFileFromAssets('profilew.jpg');

  //       var photoSByte = photoSeller!.readAsBytesSync();
  //       String baseS64 = base64Encode(photoSByte);
  //       var photoBByte = photoBuyer!.readAsBytesSync();
  //       String baseB64 = base64Encode(photoBByte);

  //       var newBuy = CartPayModel(
  //         totalPrice: totalPrice,
  //         date: DateTime.now().toIso8601String(),
  //         relativeDate: DateFormat('dd/MM/yyyy').format(DateTime.now()),
  //         buyerName: _nameBuyer,
  //         buyerPhoto64: baseB64,
  //         sellerName: _nameSeller,
  //         sellerPhoto64: baseS64,
  //         targetPay: _targetPay,
  //         pending: false,
  //         listCart: listCart,
  //       );

  //       descontStock(listCart);

  //       pushCartInDB(newBuy);
  //     } else {
  //       _errorNameBuyer = 'Escribe un nombre para el comprador';
  //     }
  //   } else {
  //     _errorNameSeller = 'Escribe un nombre para el vendedor';
  //     update();
  //   }
  // }

  // descontStock(List<ProductsModel>? prod) async {
  //   for (var e in prod!) {
  //     if (!e.barcode!) {
  //       for (var i in e.stock!) {
  //         for (var j in products.myProducts) {
  //           if (j.id == e.id) {
  //             var index = j.stock!.indexWhere((element) => element == i);
  //             if (index != -1) {
  //               j.quantity = (int.parse(j.quantity!) - 1).toString();
  //               j.stock!.removeAt(index);
  //               var formData = {
  //                 'id': j.id,
  //                 'name': j.name,
  //                 'brand': j.brand,
  //                 'price': j.price,
  //                 'stock': j.stock.toString(),
  //                 'neto': j.contNeto.toString(),
  //                 'unity': j.unity,
  //                 'image': j.image64,
  //                 // 'image64': j.image64,
  //                 'quantity': j.quantity.toString(),
  //                 'barcode': j.barcode.toString(),
  //               };
  //               await ProductServices().editProduct(formData);

  //               update();
  //             }
  //           }
  //         }
  //       }
  //     } else {
  //       for (var j in products.myProducts) {
  //         if (j.id == e.id) {
  //           j.quantity =
  //               (int.parse(j.quantity!) - int.parse(e.quantity!)).toString();
  //           var formData = {
  //             'id': j.id,
  //             'name': j.name,
  //             'brand': j.brand,
  //             'price': j.price,
  //             'stock': j.stock.toString(),
  //             'neto': j.contNeto.toString(),
  //             'unity': j.unity,
  //             'image': j.image64,
  //             // 'image64': j.image64,
  //             'quantity': j.quantity.toString(),
  //             'barcode': j.barcode.toString(),
  //           };
  //           await ProductServices().editProduct(formData);
  //           update();
  //         }
  //       }
  //       update();
  //     }
  //   }
  // }

  // pushCartInDB(CartPayModel? cart) async {
  //   try {
  //     var listEncodeCart = [];

  //     for (var element in cart!.listCart!) {
  //       var jsan = jsonEncode(element);
  //       listEncodeCart.add(jsan);
  //     }

  //     var buycito = <String, String>{
  //       'totalPrice': cart.totalPrice.toString(),
  //       'date': cart.date!,
  //       'relativeDate': cart.relativeDate!,
  //       'buyerName': cart.buyerName!,
  //       'buyerPhoto64': cart.buyerPhoto64!,
  //       'sellerName': cart.sellerName!,
  //       'sellerPhoto64': cart.sellerPhoto64!,
  //       'targetPay': cart.targetPay!.toString(),
  //       'pending': cart.pending!.toString(),
  //       'listCart': listEncodeCart.toString(),
  //     };

  //     var response = await HistoryServices().addBuyinHitory(buycito);

  //     if (response.runtimeType == int) {
  //       clearList();
  //       Get.dialog(
  //         const SuccesBuy(),
  //         barrierDismissible: false,
  //       );
  //     }

  //     printInfo(info: 'SOy el response ${response.toString()}');
  //   } catch (e) {
  //     ProductServices().deleteDataBaseProduct();
  //     printError(info: e.toString());
  //   }
  // }

  // Future<File> getImageFileFromAssets(String path) async {
  //   final byteData = await rootBundle.load('assets/$path');

  //   final file = File('${(await getTemporaryDirectory()).path}/$path');
  //   await file.writeAsBytes(byteData.buffer
  //       .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  //   return file;
  // }

}
