import 'dart:convert';

import 'package:faal_new2/controllers/products/validations/validation_data.dart';
import 'package:get/get.dart';

import '../../Models/product_model.dart';
import '../../services/api_services.dart';
import '../../services/products_services.dart';

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
  bool? loadRelationatesProduct = true;

  var promotionsList = <ProductModel>[];
  var productsList = <ProductModel>[];
  var productbyCategorie = <ProductModel>[];
  var productbyRelationated = <ProductModel>[];

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

  Future<List<ProductModel>> getProductsByCategory(
    int idCat, {
    int? excluse,
  }) async {
    loadCategorisProduct = true;
    try {
      var response = await ProductServices().getProductsofCategory('$idCat');
      var jsonResponse = jsonDecode(response.body);
      update();
      if (response.statusCode != 201) {
        loadCategorisProduct = false;
        update();
        throw Exception('Failed to load products by category');
      }

      productbyCategorie = [];
      update();
      var newListCategori = validation.validateProducts(jsonResponse);

      for (var element in newListCategori) {
        if (element.id != excluse) {
          productbyCategorie.add(element);
        }
      }
      loadCategorisProduct = false;
      update();
      return promotionsList;
    } catch (e) {
      loadCategorisProduct = false;
      update();
      throw Exception(e);
    }
  }

  void getInitProducts(int? page) async {
    await getProductsPage(page);
    await getPromotionsProducts();
  }

  Future<List<ProductModel>> getProductsRelationates(int idProd) async {
    loadRelationatesProduct = true;
    try {
      var response = await ProductServices().getProductsRelationates('$idProd');
      var jsonResponse = jsonDecode(response.body);
      update();
      if (response.statusCode == 201) {
        productbyRelationated = [];
        update();
        productbyRelationated = validation.validateProducts(jsonResponse);
        loadRelationatesProduct = false;
        update();
        return promotionsList;
      } else {
        printError(info: '${response.statusCode}');
        loadRelationatesProduct = false;
        update();
        throw Exception('Failed to load products by relationatess');
      }
    } catch (e) {
      printError(info: 'Si soy $e');
      loadRelationatesProduct = false;
      update();
      throw Exception(e);
    }
  }
}
