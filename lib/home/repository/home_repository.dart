import 'dart:convert';

import 'package:latlng/latlng.dart';
import 'package:location/location.dart';
import 'package:tes_project/home/model/category_response.dart';
import 'package:tes_project/home/model/home_list_response.dart';
import 'package:http/http.dart' as http;
import 'package:tes_project/home/model/product_list_response.dart';

class HomeRepository {
  Map<String, String> header = {"Authorization": "Bearer akhil@intertoons.com"};

  Future<Data> getHomeListResponse() async {
    try {
      var response = await http.get(
          Uri.parse("http://fda.intertoons.com/api/V1/home"),
          headers: header);
      var responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        var actualResponse = HomeListResponse.fromJson(responseJson);
        return actualResponse.data;
      } else {
        throw responseJson["message"];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<CategoryData>> getHomeCategoryListResponse() async {
    try {
      var response = await http.get(
          Uri.parse("http://fda.intertoons.com/api/V1/categories"),
          headers: header);
      var responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        var actualResponse = CategoryResponse.fromJson(responseJson);
        return actualResponse.data;
      } else {
        throw responseJson["message"];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<LatLng> determinePosition() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw "Permission disabled";
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw "Permission disabled";
      }
    }

    _locationData = await location.getLocation();
    LatLng latLng = LatLng(_locationData.latitude!, _locationData.longitude!);
    return latLng;
  }

  Future<ProductData?> getProductData({required Map body}) async{
    try {

      var response = await http.post(
          Uri.parse("http://fda.intertoons.com/api/V1/products"),
          headers: header,body: json.encode(body));

      var responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        print(responseJson);
        var actualResponse = ProductListResponse.fromJson(responseJson);
        return actualResponse.data;
      } else {
        throw responseJson["message"];
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
