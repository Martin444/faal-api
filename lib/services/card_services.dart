import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
import 'package:http/http.dart' as http;

import 'api_services.dart';

class CardServices {
  String baseUrl = ApiService().baseUrl;

  Future<http.Response> addNewCard(String? token, Object data) async {
    try {
      var url = Uri.parse('$baseUrl/cards/addCard');
      var response = await http.post(
        url,
        body: data,
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

  Future<http.Response> getCards(String? token) async {
    try {
      var url = Uri.parse('$baseUrl/cards/mycards');
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
