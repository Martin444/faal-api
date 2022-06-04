import 'package:faal/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class MessageServices {
  String baseUrl = ApiService().baseUrl;

  Future<http.Response> findChatWith(String token, String finder) async {
    try {
      var url = Uri.parse('$baseUrl/chat/findWith/$finder');
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      );

      return response;
    } catch (err) {
      printError(info: err.toString());
      throw Exception(err);
    }
  }

  Future<http.Response> sendMessage(
    String token,
    String dataMessage,
  ) async {
    try {
      var url = Uri.parse('$baseUrl/chat/send');
      var response = await http.post(
        url,
        body: dataMessage,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      );

      return response;
    } catch (err) {
      printError(info: err.toString());
      throw Exception(err);
    }
  }

  Future<http.Response> getFollowOfUser(String? token) async {
    try {
      var url = Uri.parse(baseUrl + '/follow/follows');
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

  Future<http.Response> getFollowThisUser(String? id, String? token) async {
    try {
      var url = Uri.parse(baseUrl + '/follow/$id/addFollow');
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

  Future<http.Response> getProfilesFollower(String? token) async {
    try {
      var url = Uri.parse(baseUrl + '/follow/getMeFollow');
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

  Future<http.Response> getDataUserID(String id) async {
    try {
      var url = Uri.parse('$baseUrl/users/$id');
      var response = await http.post(
        url,
        // headers: {
        //   'Authorization': 'Bearer $token',
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json'
        // },
      );

      return response;
    } catch (err) {
      printError(info: err.toString());
      throw Exception(err);
    }
  }
}
