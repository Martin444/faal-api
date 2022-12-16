import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/category_model.dart';
import '../services/category_services.dart';

class CategoriesController extends GetxController {
  bool? _isLoadingCategorys = true;
  bool? get isLoadingCategorys => _isLoadingCategorys;
  int pageCategory = 2;
  bool endCategory = false;
  bool? isLoadingMoreCategorys = false;
  var categoryList = <CategoryModel>[];

  var serviceCategory = CategoryServices();

  CategoryModel? parentCategorie;

  Future<List<CategoryModel>> getCategoryList(String page) async {
    categoryList = [];
    _isLoadingCategorys = true;
    var categoryResponse = await serviceCategory.getCategorys(page);
    var responseJson = jsonDecode(categoryResponse.body);
    responseJson.forEach((e) {
      categoryList.add(CategoryModel(
        id: e['id'],
        name: e['name'],
        image: e['image'],
        subCategorie: e['subcategorie'],
        subCategorieID: e['subcategorieID'],
      ));
    });
    _isLoadingCategorys = false;
    update();
    return categoryList;
  }

  getCategoryByID(int id) async {
    try {
      var responseOfCategories = await serviceCategory.getCategorysWithID(id);
      var responseJson = jsonDecode(responseOfCategories.body);

      parentCategorie = CategoryModel(
        id: responseJson[0]['id'],
        name: responseJson[0]['name'],
        image: responseJson[0]['image'],
        subCategorie: responseJson[0]['subcategorie'],
        subCategorieID: responseJson[0]['subcategorieID'],
      );
      update();
      printInfo(info: 'Soy una categoria ${responseOfCategories.body}');
    } catch (e) {
      rethrow;
    }
  }

  scrollChargeMoreCategory(ScrollController controller) async {
    if (controller.position.pixels >= controller.position.maxScrollExtent / 1) {
      endCategory = true;
      update();
    } else {
      endCategory = false;
      update();
    }
  }

  Future<List<CategoryModel>> getMoreCategory() async {
    try {
      isLoadingMoreCategorys = true;
      update();
      var categoryCount =
          await serviceCategory.getCategorys(pageCategory.toString());
      var responseJson = jsonDecode(categoryCount.body);
      responseJson.forEach((e) {
        categoryList.add(CategoryModel(
          id: e['id'],
          name: e['name'],
          image: e['image'],
        ));
      });
      pageCategory += 1;
      isLoadingMoreCategorys = false;
      update();
      return categoryList;
    } catch (e) {
      isLoadingMoreCategorys = false;

      update();
      return categoryList;
    }
  }
}
