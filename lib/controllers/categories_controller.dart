import 'dart:convert';

import 'package:faal/Models/category_model.dart';
import 'package:get/get.dart';

import '../services/category_services.dart';

class CategoriesController extends GetxController {
  bool? _isLoadingCategorys = true;
  bool? get isLoadingCategorys => _isLoadingCategorys;
  var categoryList = <CategoryModel>[];

  var serviceCategory = CategoryServices();

  getCategoryList(String page) async {
    categoryList = [];
    var categoryResponse = await serviceCategory.getCategorys(page);
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
}
