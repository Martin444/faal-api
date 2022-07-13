import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:mercadopago_sdk/mercadopago_sdk.dart';
import 'package:mercadopago_transparent/mercadopago_transparent.dart';
// Models
import '../Models/credit_card_model.dart';
import '../Models/order_model.dart';
import '../Models/product_model.dart';

// Controllers
import 'login_controller.dart';

// Services
import '../services/card_services.dart';
import '../services/order_services.dart';

class OrderController extends GetxController {
  var deviceInfo = DeviceInfoPlugin();
  var user = Get.find<LoginController>();
  var serviceCard = CardServices();
  var serviceOrder = OrderServices();

  bool? isLoadCard = false;
  String? errorText = '';
  var productBuy = <ProductModel>[];
  int? methodPaySelect;

  MP? mp;

  void addProductBuy(ProductModel product) {
    productBuy = [];
    productBuy.add(product);
  }

  void selectMethodPay(int method) {
    methodPaySelect = method;
    update();
  }

  @override
  void onInit() {
    try {
      mp = MP(
        'TEST-372a5910-124d-4ce8-a283-98a6609f2598',
        'TEST-6615526105581954-061306-973d8162f8b15419766b17bc6a2cadf0-367500631',
      );
    } catch (e) {
      printError(info: 'Error onInit OrderController: $e');
    }
    super.onInit();
  }

  var myCards = <CreaditCardModel>[];

  CreaditCardModel? selectedCard;

  void getMyCards() async {
    myCards = [];
    var response = await serviceCard.getCards(user.accessTokenID);
    printInfo(info: user.accessTokenID!);
    printInfo(info: response.body);
    if (response.statusCode == 201) {
      var json = jsonDecode(response.body);
      for (var item in json) {
        myCards.add(CreaditCardModel(
          id: item['id'],
          cardNumber: item['card_number'],
          cardHolderName: item['holder_name'],
          type: item['type'],
          brand: item['brand'],
        ));
      }
      update();
    }
  }

  void selectCard(CreaditCardModel card) {
    selectedCard = card;
    update();
  }

  void tokenizedCard({
    String? cardNumber,
    String? cardName,
    String? cardCvv,
    String? cardExpiryDate,
  }) async {
    try {
      // isLoadCard = true;
      update();
      printInfo(info: 'Card Number $cardNumber');
      var body = {
        'security_code': cardCvv,
        'expiration_year': cardExpiryDate,
        'expiration_month': cardExpiryDate,
        'card_number': cardNumber!.replaceAll(' ', ''),
        'cardholder': {
          // 'identification': {
          //   'number': documentNumber,
          //   'type': documentType,
          // },
          'name': cardName,
        }
      };

      var tokenCard = await mp!.post(
        '/v1/card_tokens?access_token=TEST-6615526105581954-061306-973d8162f8b15419766b17bc6a2cadf0-367500631',
        data: body,
      );

      printInfo(info: 'Tokenized $tokenCard');
    } catch (e) {
      printError(info: e.toString());
      var error = e.toString();
      if (error != '''Instance of 'response''') {
        var depure = error.split('{')[1];
        var errorObj = depure.replaceAll('}', '');
        var errorJson = jsonDecode('{$errorObj}');
        if (errorJson['error_code'] == 2004) {
          errorText = 'Número de tarjeta inválido';
        } else if (errorJson['error_code'] == 1001) {
          errorText = 'Asegurate de que tu CVV tenga 3 dígitos';
        }
        isLoadCard = false;
        update();
        // Get.to(() => const ErrorPage());
      } else {
        errorText = 'Verifica la información de tu tarjeta';
        isLoadCard = false;
        update();
        // Get.to(() => const ErrorPage());
      }
    }
  }

  void validateNewCard(String? token) async {
    try {
      var info = await deviceInfo.androidInfo;
      var data = {
        'token': token,
        'device_session_id': info.androidId,
      };
      var response = await serviceCard.addNewCard(user.accessTokenID, data);
      var responseJson = jsonDecode(response.body);

      if (response.statusCode == 201) {
        getMyCards();
        isLoadCard = false;
        update();
        Get.back();
      } else if (response.statusCode == 402) {
        if (responseJson['error_code'] == 3001) {
          errorText =
              'Verifica la información de tu tarjeta y vuelve a intentarlo';
        } else if (responseJson['error_code'] == 3002) {
          errorText = 'Verifica que tu tarjeta no esté vencida';
        } else {
          errorText =
              'Verifica la información de tu tarjeta y vuelve a intentarlo';
        }
        isLoadCard = false;
        update();
        // Get.to(() => const ErrorPage());
      } else {
        errorText =
            'Verifica la información de tu tarjeta y vuelve a intentarlo';
        isLoadCard = false;
        update();
        // Get.to(() => const ErrorPage());
      }
      printInfo(info: response.statusCode.toString());
      printInfo(info: response.body);
    } catch (e) {
      printInfo(info: 'No pude $e');
      throw Exception(e);
    }
  }

