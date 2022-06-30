import 'dart:convert';
import 'dart:io';

// import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:dio/dio.dart' as dio;

import '../Models/brand_model.dart';
import '../Models/category_model.dart';
import '../Models/product_model.dart';
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

  bool? _isLoadingCategorys = true;
  bool? get isLoadingCategorys => _isLoadingCategorys;

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

  List<File> _listPhotos = [];
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
    final image = await ImagePicker().pickMultiImage();
    if (image!.isEmpty) {
      Get.snackbar(
        'Error',
        'No selecciono ninguna imagen',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    for (var i = 0; i < image.length; i++) {
      var foto = File(image[i].path);
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
  getCategoryList() async {
    categoryList = [];
    var categoryResponse = await serviceCategoy.getCategorys();
    var responseJson = jsonDecode(categoryResponse.body);
    responseJson.forEach((e) {
      categoryList.add(CategoryModel(
        id: e['id'],
        nameCategory: e['nameCategory'],
        imageCategory: e['photoUrl'],
      ));
    });
    _isLoadingCategorys = false;
    update();
  }

  selectCategory(CategoryModel category) {
    _categorySelected = category;
    update();
    Get.back();
  }

  // getGarmentList() async {
  //   _isLoadingCategorys = true;
  //   var garmentResponse = await serviceCategoy.getGarments();
  //   var parseResponse = jsonDecode(garmentResponse.body);
  //   if (garmentResponse.statusCode == 200) {
  //     parseResponse.forEach((e) {
  //       var subGarment = <SubGarmentModel>[];
  //       e['sub'].forEach((b) {
  //         subGarment.add(
  //           SubGarmentModel(
  //             id: b['id'],
  //             nameGarment: b['nameGarment'],
  //             ownerGarment: b['ownerGarment'],
  //           ),
  //         );
  //       });
  //       garmentList.add(
  //         GarmentModel(
  //           id: e['id'],
  //           nameGarment: e['nameGarment'],
  //           ownerCategory: e['ownerCategory'],
  //           subGarment: subGarment,
  //         ),
  //       );
  //     });
  //     _isLoadingCategorys = false;
  //     update();
  //   }
  // }

  // selectGarment(GarmentModel garment) {
  //   _garmentSelected = garment;
  //   _subGarmentSelected = null;
  //   update();
  //   Get.back();
  // }

  // selectSubGarmet(SubGarmentModel garment) {
  //   _subGarmentSelected = garment;
  //   _garmentSelected = null;
  //   update();
  //   Get.back();
  //   Get.back();
  // }

  getBrandsList() async {
    brandList = [];
    _isLoadingCategorys = true;
    try {
      var responseBrand = await serviceBrand.getBrands();
      var brandDecode = jsonDecode(responseBrand.body);
      printInfo(info: responseBrand.statusCode.toString());
      if (responseBrand.statusCode == 200) {
        brandDecode.forEach((e) {
          brandList.add(
            BrandModel(
              id: e['id'],
              namebrand: e['nameBrand'],
              photoUrl: e['photoUrl'],
            ),
          );
          _isLoadingCategorys = false;
        });

        update();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  selectBrand(BrandModel brand) {
    _brandSelected = brand;
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

  // Future<ProductModel> uploadProduct({
  //   List<String>? photos,
  //   String? title,
  //   String? description,
  //   String? price,
  // }) async {
  //   try {
  //     var requestProst = jsonEncode({
  //       "titleProduct": title,
  //       "description": description,
  //       "categoryId": categorySelected!.id,
  //       "status": _statusGarment,

  //       "brandId": brandSelected!.id,
  //       "wails": wailsSelect,
  //       "ownerId": userInfo.userData!.id,
  //       "price": price,
  //       "stock": '0',
  //       'image': photos,
  //     });

  //     var responsePost = await serviceProd.postNewProduct(
  //       requestProst,
  //       userInfo.accessTokenID,
  //     );
  //     var upladedProduct = jsonDecode(responsePost.body);

  //     _listPhotos = [];
  //     _photoTaked = null;
  //     _categorySelected = null;

  //     _brandSelected = null;
  //     _wailsSelect = null;
  //     _statusGarment = null;

  //     printError(info: upladedProduct.toString());
  //     // return ProductModel(
  //     //   id: upladedProduct['id'],
  //     //   title: upladedProduct['titleProduct'],
  //     //   description: upladedProduct['description'],
  //     //   status: upladedProduct['status'],
  //     //   price: upladedProduct['price'],
  //     //   state: upladedProduct['state'],
  //     //   image: upladedProduct['image'],
  //     // );
  //   } catch (e) {
  //     printError(info: e.toString());
  //     throw Exception(e);
  //   }
  // }

}
