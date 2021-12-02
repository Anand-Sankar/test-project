import 'package:bloc/bloc.dart';
import 'package:objectbox/objectbox.dart';
import 'package:tes_project/cart/cubit/cart_state.dart';
import 'package:tes_project/cart/repository/cart_repository.dart';
import 'package:tes_project/home/model/cart_model.dart';
import 'package:tes_project/main.dart';
import 'package:tes_project/objectbox.g.dart';

class CartCubit extends Cubit<CartState> {

  final CartRepository _cartRepository;

  CartCubit(this._cartRepository) : super(const CartInitialState());

   getCart() async{
    try {
      print("e");
      List<CartModel> items = _cartRepository.getCartItems();
      print("${items.length}");
      await Future<void>.delayed(const Duration(microseconds: 1));
      num sum = 0;
      for (CartModel cartModel in items){
        sum += cartModel.count * cartModel.price;
      }
      emit(CartLoadedSuccessfullyState(items,sum));
      print("h");
    } catch (e) {
      print("g");
      emit( CartErrorState());
    }
  }

  void updateCart({
    required CartModel cartModel, required bool isIncreased
  }) async {
    try {
      final store = objectbox.store;
      final box = store.box<CartModel>();
      Query<CartModel> query = box.query(
          CartModel_.itemID.equals(cartModel.itemID)).build();
      List<CartModel> itemList = query.find();
      var person = itemList.first;
      isIncreased ? (person.count++) : (person.count--);
      (person.count>=1) ?box.put(person) : box.remove(person.id);
      query.close();
      await Future<void>.delayed(const Duration(microseconds: 1));
      emit(const CartUpdatedState());
    } catch (e) {
      emit(const CartErrorState());
    }
  }
}