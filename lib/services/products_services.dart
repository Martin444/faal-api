import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:http/http.dart' as http;

import 'api_services.dart';

class ProductServices {
  String baseUrl = ApiService().baseUrl;

  Future<http.Response> getProducts({int? page}) async {
    try {
      var url = Uri.parse('$baseUrl/products/page/$page');
      var response = await http.get(url);
      return response;
    } catch (e) {
      printError(info: e.toString());
      throw Exception(e);
    }
  }

  Future<http.Response> getPromotions() async {
    try {
      var url = Uri.parse('$baseUrl/products/ofers');
      var response = await http.get(url);
      return response;
    } catch (e) {
      printError(info: e.toString());
      throw Exception(e);
    }
  }

  Future<http.Response> getProductsofCategory(String? id) async {
    try {
      var url = Uri.parse(baseUrl + '/products/categorys/$id');
      var response = await http.post(url);
      return response;
    } catch (e) {
      printError(info: e.toString());
      throw Exception(e);
    }
  }

  Future<http.Response> postNewProduct(Object data, String? token) async {
    printInfo(info: token!);
    try {
      var url = Uri.parse(baseUrl + '/products');
      var response = await http.post(
        url,
        body: data,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<http.Response> getLikeThisProduct(String? id, String? token) async {
    try {
      var url = Uri.parse(baseUrl + '/products/$id/likeme');
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

  // Trae los ids de los productos que le gustan
  Future<http.Response> getLikesOfUser(String? token) async {
    try {
      var url = Uri.parse(baseUrl + '/products/likes');
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

  // Trale la data de los productos likeados
  Future<http.Response> getLikesData(String? token) async {
    try {
      var url = Uri.parse(baseUrl + '/products/getProductsLikeme');
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
