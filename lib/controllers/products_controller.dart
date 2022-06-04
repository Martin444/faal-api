import 'dart:convert';

import 'package:faal/services/api_services.dart';
import 'package:faal/services/products_services.dart';
import 'package:get/get.dart';

import '../Models/product_model.dart';

class ProductsController extends GetxController {
  var baseUrl = ApiService().baseUrl;

  var isLoadingInit = false;

  var promotionsList = <ProductModel>[];
  var productsList = <ProductModel>[];

  var modelp = ProductModel();

  void getProductsPage() async {
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
    } else {
      printError(info: '${response.statusCode}');
    }
  }

  void getPromotionsProducts() async {
    var response = await ProductServices().getPromotions();
    var jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      var products = jsonResponse;
      for (var i in products) {
        if (i != null) {
          promotionsList.add(
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
    } else {
      printError(info: '${response.statusCode}');
    }
  }

  void getInitProducts() {
    isLoadingInit = true;
    update();
    getProductsPage();
    getPromotionsProducts();
    isLoadingInit = false;
    update();
  }
}
