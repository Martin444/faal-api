import 'dart:convert';

import 'package:faal/controllers/products/validations/validation_data.dart';
import 'package:faal/services/api_services.dart';
import 'package:faal/services/products_services.dart';
import 'package:get/get.dart';

import '../../Models/product_model.dart';

class ProductsController extends GetxController {
  var baseUrl = ApiService().baseUrl;

  var isLoadingInit = true;
  var isLoadingMoreProd = false;

  bool? get isLoadingMoreProduct => isLoadingMoreProd;

  void setIsLoading(bool value) {
    isLoadingMoreProd = value;
    update();
  }

  bool? loadCategorisProduct = true;

  var promotionsList = <ProductModel>[];
  var productsList = <ProductModel>[];
  var productbyCategorie = <ProductModel>[];

  var validation = ValidationData();

  var modelp = ProductModel();

  Future<List<ProductModel>> getProductsPage(int? page) async {
    try {
      var response = await ProductServices().getProducts(page: page);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        productsList = validation.validateProducts(jsonResponse);
        return productsList;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      productsList = [];
      printError(info: '$e isnt error');
      throw Exception(e);
    }
  }

  Future<List<ProductModel>> getPromotionsProducts() async {
    try {
      var response = await ProductServices().getPromotions();
      var jsonResponse = jsonDecode(response.body);
      isLoadingInit = true;
      update();
      if (response.statusCode == 200) {
        promotionsList = validation.validateProducts(jsonResponse);
        isLoadingInit = false;
        update();
        return promotionsList;
      } else {
        isLoadingInit = false;
        update();
        throw Exception('Failed to load promotions');
      }
    } catch (e) {
      isLoadingInit = false;
      throw Exception(e);
    }
  }

  Future<List<ProductModel>> getProductsByCategory(int idCat) async {
    loadCategorisProduct = true;
    productbyCategorie = [];
    try {
      var response = await ProductServices().getProductsofCategory('$idCat');
      var jsonResponse = jsonDecode(response.body);
      update();
      if (response.statusCode == 201) {
        productbyCategorie = validation.validateProducts(jsonResponse);
        loadCategorisProduct = false;
        update();
        return promotionsList;
      } else {
        printError(info: '${response.statusCode}');
        loadCategorisProduct = false;
        update();
        throw Exception('Failed to load products by category');
      }
    } catch (e) {
      printError(info: 'Si soy $e');
      loadCategorisProduct = false;
      update();
      throw Exception(e);
    }
  }

  void getInitProducts(int? page) async {
    await getProductsPage(page);
    await getPromotionsProducts();
  }
}
