import 'api_services.dart';
import 'package:http/http.dart' as http;

class SearchService {
  String baseUrl = ApiService().baseUrl;

  Future<http.Response> getSearch(String query) async {
    try {
      var url = Uri.parse('$baseUrl/products/search/$query');
      final response = await http.post(url);
      return response;
    } catch (e) {
      throw Exception('Failed to load post $e');
    }
  }
}
