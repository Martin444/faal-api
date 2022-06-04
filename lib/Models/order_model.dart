import 'package:faal/Models/product_model.dart';
import 'package:faal/Models/user_model.dart';

import 'credit_card_model.dart';

class OrderModel {
  String? id;
  ProductModel? product;
  CreaditCardModel? creditCard;
  UserModel? ownerProduct;
  UserModel? ownerOrder;
  String? deliveryType;
  String? deliveryAddress;
  String? methodPay;
  String? status;
  String? description;
  int? amount;

  OrderModel({
    this.id,
    this.product,
    this.creditCard,
    this.deliveryType,
    this.deliveryAddress,
    this.ownerOrder,
    this.ownerProduct,
    this.methodPay,
    this.status,
    this.description,
    this.amount,
  });
}
