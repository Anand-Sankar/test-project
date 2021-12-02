class ProductListRequest {
  ProductListRequest({
    required this.currentpage,
    required this.pagesize,
    required this.sortorder,
    required this.searchstring,
    required this.filter,
  });
  late final int currentpage;
  late final int pagesize;
  late final Sortorder sortorder;
  late final String searchstring;
  late final Filter filter;

  ProductListRequest.fromJson(Map<String, dynamic> json){
    currentpage = json['currentpage'];
    pagesize = json['pagesize'];
    sortorder = Sortorder.fromJson(json['sortorder']);
    searchstring = json['searchstring'];
    filter = Filter.fromJson(json['filter']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['currentpage'] = currentpage;
    _data['pagesize'] = pagesize;
    _data['sortorder'] = sortorder.toJson();
    _data['searchstring'] = searchstring;
    _data['filter'] = filter.toJson();
    return _data;
  }
}

class Sortorder {
  Sortorder({
    required this.field,
    required this.direction,
  });
  late final String field;
  late final String direction;

  Sortorder.fromJson(Map<String, dynamic> json){
    field = json['field'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['field'] = field;
    _data['direction'] = direction;
    return _data;
  }
}

class Filter {
  Filter({
    required this.Category,
  });
  late final String Category;

  Filter.fromJson(Map<String, dynamic> json){
    Category = json['Category'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Category'] = Category;
    return _data;
  }
}