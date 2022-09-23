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
      var url = Uri.parse('$baseUrl/products/bycategorie/$id');
      var response = await http.post(url);
      return response;
    } catch (e) {
      printError(info: e.toString());
      throw Exception(e);
    }
  }

  Future<http.Response> getProductsRelationates(String? id) async {
    try {
      var url = Uri.parse('$baseUrl/products/relationate/$id');
      var response = await http.post(url);
      return response;
    } catch (e) {
      printError(info: e.toString());
      throw Exception(e);
    }
  }
}
