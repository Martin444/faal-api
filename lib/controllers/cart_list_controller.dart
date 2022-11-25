import 'dart:io';

import 'package:get/get.dart';

import '../Models/product_model.dart';
import 'products/products_controller.dart';

class CartListController extends GetxController {
  List<ProductModel>? listCart = [];
  double totalPrice = 0.0;

  bool isLongCart = false;

  void isLongCartFunction() {
    isLongCart = listCart!.length > 1;
    update();
  }

  var products = Get.find<ProductsController>();

  clearList() {
    listCart = [];
    totalPrice = 0;
    update();
  }

  selectExistProductInList(ProductModel prod) {
    try {
      var exist = listCart!.indexWhere((element) => element.id == prod.id);

      if (exist == -1) {
        addInCartWithOutBarcode(prod, 1);
        isLongCartFunction();
        getTotalPrice();
      } else {
        removeProductInList(prod);
        isLongCartFunction();
        getTotalPrice();
        return true;
      }
    } catch (e) {
      printError(info: e.toString());
      throw Exception('Error al selccionar el producto: $e');
    }
  }

  removeProductInList(ProductModel prod) {
    try {
      var exist = listCart!.indexWhere((element) => element.id == prod.id);

      if (exist != -1) {
        listCart!.removeAt(exist);
        getTotalPrice();
        update();
      }
    } catch (e) {
      throw Exception('Error al selccionar el producto: $e');
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
  removeItemQuantityProduct(ProductModel prod) {
    try {
      var exist = listCart!.indexWhere((element) => element.id == prod.id);
      if (exist != -1) {
        var newQuantity = listCart![exist].quantity! - 1;

        if (newQuantity > 0) {
          var newProd = ProductModel(
            id: prod.id,
            name: prod.name,
            images: prod.images,
            price: double.parse(
              prod.price!,
            ).toStringAsFixed(2),
            quantity: newQuantity,
          );

          listCart![exist] = newProd;
          update();
          getTotalPrice();
        } else {
          listCart!.removeWhere((element) => element.id == prod.id);
          getTotalPrice();
          update();
        }
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  addItemQuantityProduct(ProductModel prod) {
    try {
      var exist = listCart!.indexWhere((element) => element.id == prod.id);
      if (exist != -1) {
        var newQuantity = listCart![exist].quantity! + 1;
        update();

        // var quantyAlarm = listCart![exist].limit! - newQuantity;

        var newProd = ProductModel(
          id: prod.id,
          name: prod.name,
          images: prod.images,
          price: double.parse(prod.price!).toStringAsFixed(2),
          quantity: newQuantity,
        );

        listCart![exist] = newProd;
        getTotalPrice();
        isLongCartFunction();
        update();
      }
    } catch (e) {
      printError(info: e.toString());
      throw Exception('Error al agregar producto');
    }
  }

  addInCartWithOutBarcode(ProductModel prod, int quantity) {
    var newProd = ProductModel(
      id: prod.id,
      name: prod.name,
      images: prod.images,
      price: double.parse(prod.price!).toStringAsFixed(2),
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

  getTotalPrice() {
    try {
      totalPrice = 0.0;
      for (var e in listCart!) {
        totalPrice += double.parse(e.price!) * e.quantity!;
      }
      update();
    } catch (e) {
      printError(info: e.toString());
      throw Exception('Error al sumar el precio $e');
    }
  }

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
}
