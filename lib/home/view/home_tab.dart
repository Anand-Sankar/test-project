import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tes_project/home/cubit/home_cubit.dart';
import 'package:tes_project/home/cubit/home_state.dart';
import 'package:tes_project/home/model/cart_model.dart';
import 'package:tes_project/home/model/category_response.dart';
import 'package:tes_project/home/model/home_list_response.dart';
import 'package:tes_project/main.dart';
import 'package:tes_project/objectbox.g.dart';
import 'package:tes_project/utils/object_box.dart';
import 'package:tes_project/utils/shared_preference.dart';

class HomeTab extends StatefulWidget {

  final Function(bool val) updateParentView;
  final Function(int val) moveToMenuTab;
  const HomeTab({Key? key,required this.moveToMenuTab,required this.updateParentView}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<CategoryData> menuItems = [];
  List<FeaturedProducts> featuredProducts = [];
  List<BestsellerProducts> bestSellerProducts = [];
  List<AdditionalBanners> additionalBanner = [];
  List<SliderBanners> sliderBanner = [];
  bool isLoading = false;
  BestsellerProducts? selectedItem;
  late String userLocation = "";

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getHomeDataList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
        // provide the local bloc instance

        listener: (context, state) {
          if (state is HomeLoadedState) {
            sliderBanner = state.response.sliderBanners;
            additionalBanner = state.response.additionalBanners;
            featuredProducts = state.response.featuredProducts;
            bestSellerProducts = state.response.bestsellerProducts;
            setState(() {
              isLoading = false;
            });
            context.read<HomeCubit>().getHomeCategoryList();
          } else if (state is HomeCategoryLoadedState) {
            setState(() {
              menuItems = state.response;
              isLoading = false;
            });
            context.read<HomeCubit>().getUserLocation();
            print(menuItems.length);
          }else if (state is AddedToCartSuccessFully){
            setState(() {

            });
            widget.updateParentView(false);
          }else if(state is UserLocationState){
            userLocation = state.location;
            SharedPreference.shared.saveUserLocation(userLocation);
            setState(() {

            });
          }else if(state is AddToCartError){

          }
        },
        child: SafeArea(
          child: Scaffold(
            body: (!isLoading)
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleText("Deliver to"),
                          const SizedBox(
                            height: 5,
                          ),
                          locationText("Anand Sankar, ${userLocation}"),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 4,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 150.0,
                            child: ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: sliderBanner.length,
                              itemBuilder: (context, index) => Card(
                                child: Center(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.network(
                                          sliderBanner[index].bannerImg,
                                          fit: BoxFit.cover,
                                          width: 300,
                                        ))),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          menuItems.isNotEmpty
                              ? addMenuWidget()
                              : const Offstage(),
                          titleText("Featured"),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 200.0,
                            child: ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: featuredProducts.length,
                              itemBuilder: (context, index) {
                                var item = featuredProducts[index];
                                return ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Card(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8)),
                                            child: Image.network(
                                              item.image,
                                              fit: BoxFit.cover,
                                              width: 200,
                                              height: 100,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      item.isVeg == "1"
                                                          ? "assets/images/veg_icon.png"
                                                          : "assets/images/non_veg.png",
                                                      width: 10,
                                                      fit: BoxFit.cover,
                                                      height: 10,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    titleText(item.name)
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                   InkWell(
                                                        onTap: () {
                                                          context.read<HomeCubit>().addToCart(
                                                            itemId: item.id,
                                                              itemName: item.name,
                                                              price: item.specialPrice
                                                                          .toString() ==
                                                                      "0"
                                                                  ? double.parse(
                                                                      item.price)
                                                                  : double.parse(item
                                                                      .specialPrice),
                                                              count: 1);
                                                        },
                                                        child: addButtonWidget(
                                                            item) ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        priceText(
                                                            item.specialPrice
                                                                .toString(),
                                                            item.price
                                                                .toString()),
                                                        const SizedBox(
                                                          height: 3,
                                                        ),
                                                        item.variations.isEmpty
                                                            ? Text(
                                                                "Options available",
                                                                style: GoogleFonts
                                                                    .roboto(
                                                                  fontSize: 12,
                                                                  color:
                                                                      Colors.grey,
                                                                ),
                                                              )
                                                            : const Offstage()
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: additionalBanner.length,
                            itemBuilder: (context, index) => Card(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    additionalBanner[index].bannerImg,
                                    fit: BoxFit.cover,
                                    width: 300,
                                    height: 100,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          titleText("Bestseller"),
                          Column(
                            children: bestSellerProducts.map((e) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              e.image,
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      e.isVeg == "1"
                                                          ? "assets/images/veg_icon.png"
                                                          : "assets/images/non_veg.png",
                                                      width: 10,
                                                      fit: BoxFit.cover,
                                                      height: 10,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    titleText(e.name)
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          context.read<HomeCubit>().addToCart(
                                                            itemId: e.id,
                                                              itemName: e.name,
                                                              price: e.specialPrice
                                                                          .toString() ==
                                                                      "0"
                                                                  ? double.parse(
                                                                      e.price)
                                                                  : double.parse(e
                                                                      .specialPrice),
                                                              count: 1);
                                                        },
                                                        child:
                                                        addButtonWidget(e)),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        priceText(
                                                            e.specialPrice
                                                                .toString(),
                                                            e.price.toString()),
                                                        const SizedBox(
                                                          height: 3,
                                                        ),
                                                        e.variations.isEmpty
                                                            ? Text(
                                                                "Options available",
                                                                style: GoogleFonts
                                                                    .roboto(
                                                                  fontSize: 12,
                                                                  color:
                                                                      Colors.grey,
                                                                ),
                                                              )
                                                            : const Offstage()
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const Icon(
                                            Icons.favorite,
                                            color: Colors.grey,
                                          )
                                        ],
                                      )),
                                ),
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                    color: Colors.red,
                  )),
          ),
        ));
    ;
  }

  Widget priceText(String specialPrice, String price) {
    var actualPrice = specialPrice == "0" ? price : specialPrice;
    return Row(
      children: [
        Text(
          "C\$ ${actualPrice.toString()}",
          style: GoogleFonts.roboto(
              fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 10,
        ),
        specialPrice != "0"
            ? Text(
                "C\$ ${price.toString()}",
                style: GoogleFonts.roboto(
                    fontSize: 12,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey),
              )
            : const Offstage()
      ],
    );
  }



  Widget locationText(String location) {
    return Text(location,
        style: GoogleFonts.roboto(
            color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400));
  }

  Widget addMenuWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText("Explore menu"),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 125.0,
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              var menuItem = menuItems[index];
              var noImage =
                  "https://archive.org/download/no-photo-available/no-photo-available.png";
              print("catimg $index : ${menuItem.catImg}");
              return Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                        widget.moveToMenuTab(index);
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                menuItem.catImg ?? noImage,
                                fit: BoxFit.fill,
                                width: 90,
                                height: 65,
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        menuItems[index].catName,
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget addButtonWidget(var item) {
    return Container(
        width: 50,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.red,
        ),
        child: Center(
          child: Text("Add",
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(color: Colors.white),
              )),
        ));
  }

  Widget titleText(String title) {
    return Text(title,
        style: GoogleFonts.roboto(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold));
  }
}
