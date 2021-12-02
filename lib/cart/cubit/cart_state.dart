
import 'package:tes_project/home/model/cart_model.dart';

abstract class CartState {
  const CartState();
}

class CartInitialState extends CartState {
  const CartInitialState();
}

class CartLoadingState extends CartState {
  const CartLoadingState();
}

class CartLoadedSuccessfullyState extends CartState {
  final List<CartModel> allCartItems;
  final num value;
  const CartLoadedSuccessfullyState(this.allCartItems,this.value);
}
class CartUpdatedState extends CartState {
  const CartUpdatedState();
}
class CartErrorState extends CartState {
  const CartErrorState();
}