  // DIrections

  String? myAddress;
  String? deliverySelected;

  void selectDelivery(String? delivery) {
    if (delivery == 'Retiro en persona') {
      myAddress = '';
    } else {
      myAddress = null;
    }
    deliverySelected = delivery;
    update();
  }

  void selectMyAddress(String? address) {
    myAddress = address;
    update();
  }

  // Post Order

  bool isLoadingOrder = false;
  var newOrdering = OrderModel();
  ProductModel? productOrdering;
  CreaditCardModel? cardPaymentOrdering;

  // void newOrder() async {
  //   var info = await deviceInfo.androidInfo;
  //   isLoadingOrder = true;
  //   update();
  //   try {
  //     Object? newOrder;
  //     if (deliverySelected == 'estafeta') {
  //       newOrder = {
  //         "product_id": productBuy[0].id,
  //         "delivery_type": deliverySelected,
  //         "addres_id": myAddress,
  //         "method_pay": "card",
  //         "description":
  //             "Compra de ${productBuy[0].name} por ${productBuy[0].price} ARS",
  //         "device_session_id": info.androidId,
  //         "payment_id": selectedCard!.id,
  //         "status": "waiting",
  //         "state": "initial",
  //         "amount": (int.parse(productBuy[0].price!) + 80),
  //       };
  //     } else {
  //       newOrder = {
  //         "product_id": productBuy[0].id,
  //         "delivery_type": deliverySelected,
  //         "addres_id": myAddress,
  //         "method_pay": "card",
  //         "description":
  //             "Compra de ${productBuy[0].name} por ${productBuy[0].price} MXN",
  //         "device_session_id": info.androidId,
  //         "payment_id": selectedCard!.id,
  //         "status": "waiting",
  //         "state": "initial",
  //         "amount": int.parse(productBuy[0].price!),
  //       };
  //     }
  //     printInfo(info: newOrder.toString());
  //     var response = await serviceOrder.newOrder(user.accessTokenID, newOrder);
  //     if (response.statusCode == 201) {
  //       printInfo(info: response.statusCode.toString());
  //       // printInfo(info: response.body);
  //       var responseOrder = jsonDecode(response.body);
  //       printInfo(info: responseOrder['orderData']['addres_id'].toString());
  //       productOrdering = ProductModel(
  //         id: responseOrder['product']['id'],
  //         name: responseOrder['product']['titleProduct'],
  //         price: responseOrder['product']['price'].toString(),
  //         image: responseOrder['product']['image'],
  //         status: responseOrder['product']['status'],
  //         description: responseOrder['product']['description'],
  //         state: responseOrder['product']['state'],
  //       );
  //       cardPaymentOrdering = CreaditCardModel(
  //         id: responseOrder['payment']['id'],
  //         cardNumber: responseOrder['payment']['card_number'],
  //         cardHolderName: responseOrder['payment']['holder_name'],
  //         type: responseOrder['payment']['type'],
  //         brand: responseOrder['payment']['brand'],
  //       );
  //       newOrdering = OrderModel(
  //         id: responseOrder['orderData']['id'],
  //         deliveryType: responseOrder['orderData']['delivery_type'],
  //         deliveryAddress: responseOrder['orderData']['addres_id'],
  //         product: productOrdering,
  //         creditCard: cardPaymentOrdering,
  //         methodPay: responseOrder['orderData']['method_pay'],
  //         description: responseOrder['orderData']['description'],
  //         status: responseOrder['orderData']['status'],
  //         amount: responseOrder['orderData']['amount'],
  //       );
  //       Get.off(
  //         () => SuccesOrderPage(
  //           order: newOrdering,
  //         ),
  //       );
  //       isLoadingOrder = false;
  //       update();
  //     } else {
  //       printInfo(info: response.body);
  //       isLoadingOrder = false;
  //       update();
  //     }
  //   } catch (e) {
  //     printInfo(info: e.toString());
  //   }
  // }

