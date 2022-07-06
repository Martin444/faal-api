import 'dart:convert';

import 'package:faal/Models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/category_services.dart';

class CategoriesController extends GetxController {
  bool? _isLoadingCategorys = true;
  bool? get isLoadingCategorys => _isLoadingCategorys;
  int pageCategory = 2;
  bool endCategory = false;
  bool? isLoadingMoreCategorys = false;
  var categoryList = <CategoryModel>[];

  var serviceCategory = CategoryServices();

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
      ));
    });
    _isLoadingCategorys = false;
    update();
    return categoryList;
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
