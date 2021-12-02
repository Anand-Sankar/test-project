import 'package:http/http.dart';
import 'package:tes_project/home/model/cart_model.dart';
import 'package:tes_project/home/model/category_response.dart';
import 'package:tes_project/home/model/home_list_response.dart';
import 'package:tes_project/home/model/product_list_response.dart';

abstract class HomeState {
  const HomeState();
}

 class HomeInitialState extends HomeState{
  const HomeInitialState();
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}
class HomeLoadedState extends HomeState {
  final Data response;
  const HomeLoadedState(this.response);
}

class HomeUpdateUi extends HomeState {
  const HomeUpdateUi();
}

class AddedToCartSuccessFully extends HomeState {

  const AddedToCartSuccessFully();
}

class AddToCartError extends HomeState {
  const AddToCartError();
}

class HomeLoadedErrorState extends HomeState {
  final String message;
  const HomeLoadedErrorState(this.message);
}
class HomeCartValueState extends HomeState {
  final String value;
  const HomeCartValueState(this.value);
}

class HomeCartItemsLoaded extends HomeState {
  final List<CartModel> cartItems;
  const HomeCartItemsLoaded(this.cartItems);
}

class UserLocationState extends HomeState {
  final String location;
  const UserLocationState(this.location);
}

class HomeCategoryLoadedState extends HomeState {
  final List<CategoryData> response;
  const HomeCategoryLoadedState(this.response);
}

class MenuProductListLoaded extends HomeState {
  final ProductData? response;
  const MenuProductListLoaded(this.response);
}




