import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:http/http.dart' as http;

import 'api_services.dart';

class BrandServices {
  String baseUrl = ApiService().baseUrl;

  Future<http.Response> getBrands() async {
    try {
      var url = Uri.parse('$baseUrl/brands');
      var response = await http.get(url);
      return response;
    } catch (e) {
      printError(info: e.toString());
      throw Exception(e);
    }
  }
}
