class UserModel {
  String? id;
  String? photoUrl;
  String? name;
  String? email;
  String? role;
  int? buys;
  int? sales;
  int? follows;
  int? followers;

  UserModel({
    required this.id,
    required this.photoUrl,
    required this.name,
    required this.email,
    required this.role,
    this.buys,
    this.sales,
    this.followers,
    this.follows,
  });
}
