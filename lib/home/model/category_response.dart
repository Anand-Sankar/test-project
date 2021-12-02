class CategoryResponse {
  CategoryResponse({
    required this.message,
    required this.data,
  });
  late final String message;
  late final List<CategoryData> data;

  CategoryResponse.fromJson(Map<String, dynamic> json){
    message = json['message'];
    data = List.from(json['data']).map((e)=>CategoryData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class CategoryData {
  CategoryData({
    required this.catId,
    required this.catName,
    this.catImg,
    this.childData,
  });
  late final int catId;
  late final String catName;
  late final String? catImg;
  late final List<ChildData>? childData;

  CategoryData.fromJson(Map<String, dynamic> json){
    catId = json['cat_id'];
    catName = json['cat_name'];
    catImg = json['cat_img'];
    childData = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cat_id'] = catId;
    _data['cat_name'] = catName;
    _data['cat_img'] = catImg;
    _data['child_data'] = childData;
    return _data;
  }
}

class ChildData {
  ChildData({
    required this.catId,
    required this.catName,
    required this.catStatus,
    this.catImage,
  });
  late final int catId;
  late final String catName;
  late final String catStatus;
  late final String? catImage;

  ChildData.fromJson(Map<String, dynamic> json){
    catId = json['cat_id'];
    catName = json['cat_name'];
    catStatus = json['cat_status'];
    catImage = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cat_id'] = catId;
    _data['cat_name'] = catName;
    _data['cat_status'] = catStatus;
    _data['cat_image'] = catImage;
    return _data;
  }
}