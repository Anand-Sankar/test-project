class HomeListResponse {
  HomeListResponse({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data data;

  HomeListResponse.fromJson(Map<String, dynamic> json){
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.sliderBanners,
    required this.additionalBanners,
    required this.featuredProducts,
    required this.bestsellerProducts,
  });
  late final List<SliderBanners> sliderBanners;
  late final List<AdditionalBanners> additionalBanners;
  late final List<FeaturedProducts> featuredProducts;
  late final List<BestsellerProducts> bestsellerProducts;

  Data.fromJson(Map<String, dynamic> json){
    sliderBanners = List.from(json['slider_banners']).map((e)=>SliderBanners.fromJson(e)).toList();
    additionalBanners = List.from(json['additional_banners']).map((e)=>AdditionalBanners.fromJson(e)).toList();
    featuredProducts = List.from(json['featured_products']).map((e)=>FeaturedProducts.fromJson(e)).toList();
    bestsellerProducts = List.from(json['bestseller_products']).map((e)=>BestsellerProducts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['slider_banners'] = sliderBanners.map((e)=>e.toJson()).toList();
    _data['additional_banners'] = additionalBanners.map((e)=>e.toJson()).toList();
    _data['featured_products'] = featuredProducts.map((e)=>e.toJson()).toList();
    _data['bestseller_products'] = bestsellerProducts.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class SliderBanners {
  SliderBanners({
    required this.id,
    required this.bannerOrder,
    required this.bannerImg,
  });
  late final int id;
  late final String bannerOrder;
  late final String bannerImg;

  SliderBanners.fromJson(Map<String, dynamic> json){
    id = json['id'];
    bannerOrder = json['banner_order'];
    bannerImg = json['banner_img'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['banner_order'] = bannerOrder;
    _data['banner_img'] = bannerImg;
    return _data;
  }
}

class AdditionalBanners {
  AdditionalBanners({
    required this.id,
    required this.bannerOrder,
    required this.bannerImg,
  });
  late final int id;
  late final String bannerOrder;
  late final String bannerImg;

  AdditionalBanners.fromJson(Map<String, dynamic> json){
    id = json['id'];
    bannerOrder = json['banner_order'];
    bannerImg = json['banner_img'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['banner_order'] = bannerOrder;
    _data['banner_img'] = bannerImg;
    return _data;
  }
}

class FeaturedProducts {
  FeaturedProducts({
    required this.id,
    required this.name,
    required this.sku,
    required this.categoryId,
    required this.categoryName,
    required this.isVeg,
    required this.description,
    required this.price,
    required this.specialPrice,
    required this.availableFrom,
    required this.availableTo,
    required this.image,
    required this.variations,
  });
  late final int id;
  late final String name;
  late final String sku;
  late final String categoryId;
  late final String categoryName;
  late final String isVeg;
  late final String description;
  late final String price;
  late  var specialPrice;
  late final String availableFrom;
  late final String availableTo;
  late final String image;
  late final List<Variations> variations;

  FeaturedProducts.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    sku = json['sku'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    isVeg = json['is_veg'];
    description = json['description'];
    price = json['price'];
    specialPrice = json['special_price'];
    availableFrom = json['available_from'];
    availableTo = json['available_to'];
    image = json['image'];
    variations = List.from(json['variations']).map((e)=>Variations.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['sku'] = sku;
    _data['category_id'] = categoryId;
    _data['category_name'] = categoryName;
    _data['is_veg'] = isVeg;
    _data['description'] = description;
    _data['price'] = price;
    _data['special_price'] = specialPrice;
    _data['available_from'] = availableFrom;
    _data['available_to'] = availableTo;
    _data['image'] = image;
    _data['variations'] = variations.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Variations {
  Variations({
    required this.id,
    required this.title,
    required this.price,
    required this.specialPrice,
  });
  late final int id;
  late final String title;
  late final String price;
  late var specialPrice;

  Variations.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    price = json['price'];
    specialPrice = json['special_price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['price'] = price;
    _data['special_price'] = specialPrice;
    return _data;
  }
}

class BestsellerProducts {
  BestsellerProducts({
    required this.id,
    required this.name,
    required this.sku,
    required this.categoryId,
    required this.categoryName,
    required this.isVeg,
    required this.menuStatus,
    required this.description,
    required this.price,
    required this.specialPrice,
    required this.availableFrom,
    required this.availableTo,
    required this.image,
    required this.variations,
    this.orderCount,
  });
  late final int id;
  late final String name;
  late final String sku;
  late final String categoryId;
  late final String categoryName;
  late final String isVeg;
  late final String menuStatus;
  late final String description;
  late final String price;
  late  var specialPrice;
  late final String availableFrom;
  late final String availableTo;
  late final String image;
  late final List<Variations> variations;
  late final Null orderCount;

  BestsellerProducts.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    sku = json['sku'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    isVeg = json['is_veg'];
    menuStatus = json['menu_status'];
    description = json['description'];
    price = json['price'];
    specialPrice = json['special_price'];
    availableFrom = json['available_from'];
    availableTo = json['available_to'];
    image = json['image'];
    variations = List.from(json['variations'] ?? []).map((e)=>Variations.fromJson(e)).toList();
    orderCount = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['sku'] = sku;
    _data['category_id'] = categoryId;
    _data['category_name'] = categoryName;
    _data['is_veg'] = isVeg;
    _data['menu_status'] = menuStatus;
    _data['description'] = description;
    _data['price'] = price;
    _data['special_price'] = specialPrice;
    _data['available_from'] = availableFrom;
    _data['available_to'] = availableTo;
    _data['image'] = image;
    _data['variations'] = variations;
    _data['order_count'] = orderCount;
    return _data;
  }
}