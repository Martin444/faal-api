class ProductModel {
  int? id;
  String? name;
  String? price;
  String? regularPrice;
  String? salePrice;
  int? quantity;
  List<dynamic>? categories;
  List<dynamic>? images;

  fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    price = json['price'] ?? '';
    regularPrice = json['regular_price'] ?? '';
    salePrice = json['sale_price'] ?? '';
    categories = json['categories'] ?? [];
    images = json['images'].length == 0
        ? [
            'https://www.detallesmasbonitaqueninguna.com/server/Portal_0015715/img/products/no_image_xxl.jpg'
          ]
        : json['images'];
  }

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
