import 'dart:convert';

import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:http/http.dart' as http;

import 'api_services.dart';

class OrderServices {
  String baseUrl = ApiService().baseUrl;

  Future<http.Response> newOrder(
    String? token,
    Object? data,
  ) async {
    try {
      var url = Uri.parse('$baseUrl/order');
      var response = await http.post(
        url,
        body: jsonEncode(data),
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
