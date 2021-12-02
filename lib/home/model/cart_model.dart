
import 'package:objectbox/objectbox.dart';

@Entity()
class CartModel {
  int id;
  double price;
  String name;
  int count;
  int itemID;

  CartModel({this.id = 0,required this.itemID, required this.price, required this.name,required this.count});
}
