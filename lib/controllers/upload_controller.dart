import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';

import 'package:dio/dio.dart' as dio;
import 'package:images_picker/images_picker.dart';

import '../Models/brand_model.dart';
import '../Models/category_model.dart';
import '../services/brands_services.dart';
import '../services/category_services.dart';
import '../services/products_services.dart';
import '../services/upload_service.dart';
import 'login_controller.dart';

class UploadController extends GetxController {
  var categoryList = <CategoryModel>[];
  var brandList = <BrandModel>[];

  var userInfo = Get.find<LoginController>();

  CategoryServices serviceCategoy = CategoryServices();
  BrandServices serviceBrand = BrandServices();
  ProductServices serviceProd = ProductServices();
  UploadService serviceUp = UploadService();

  CategoryModel? _categorySelected;
  CategoryModel? get categorySelected => _categorySelected;

  BrandModel? _brandSelected;
  BrandModel? get brandSelected => _brandSelected;

  String? _wailsSelect;
  String? get wailsSelect => _wailsSelect;

  String? _statusGarment;
  String? get statusGarment => _statusGarment;

  // Camera cocntrollers and variables
  File? _photoTaked;
  File? get photoTaked => _photoTaked;

  final List<File> _listPhotos = [];
  List<File>? get listPhotos => _listPhotos;
  takePicture(XFile photo) async {
    var newPhoto = File(photo.path);
    var ex = await newPhoto.exists();
    printInfo(info: ex.toString());
    _photoTaked = newPhoto;
    update();
  }

  takeAgain() {
    _photoTaked = null;
    update();
  }

  resetPhotoTaked() {
    _photoTaked = null;
  }

  Future<dynamic> addPhotoToList() async {
    _listPhotos.add(_photoTaked!);
    _photoTaked = null;
    update();
    Get.back();
  }

  removePhototoList(int index) async {
    _listPhotos.removeAt(index);
    update();
  }

  uploadPhotoProduct() async {
    Get.back();
    List<Media>? res = await ImagesPicker.pick(
      count: 3,
      pickType: PickType.image,
    );
    if (res!.isEmpty) {
      Get.snackbar(
        'Error',
        'No selecciono ninguna imagen',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    for (var i = 0; i < res.length; i++) {
      var foto = File(res[i].path);
      _listPhotos.add(foto);
    }
    update();
  }

  Future<dynamic> addPhotoServer(File photo) async {
    var response = await serviceUp.uploadFIle(photo);
    var jsonResponse = jsonDecode(response.toString());
    return jsonResponse;
  }

  // Upload Form controllers and variables

  selectCategory(CategoryModel category) {
    _categorySelected = category;
    update();
    Get.back();
  }

  selectWails(String wails) {
    _wailsSelect = wails;
    update();
    Get.back();
  }

  selectStatus(String status) {
    _statusGarment = status;
    update();
    Get.back();
  }

  // when send te product to server
  bool? _isUpload = false;
  bool? get isUpload => _isUpload;

  Future<List<String>> validatePhotosList() async {
    if (_listPhotos.length <= 2) {
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 3),
          message: 'Debe agregar al menos 3 fotos',
        ),
      );
      return [];
    } else {
      try {
        _isUpload = true;
        update();
        var milist = <dio.MultipartFile>[];
        for (var e in _listPhotos) {
          var data = await e.readAsBytes();
          var listData = data.buffer.asUint8List();
          var file = dio.MultipartFile.fromBytes(
            listData,
            filename: 'image${e.path}.jpg',
            // contentType: MediaType('image', 'jpeg'),
          );
          milist.add(file);
        }

        var data = dio.FormData.fromMap({
          'files': milist,
        });
        var uploadList = await serviceUp.uploadFIles(data);
        var newList = <String>[];

        Map listDecodeUrls = jsonDecode(uploadList.toString());
        listDecodeUrls['body'].forEach((key) {
          newList.add(key);
        });
        _isUpload = false;
        return newList;
      } catch (e) {
        throw Exception(e);
      }
    }
  }
}
