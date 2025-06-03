typedef ProductsModelList = List<ProductsModel>;

class ProductsModel {
  int? id;
  String? name;
  String? category;
  String? description;
  int? price;
  int? discount;
  String? image;

  ProductsModel({
    this.id,
    this.name,
    this.category,
    this.description,
    this.price,
    this.discount,
    this.image,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    category: json['category'] as String?,
    description: json['description'] as String?,
    price: json['price'] as int?,
    discount: json['discount'] as int?,
    image: json['image'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'category': category,
    'description': description,
    'price': price,
    'discount': discount,
    'image': image,
  };
}
