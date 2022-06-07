import 'dart:convert';

import 'package:faal/services/api_services.dart';
import 'package:faal/services/products_services.dart';
import 'package:get/get.dart';

import '../Models/product_model.dart';

class ProductsController extends GetxController {
  var baseUrl = ApiService().baseUrl;

  var isLoadingInit = true;

  var promotionsList = <ProductModel>[];
  var productsList = <ProductModel>[];

  var modelp = ProductModel();

  Future<List<ProductModel>> getProductsPage() async {
    var response = await ProductServices().getProducts(page: 1);
    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      var products = jsonResponse;
      for (var i in products) {
        if (i != null) {
          productsList.add(
            ProductModel(
              id: i['id'],
              name: i['name'],
              price: i['price'],
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
      return productsList;
    } else {
      printError(info: '${response.statusCode}');
      throw Exception('Failed to load products');
    }
  }

  Future<List<ProductModel>> getPromotionsProducts() async {
    var response = await ProductServices().getPromotions();
    var jsonResponse = jsonDecode(response.body);
    isLoadingInit = true;
    update();
    if (response.statusCode == 200) {
      var products = jsonResponse;
      for (var i in products) {
        if (i != null) {
          promotionsList.add(
            ProductModel(
              id: i['id'],
              name: i['name'],
              price: double.parse(i['price']).toString(),
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
      isLoadingInit = false;
      update();
      return promotionsList;
    } else {
      printError(info: '${response.statusCode}');
      isLoadingInit = false;
      update();
      throw Exception('Failed to load promotions');
    }
  }

  void getInitProducts() async {
    await getProductsPage();
    await getPromotionsProducts();
  }
}
