import 'package:faal/Models/address_model.dart';
import 'package:faal/Models/product_model.dart';
import 'package:faal/Models/user_model.dart';

class OrderModel {
  String? id;
  List<ProductModel>? products;
  UserModel? billing;
  AddressModel? deliveryAddress;
  String? deliveryType;
  String? methodPay;
  String? status;
  String? description;
  double? amount;

  OrderModel({
    this.id,
    this.products,
    this.deliveryType,
    this.deliveryAddress,
    this.billing,
    this.methodPay,
    this.status,
    this.description,
    this.amount,
  });
}