  // Set view order type
  bool isSellers = true;

  void setTypeView(bool value) {
    isSellers = value;
    update();
  }

  // Find orders
  var mylistOrders = <OrderModel>[];

  // void findMyOrders() async {
  //   mylistOrders = [];
  //   update();
  //   var response = await serviceOrder.getMyOrders(user.accessTokenID);
  //   // printInfo(info: response.body);
  //   if (response.statusCode == 201) {
  //     var responseJson = jsonDecode(response.body);
  //     responseJson.forEach((e) {
  //       var owner = UserModel(
  //         id: e['ownerProduct']['id'],
  //         photoUrl: e['ownerProduct']['photoURL'],
  //         name: e['ownerProduct']['name'],
  //         email: e['ownerProduct']['email'],
  //         role: e['ownerProduct']['role'],
  //       );
  //       var payment = CreaditCardModel(
  //         id: e['payment']['id'],
  //         cardNumber: e['payment']['card_number'],
  //         cardHolderName: e['payment']['holder_name'],
  //         type: e['payment']['type'],
  //         brand: e['payment']['brand'],
  //       );
  //       var product = ProductModel(
  //         id: e['products']['id'],
  //         title: e['products']['titleProduct'],
  //         price: e['products']['price'].toString(),
  //         image: e['products']['image'],
  //         status: e['products']['status'],
  //         description: e['products']['description'],
  //         state: e['products']['state'],
  //       );
  //       mylistOrders.add(
  //         OrderModel(
  //           id: e['element']['id'],
  //           deliveryAddress: e['element']['addres_id'],
  //           deliveryType: e['element']['delivery_type'],
  //           methodPay: e['element']['method_pay'],
  //           product: product,
  //           creditCard: payment,
  //           ownerProduct: owner,
  //           status: e['element']['status'],
  //           description: e['element']['description'],
  //           amount: e['element']['amount'],
  //         ),
  //       );
  //       update();
  //     });
  //   }
  // }

  //  Find sellers

  var mylistSellers = <OrderModel>[];

  // void findMySellers() async {
  //   mylistSellers = [];
  //   var response = await serviceOrder.getMySellers(user.accessTokenID);
  //   printInfo(info: response.body);
  //   if (response.statusCode == 201) {
  //     var responseJson = jsonDecode(response.body);
  //     responseJson.forEach((e) {
  //       var owner = UserModel(
  //         id: e['ownerOrder']['id'],
  //         photoUrl: e['ownerOrder']['photoURL'],
  //         name: e['ownerOrder']['name'],
  //         email: e['ownerOrder']['email'],
  //         role: e['ownerOrder']['role'],
  //       );
  //       var payment = CreaditCardModel(
  //         id: e['payment']['id'],
  //         cardNumber: e['payment']['card_number'],
  //         cardHolderName: e['payment']['holder_name'],
  //         type: e['payment']['type'],
  //         brand: e['payment']['brand'],
  //       );
  //       var product = ProductModel(
  //         id: e['products']['id'],
  //         title: e['products']['titleProduct'],
  //         price: e['products']['price'].toString(),
  //         image: e['products']['image'],
  //         status: e['products']['status'],
  //         description: e['products']['description'],
  //         state: e['products']['state'],
  //       );
  //       mylistSellers.add(
  //         OrderModel(
  //           id: e['element']['id'],
  //           deliveryAddress: e['element']['addres_id'],
  //           deliveryType: e['element']['delivery_type'],
  //           methodPay: e['element']['method_pay'],
  //           product: product,
  //           creditCard: payment,
  //           ownerProduct: owner,
  //           status: e['element']['status'],
  //           description: e['element']['description'],
  //           amount: e['element']['amount'],
  //         ),
  //       );
  //       update();
  //     });
  //   }
  // }

  // Validate upgrade order
  bool isValidating = false;

  void validateTakeOrder(String orderID) async {
    var validationID = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "LISTO",
      false,
      ScanMode.BARCODE,
    );

    if (validationID == orderID) {
      isValidating = true;
      update();
      printInfo(info: 'Scanner result $validationID');
      var response = await serviceOrder.validateOrder(
        user.accessTokenID,
        orderID,
      );
      if (response.statusCode == 201) {
        // findMySellers();

        isValidating = false;
        update();
        Get.back();
      }
      printInfo(info: 'Order status ${response.statusCode}');
      printInfo(info: 'Order Response ${response.body}');
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'La orden escaneada es incorrecta',
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
