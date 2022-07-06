import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'api_services.dart';

class LoginServices {
  String baseUrl = ApiService().baseUrl;

  Future<http.Response> login(String email, String password) async {
    try {
      var msg = jsonEncode({
        "email": email.toLowerCase(),
        "password": password,
      });
      var url = Uri.parse('$baseUrl/auth/login');
      var response = await http.post(
        url,
        body: msg,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      );

      return response;
    } catch (err) {
      printError(info: 'ERRR ${err.toString()}');
      throw Exception(err);
    }
  }

  Future<http.Response> logOut(String token) async {
    try {
      var url = Uri.parse('$baseUrl/logout');
      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${token.split('|')[1]}',
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

  Future<http.Response> loginSocial({
    String? uid,
    String? photoURL,
    String? name,
    String? email,
  }) async {
    try {
      var msg = jsonEncode({
        "id": uid,
        "photoURL": photoURL,
        "name": '$name',
        "email": email!.toLowerCase(),
        "password": 'password',
        "role": "consumer",
      });
      var url = Uri.parse('$baseUrl/auth/social');
      var response = await http.post(
        url,
        body: msg,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      );

      return response;
    } catch (err) {
      // printError(info: err.toString());
      throw Exception(err);
    }
  }

  Future<http.Response> register({
    String? photoURL,
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
  }) async {
    try {
      var msg = jsonEncode({
        "photoURL": photoURL,
        "name": '$name',
        "photoDNI": [''],
        "email": email!.toLowerCase(),
        "password": password,
        "role": "consumer",
        "phone": '',
      });
      var url = Uri.parse('$baseUrl/auth/register');
      var response = await http.post(
        url,
        body: msg,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      );
      return response;
    } catch (err) {
      // printError(info: err.toString());
      throw Exception(err);
    }
  }

  Future<http.Response> getDataUser(String token) async {
    try {
      var url = Uri.parse('$baseUrl/user/me');
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

  Future<http.Response> getFollowOfUser(String? token) async {
    try {
      var url = Uri.parse('$baseUrl/follow/follows');
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
      var url = Uri.parse('$baseUrl/follow/$id/addFollow');
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
      var url = Uri.parse('$baseUrl/follow/getMeFollow');
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
