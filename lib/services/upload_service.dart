import 'dart:io';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import 'api_services.dart';

class UploadService {
  String baseUrl = ApiService().baseUrl;

  Future<dio.Response> uploadFIle(File file) async {
    try {
      var url = Uri.parse(baseUrl + '/cloudinary/upload');
      var response = await dio.Dio().post(
        url.toString(),
        data: dio.FormData.fromMap({
          'file': dio.MultipartFile.fromFileSync(file.path),
        }),
      );
      return response;
    } catch (e) {
      printError(info: e.toString());
      throw Exception(e);
    }
  }

  Future<dio.Response> uploadFIles(dio.FormData file) async {
    try {
      var url = Uri.parse(baseUrl + '/cloudinary/uploads');
      var response = await dio.Dio().post(
        url.toString(),
        data: file,
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
