class ProductModel {
  int? id;
  String? name;
  String? price;
  String? regularPrice;
  String? salePrice;
  int? quantity;
  List<dynamic>? categories;
  List<dynamic>? images;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.categories,
    this.quantity,
    this.images,
  });
}
