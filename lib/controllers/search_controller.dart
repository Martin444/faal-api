import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/brand_model.dart';
import '../Models/category_model.dart';
import '../Models/product_model.dart';
import '../services/search_service.dart';

class SearchController extends GetxController {
  var listResult = <ProductModel>[];
  bool? searching = false;
  var searchService = SearchService();

  RangeValues currentRangeValues = const RangeValues(40, 800);

  CategoryModel? _categorySelected;
  CategoryModel? get categorySelected => _categorySelected;

  BrandModel? _brandSelected;
  BrandModel? get brandSelected => _brandSelected;

  String? _wailsSelect;
  String? get wailsSelect => _wailsSelect;

  String? _statusGarment;
  String? get statusGarment => _statusGarment;

  DateTime? _datePublished;
  DateTime? get datePublished => _datePublished;

  DateTime? rangeStart;
  DateTime? rangeEnd;

  setRangeStart({DateTime? start, DateTime? end}) {
    rangeStart = start;
    rangeEnd = end;
    update();
  }

  setDatePushed(DateTime? date) {
    _datePublished = date;
    update();

    Get.back();
  }

  void search(String text) async {
    if (text.length >= 3) {
      try {
        listResult = [];
        searching = true;
        update();
        var resultSearch = await searchService.getSearch(text);
        var jsonResponse = jsonDecode(resultSearch.body);
        if (resultSearch.statusCode == 201) {
          var products = jsonResponse;
          for (var i in products) {
            printInfo(info: i['images'].toString());
            if (i != null) {
              listResult.add(
                ProductModel(
                  id: i['id'],
                  name: i['name'],
                  price: double.parse(i['price']).toStringAsFixed(2),
                  regularPrice: i['regular_price'],
                  salePrice: i['sale_price'],
                  categories: i['categories'],
                  images: i['images'].length == 0
                      ? [
                          'https://www.detallesmasbonitaqueninguna.com/server/Portal_0015715/img/products/no_image_xxl.jpg'
                        ]
                      : i['images'],
                ),
              );
              update();
            }
          }
          // update();
          // return listResult;
        } else {
          printError(info: resultSearch.body);
          Get.snackbar(
            'Lo siento',
            'No se pudo encontrar un producto con ese nombre',
            icon: const Icon(
              Icons.error,
              color: Colors.white,
            ),
            backgroundColor: Colors.red,
            colorText: Colors.white,
            borderRadius: 10,
            snackPosition: SnackPosition.BOTTOM,
          );
          update();
        }
      } catch (e) {
        throw Exception('Failed to load search $e');
      }
    } else {
      searching = false;
      listResult = [];
      update();
    }
    // listResult = listProduct.where((element) {
    //   return element.name.toLowerCase().contains(text.toLowerCase());
    // }).toList();
    // update();
  }

  // Upload Form controllers and variables
  var categoryList = <CategoryModel>[];
  var brandList = <BrandModel>[];

  // var userInfo = Get.find<LoginController>();

  // CategoryServices serviceCategoy = CategoryServices();
  // BrandServices serviceBrand = BrandServices();
  // ProductServices serviceProd = ProductServices();
  // UploadService serviceUp = UploadService();

  bool? _isLoadingCategorys = true;
  bool? get isLoadingCategorys => _isLoadingCategorys;

  // getCategoryList() async {
  //   categoryList = [];
  //   var categoryResponse = await serviceCategoy.getCategorys();
  //   var responseJson = jsonDecode(categoryResponse.body);
  //   responseJson.forEach((e) {
  //     categoryList.add(CategoryModel(
  //       id: e['id'],
  //       nameCategory: e['nameCategory'],
  //       imageCategory: e['photoUrl'],
  //     ));
  //   });
  //   _isLoadingCategorys = false;
  //   update();
  // }

  // selectCategory(CategoryModel category) {
  //   _categorySelected = category;
  //   update();
  //   Get.back();
  // }

  // getGarmentList() async {
  //   garmentList = [];
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

  // getBrandsList() async {
  //   brandList = [];
  //   _isLoadingCategorys = true;
  //   try {
  //     var responseBrand = await serviceBrand.getBrands();
  //     var brandDecode = jsonDecode(responseBrand.body);
  //     printInfo(info: responseBrand.statusCode.toString());
  //     if (responseBrand.statusCode == 200) {
  //       brandDecode.forEach((e) {
  //         brandList.add(
  //           BrandModel(
  //             id: e['id'],
  //             namebrand: e['nameBrand'],
  //             photoUrl: e['photoUrl'],
  //           ),
  //         );
  //         _isLoadingCategorys = false;
  //       });

  //       update();
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

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

  // resetFilters() {
  //   _categorySelected = null;
  //   _garmentSelected = null;
  //   _subGarmentSelected = null;
  //   _brandSelected = null;
  //   _wailsSelect = null;
  //   _statusGarment = null;
  //   _datePublished = null;
  //   update();
  // }

  // getFilters() {
  //   var filters = {
  //     'garment': _categorySelected?.id,
  //     'subGarment': _subGarmentSelected?.id,
  //     'brand': _brandSelected?.id,
  //     'wails': _wailsSelect,
  //     'status': _statusGarment,
  //     'priceInit': currentRangeValues.start.toString(),
  //     'priceEnd': currentRangeValues.end.toString(),
  //     'date': _datePublished?.toIso8601String(),
  //   };

  //   printInfo(info: filters.toString());
  //   return filters;
  // }
}
