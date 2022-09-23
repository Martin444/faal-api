import 'package:get/get.dart';

import '../../../Models/product_model.dart';

class ValidationData {
  // Para validar los datos de la respuesta http de los productos y devolver la lista de productos
  List<ProductModel> validateProducts(dynamic products) {
    try {
      List<ProductModel> productList = [];
      for (var i in products) {
        if (i != null) {
          productList.add(
            ProductModel(
              id: i['id'],
              name: i['name'],
              price: i['price'].toString().isEmpty
                  ? i['price']
                  : double.parse(i['price']).toStringAsFixed(2),
              permalink: i['urlProduct'],
              regularPrice: i['price'].toString().isEmpty
                  ? i['price']
                  : double.parse(i['regular_price']).toStringAsFixed(2),
              salePrice: i['sale_price'],
              categories: i['categories'],
              images: i['images'].length == 0
                  ? [
                      'https://www.detallesmasbonitaqueninguna.com/server/Portal_0015715/img/products/no_image_xxl.jpg',
                    ]
                  : i['images'],
            ),
          );
        }
      }

      return productList;
    } catch (e) {
      throw Exception(e);
    }
  }
}
