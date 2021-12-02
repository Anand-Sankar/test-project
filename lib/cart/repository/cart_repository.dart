
import 'package:tes_project/home/model/cart_model.dart';
import 'package:tes_project/main.dart';

class CartRepository {
  List<CartModel> getCartItems() {
    var store = objectbox.store;
    var box = store.box<CartModel>();
    return box.getAll();
  }

}