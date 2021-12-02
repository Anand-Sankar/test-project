import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tes_project/cart/cubit/cart_cubit.dart';
import 'package:tes_project/cart/cubit/cart_state.dart';
import 'package:tes_project/home/model/cart_model.dart';
import 'package:tes_project/utils/shared_preference.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  TextEditingController noteController = TextEditingController();

  List<CartModel> cartItems = [];
  String? userLocation = "";
  num cartValue = 0.00;

  @override
  void initState() {
    super.initState();
    loadCart();
    getUserLocation();
  }

  loadCart() {
    context.read<CartCubit>().getCart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartLoadedSuccessfullyState) {
          print("length is ${cartItems.length}");
          cartItems.clear();
          cartItems.addAll(state.allCartItems);
          cartValue = state.value;
          print("length is ${cartItems.length}");
          setState(() {});
        } else if (state is CartUpdatedState) {
          loadCart();
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Summary",
                  style: GoogleFonts.roboto(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: noteController,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Note eg: add some sauce",
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 15, bottom: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cartItems[index].name,
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              updateCart(index, false);
                                            },
                                            child: const Icon(
                                              Icons.remove,
                                              color: Colors.black,
                                              size: 14,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${cartItems[index].count}",
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              updateCart(index, true);
                                            },
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.black,
                                              size: 14,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Text(
                                    "C\$ ${(cartItems[index].price * cartItems[index].count)}",
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: Colors.grey.withAlpha(100),
                              thickness: 1,
                            )
                          ],
                        );
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Item total",
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Total",
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "C\$ ${cartValue.toStringAsFixed(2)}",
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "C\$ ${getValueIncTax()}",
                          style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    )
                  ],
                ),
               Expanded(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   children: [
                     Text(
                       'Address',
                       style: GoogleFonts.roboto(
                           fontSize: 16,
                           color: Colors.black,
                           fontWeight: FontWeight.bold),
                     ),
                     const SizedBox(
                       height: 10,
                     ),
                     SizedBox(
                       height: 50,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             userLocation!,
                             style: GoogleFonts.roboto(
                                 fontSize: 14,
                                 color: Colors.grey,
                                 fontWeight: FontWeight.w400),
                           ),
                           Text(
                             "change",
                             style: GoogleFonts.roboto(
                                 fontSize: 14,
                                 color: Colors.red,
                                 fontWeight: FontWeight.w400),
                           ),
                         ],
                       ),
                     ),
                     const SizedBox(
                       height: 10,
                     ),
                     ElevatedButton(
                       onPressed: () {},
                       style: ElevatedButton.styleFrom(
                         primary: Colors.red,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(5),
                         ),
                         elevation: 5.0,
                       ),
                       child: const Padding(
                         padding: EdgeInsets.all(10.0),
                         child: Text(
                           'PROCEED TO PAYMENT',
                           style: TextStyle(fontSize: 16),
                         ),
                       ),
                     ),
                   ],
                 ),
               )
              ],
            ),
          ),
        ),
      ),
    );
  }

  updateCart(int index, bool updateStatus) {
    context
        .read<CartCubit>()
        .updateCart(cartModel: cartItems[index], isIncreased: updateStatus);
  }

  getValueIncTax() {
    double sum = cartValue + (cartValue * (0.12));
    return sum.toStringAsFixed(2);
  }

  getUserLocation() async {
    userLocation = await SharedPreference.shared.getUserLocation();
    setState(() {

    });
  }
}
