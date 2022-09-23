import 'dart:convert';

import 'api_services.dart';
import 'package:http/http.dart' as http;

class NotifyService {
  String baseUrl = ApiService().baseUrl;

  Future<http.Response> newNotify(String title, String description) async {
    try {
      var url = Uri.parse('$baseUrl/notifications');
      var dataNotify = {"title": title, "body": description};

      var response = await http.post(
        url,
        body: jsonEncode(dataNotify),
        headers: {
          'Content-Type': 'application/json',
        },
        // headers: {
        //   'Authorization': 'Bearer $token',
        // },
      );
      return response;
    } catch (e) {
      throw Exception('Error http notification: $e');
    }
  }

  Future<http.Response> getNotify() async {
    try {
      var url = Uri.parse('$baseUrl/notifications');

      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        // headers: {
        //   'Authorization': 'Bearer $token',
        // },
      );
      return response;
    } catch (e) {
      throw Exception('Error http notification: $e');
    }
  }
}
