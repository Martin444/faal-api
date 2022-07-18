import 'dart:convert';

import 'package:faal/Models/order_model.dart';
import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:http/http.dart' as http;

import 'api_services.dart';

class OrderServices {
  String baseUrl = ApiService().baseUrl;

  Future<http.Response> newOrder(
    String? token,
    OrderModel? data,
  ) async {
    try {
      var url = Uri.parse('$baseUrl/orders/create');
      var prods = [];

      for (var element in data!.products!) {
        prods.add({
          "id": element.id,
          "name": element.name,
          "price": element.price,
          "quantity": element.quantity,
          "sale_price": element.salePrice,
          "images": [element.images![0]]
        });
      }

      var dataPross = {
        "products": prods,
        "address": {
          "country": 'AR',
          "city": data.deliveryAddress!.city,
          "cpcode": data.deliveryAddress!.codepostal,
          "address1": data.deliveryAddress!.address,
        },
        "pymentType": data.methodPay,
        "amount": data.amount,
        "status": data.status
      };
      var response = await http.post(
        url,
        body: jsonEncode(dataPross),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        // headers: {
        //   'Authorization': 'Bearer $token',
        // },
      );
      return response;
    } catch (e) {
      printError(info: e.toString());
      throw Exception(e);
    }
  }

  Future<http.Response> getCards(String? token) async {
    try {
      var url = Uri.parse('$baseUrl/users/getCards');
      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (e) {
      printError(info: e.toString());
      throw Exception(e);
    }
  }

  Future<http.Response> getMyOrders(String? token) async {
    try {
      var url = Uri.parse('$baseUrl/order/me');
      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (e) {
      printError(info: e.toString());
      throw Exception(e);
    }
  }

  Future<http.Response> getMySellers(String? token) async {
    try {
      var url = Uri.parse('$baseUrl/order/sellers');
      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (e) {
      printError(info: e.toString());
      throw Exception(e);
    }
  }

  Future<http.Response> validateOrder(String? token, String? orderId) async {
    try {
      var url = Uri.parse('$baseUrl/order/validate/$orderId');
      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (e) {
      printError(info: e.toString());
      throw Exception(e);
    }
  }
}
