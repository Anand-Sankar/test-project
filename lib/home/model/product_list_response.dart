import 'package:tes_project/home/model/home_list_response.dart';

class ProductListResponse {
  final String? message;
  final ProductData? data;

  ProductListResponse({
    this.message,
    this.data,
  });

  ProductListResponse.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        data = (json['data'] as Map<String, dynamic>?) != null
            ? ProductData.fromJson(json['data'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {'message': message, 'data': data?.toJson()};
}

class ProductData {
  final List<Products>? products;
  final int? total;

  ProductData({
    this.products,
    this.total,
  });

  ProductData.fromJson(Map<String, dynamic> json)
      : products = (json['products'] as List?)
            ?.map((dynamic e) => Products.fromJson(e as Map<String, dynamic>))
            .toList(),
        total = json['total'];

  Map<String, dynamic> toJson() =>
      {'products': products?.map((e) => e.toJson()).toList(), 'total': total};
}

class Products {
  final int? id;
  final String? sku;
  final String? name;
  final String? description;
  final String? image;
  var price;
  var specialPrice;
  final String? availableFrom;
  final String? availableTo;
  final String? isVeg;
  final List<Variations> variations;

  Products({
    this.id,
    this.sku,
    this.name,
    this.description,
    this.image,
    this.price,
    this.specialPrice,
    this.availableFrom,
    this.availableTo,
    this.isVeg,
    required this.variations,
  });

  Products.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        sku = json['sku'],
        name = json['name'],
        description = json['description'],
        image = json['image'],
        price = json['price'],
        specialPrice = json['special_price'],
        availableFrom = json['available_from'],
        availableTo = json['available_to'],
        isVeg = json['is_veg'],
        variations = List.from(json['variations'] ?? [])
            .map((e) => Variations.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'sku': sku,
        'name': name,
        'description': description,
        'image': image,
        'price': price,
        'special_price': specialPrice,
        'available_from': availableFrom,
        'available_to': availableTo,
        'is_veg': isVeg,
        'variations': variations,
      };
}
