import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:http/http.dart' as http;

import 'api_services.dart';

class CategoryServices {
  String baseUrl = ApiService().baseUrl;

  Future<http.Response> getCategorys() async {
    try {
      var url = Uri.parse('$baseUrl/category');
      var response = await http.get(url);
      return response;
    } catch (e) {
      printError(info: e.toString());
      throw Exception(e);
    }
  }

  Future<http.Response> getGarments() async {
    try {
      var url = Uri.parse('$baseUrl/garment');
      var response = await http.get(url);
      return response;
    } catch (e) {
      printError(info: '$e');
      throw Exception(e);
    }
  }
}
