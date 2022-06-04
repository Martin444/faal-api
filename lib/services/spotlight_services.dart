import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:http/http.dart' as http;

import 'api_services.dart';

class SpotlightServices {
  String baseUrl = ApiService().baseUrl;

  Future<http.Response> getSpotlight() async {
    try {
      var url = Uri.parse('$baseUrl/spotlight');
      var response = await http.get(url);
      return response;
    } catch (e) {
      printError(info: e.toString());
      throw Exception(e);
    }
  }

  Future<http.Response> createSpotlight(Object data) async {
    try {
      var url = Uri.parse('$baseUrl/spotlight');
      var response = await http.post(
        url,
        body: data,
        // headers: {
        //   'Authorization': 'Bearer $token',
        //   // 'Content-Type': 'application/json',
        //   // 'Accept': 'application/json'
        // },
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
