
import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';
import 'package:latlng/latlng.dart';
import 'package:tes_project/home/cubit/home_state.dart';
import 'package:tes_project/home/model/cart_model.dart';
import 'package:tes_project/home/model/category_response.dart';
import 'package:tes_project/home/model/home_list_response.dart';
import 'package:tes_project/home/model/product_list_response.dart';
import 'package:tes_project/home/repository/home_repository.dart';
import 'package:tes_project/objectbox.g.dart';

import '../../main.dart';

class HomeCubit extends Cubit<HomeState> {

  HomeRepository homeRepository;

  HomeCubit(this.homeRepository) : super(const HomeInitialState());

  getHomeDataList() async{
    emit(const HomeLoadingState());
    try {
      final Data data =await homeRepository.getHomeListResponse();
      emit(HomeLoadedState(data));
    } catch (e) {
      emit(HomeLoadedErrorState(e.toString()));
    }
  }

  getHomeCategoryList() async{
    emit(const HomeLoadingState());
    try {
      final List<CategoryData> data = await homeRepository.getHomeCategoryListResponse();
      emit(HomeCategoryLoadedState(data));
    } catch (e) {
      emit(HomeLoadedErrorState(e.toString()));
    }
  }

  updateHomeUI() {
    emit(const HomeUpdateUi());
  }

  void addToCart({
    required int itemId,
    required String itemName,
    required double price,
    required int count,
  }) async {

    try {
      final store = objectbox.store;
      final box = store.box<CartModel>();
      var data = CartModel(itemID: itemId,name: itemName, count: count, price: price);
      Query<CartModel> query = box.query(CartModel_.itemID.equals(itemId)).build();
      List<CartModel> itemList = query.find();
      if(itemList.isEmpty){
            box.put(data);

          }else{
            var data  = itemList.first;
            data.count += 1;
            box.put(data);

          }
      query.close();

      emit(AddedToCartSuccessFully());
    } catch (e) {

      emit(const AddToCartError());
    }

  }

  void getCartValue({required List<CartModel> items}) async{

      try {
        num sum = 0.0;
        for (CartModel cModel in items) {
                sum += (cModel.price * cModel.count);
              }
        await Future.delayed(const Duration(microseconds: 1));
        emit(HomeCartValueState(sum.toStringAsFixed(2)));
      } catch (e) {
        print(e);
      }

  }

  getCartItems() async{
    try{
      final store = objectbox.store;
      final box = store.box<CartModel>();
      List<CartModel> cartItems = box.getAll();

      await Future<void>.delayed(const Duration(microseconds: 1));
      emit(HomeCartItemsLoaded(cartItems));
    }catch(e){
      print(e);
    }
  }

  getUserLocation() async{
    try{
      LatLng latLng = await homeRepository.determinePosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

      String locality =  placemarks.first.subLocality ?? placemarks.first.locality ??"";
      String adminArea =placemarks.first.administrativeArea!;
      String location = ("$locality, $adminArea");
      Future.delayed(const Duration(microseconds: 1));
      emit(UserLocationState(location));
    }catch (e){
      print(e);
    }
  }

  getProductList({required var body}) async{
    try {

      ProductData? data = await  homeRepository.getProductData(body: body);

      emit(MenuProductListLoaded(data));
    } catch (e) {

      print(e);
    }
  }

}