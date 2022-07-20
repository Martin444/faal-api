import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:faal/Models/user_model.dart';
import 'package:faal/helps/snacks_messages.dart';
import 'package:faal/views/Login/login_page.dart';
import 'package:faal/views/Payments/Order/succses_order_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:mercadopago_sdk/mercadopago_sdk.dart';
// Models
import 'package:faal/Models/address_model.dart';
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
  double totalPayment = 0.0;
  double mpComision = 0.0;
  String? methodPaySelect = 'Mercado pago';

  MP? mp;

  void addProductBuy(List<ProductModel> product) {
    productBuy = [];
    productBuy = product;
    update();
    getTotalPrice();
  }

  getTotalPrice() {
    try {
      totalPayment = 0.0;
      for (var e in productBuy) {
        printInfo(info: 'Soy el precio del producto ${e.price}');
        totalPayment += double.parse(e.price!) * e.quantity!;
      }
      if (methodPaySelect == 'Mercado pago') {
        var mpC = totalPayment * 0.0992;
        mpComision = mpC;
        totalPayment = totalPayment + mpComision;
      }
      update();
    } catch (e) {
      printError(info: e.toString());
      throw Exception('Error al sumar el precio $e');
    }
  }

  void selectMethodPay(String method) {
    methodPaySelect = method;
    update();
    getTotalPrice();
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

  // Select DIrection

  AddressModel? myAddress;
  String? deliverySelected;

  void selectDelivery(String? delivery) {
    if (delivery == 'Retiro en persona') {
      myAddress = AddressModel(
        id: '2',
        country: 'Argentina',
        city: 'Tartagal',
        address: 'Av.9 de julio 159',
        codepostal: '4560',
      );
    } else {
      myAddress = null;
    }
    deliverySelected = delivery;
    update();
  }

  bool isEqualAddres(AddressModel? add) {
    if (myAddress != null) {
      return myAddress!.id == add!.id;
    } else {
      return false;
    }
  }

  void selectMyAddress(AddressModel? address) {
    myAddress = address;
    update();
  }

  // Post Order

  bool isLoadingOrder = false;
  String? newOrderID;
  var newOrdering = OrderModel();
  ProductModel? productOrdering;
  CreaditCardModel? cardPaymentOrdering;

  void newOrder() async {
    if (user.accessTokenID != null) {
      try {
        isLoadingOrder = true;
        update();
        newOrdering = OrderModel(
          products: productBuy,
          billing: user.userData,
          deliveryAddress: myAddress,
          deliveryType: deliverySelected,
          methodPay: methodPaySelect,
          amount: totalPayment,
          status: 'init',
        );

        var response = await serviceOrder.newOrder(
          user.accessTokenID,
          newOrdering,
        );

        var jsonResponse = jsonDecode(response.body);
        if (response.statusCode == 201) {
          isLoadingOrder = false;
          newOrderID = '${jsonResponse['orderId']}';
          update();

          if (jsonResponse['status'] == 'ok') {
            Get.off(() => SuccesOrderPage(order: newOrderID));
          } else {
            printInfo(info: 'Esta es la respuesta ${jsonResponse}');
            proccessCheckout(jsonResponse['prefenceID']['id']);
          }
        } else if (response.statusCode == 500) {
          isLoadingOrder = false;
          update();
          printError(info: 'Este es el error ${response.statusCode}');
          printError(info: 'Este es el error $jsonResponse');
        } else if (response.statusCode == 401) {
          isLoadingOrder = false;
          update();
          printError(info: 'Este es el error $jsonResponse');
        }
      } catch (e) {
        isLoadingOrder = false;
        update();
        printError(info: 'Este es el error $e');
        throw Exception(e);
      }
    } else {
      Get.to(() => const LoginPage());
    }
  }

  void proccessCheckout(String? id) async {
    try {
      const channelMp = MethodChannel('faal.martinfarel.com/faal');

      final response =
          await channelMp.invokeMethod('mercadoPago', <String, dynamic>{
        "publicKey": 'TEST-372a5910-124d-4ce8-a283-98a6609f2598',
        "preferenceId": id!,
      });

      printInfo(info: 'Soy el response de MP $response');
    } on PlatformException catch (e) {
      throw Exception(e);
    }
  }

  void processPaymentResponse(Object? ob) {
    var responseJson = jsonDecode(ob.toString());
    printInfo(info: 'Processs Payment with $responseJson');
    if (responseJson['resultCode'] != '0') {
      printInfo(info: 'Payment ID ${responseJson['payment']['id']}');
      printInfo(info: 'Payment status ${responseJson['payment']['status']}');
      if (responseJson['payment']['status'] == 'approved') {
        Get.off(() => SuccesOrderPage(order: newOrderID));
      }
      printInfo(
        info: 'Payment status ${responseJson['payment']['statusDetail']}',
      );
    }
  }

  // GET ORDER
  OrderModel? orderDetail;
  bool isLoadDetailOrder = true;

  void getOneOrderDetail(String? orderId) async {
    try {
      var response = await serviceOrder.getOneOrder(
        user.accessTokenID,
        orderId,
      );

      var responseJson = jsonDecode(response.body);
      printInfo(info: 'Este es Order response $responseJson');

      if (response.statusCode == 200) {
        var prods = <ProductModel>[];
        try {
          responseJson['products'].forEach((e) {
            prods.add(
              ProductModel(
                id: e['id'],
                name: e['name'],
                quantity: e['quantity'],
                price: e['price'].toString(),
                regularPrice: e['price'].toString(),
                salePrice: e['price'].toString(),
                images: [e['image']['src']],
              ),
            );
          });
        } catch (e) {
          throw Exception('Error al cargar product $e');
        }
        UserModel? userData;
        try {
          userData = UserModel(
            id: responseJson['billing']['id'],
            photoUrl: responseJson['billing']['photoURL'],
            name: responseJson['billing']['name'],
            email: responseJson['billing']['email'],
            role: responseJson['billing']['role'],
          );
        } catch (e) {
          throw Exception('Error al cargar al usuario $e');
        }
        AddressModel? addresData;
        try {
          addresData = AddressModel(
            id: responseJson['deliveryAddress']['id'],
            city: responseJson['deliveryAddress']['city'],
            address: responseJson['deliveryAddress']['address1'],
            country: responseJson['deliveryAddress']['country'],
            codepostal: responseJson['deliveryAddress']['cpcode'].toString(),
          );
        } catch (e) {
          throw Exception('Error al cargar la direccion $e');
        }

        orderDetail = OrderModel(
          id: responseJson['id'],
          products: prods,
          deliveryType: responseJson['deliveryType'],
          woorderId: responseJson['worderId'],
          billing: userData,
          deliveryAddress: addresData,
          methodPay: responseJson['methodPay'],
          status: responseJson['status'],
          amount: double.parse(responseJson['amount']),
        );
        isLoadDetailOrder = false;
        update();
      }
    } on HttpException catch (e) {
      SnackMessagesHandle()
          .snackErrorHandle('Error al mostrar esta información(${e.message})');
      throw Exception(e);
    }
  }

  // Validate upgrade order
  bool isValidating = false;

  // void validateTakeOrder(String orderID) async {
  //   var validationID = await FlutterBarcodeScanner.scanBarcode(
  //     "#ff6666",
  //     "LISTO",
  //     false,
  //     ScanMode.BARCODE,
  //   );
  //   if (validationID == orderID) {
  //     isValidating = true;
  //     update();
  //     printInfo(info: 'Scanner result $validationID');
  //     var response = await serviceOrder.validateOrder(
  //       user.accessTokenID,
  //       orderID,
  //     );
  //     if (response.statusCode == 201) {
  //       // findMySellers();
  //       isValidating = false;
  //       update();
  //       Get.back();
  //     }
  //     printInfo(info: 'Order status ${response.statusCode}');
  //     printInfo(info: 'Order Response ${response.body}');
  //   } else {
  //     Get.showSnackbar(
  //       const GetSnackBar(
  //         message: 'La orden escaneada es incorrecta',
  //         duration: Duration(seconds: 2),
  //       ),
  //     );
  //   }
  // }
}
