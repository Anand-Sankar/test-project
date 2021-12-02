import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tes_project/home/cubit/home_cubit.dart';
import 'package:tes_project/home/cubit/home_state.dart';
import 'package:tes_project/home/model/category_response.dart';
import 'package:tes_project/home/model/product_list_request.dart';
import 'package:tes_project/home/model/product_list_response.dart';
import 'package:tes_project/home/view/title_widget.dart';
import 'package:tes_project/utils/constant.dart';

class MenuTab extends StatefulWidget {

  final Function(bool val) updateParentView;

  final int selectedTab;
  const MenuTab({Key? key,required this.selectedTab,required this.updateParentView}) : super(key: key);

  @override
  State<MenuTab> createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> with SingleTickerProviderStateMixin {

  List<CategoryData> menuItems = [];
  bool isLoading = false;
  late TabController tabController;
  int index = 0;
  ProductData? productData ;

  @override
  void initState() {
    super.initState();
    print("menu tab ${widget.selectedTab}");
    loadMenuCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeCategoryLoadedState) {
            setState(() {
              menuItems = state.response;
              isLoading = false;
            });
            tabController =
                TabController(
                    length: menuItems.length, vsync: this, initialIndex: 0);
            if(widget.selectedTab!=0){
              tabController.animateTo(widget.selectedTab);
            }
            loadProducts();
            tabController.addListener(() {
              index = tabController.index;
              loadProducts();
            });
          } else if (state is MenuProductListLoaded) {
            productData = state.response;
            setState(() {
              
            });
          }else if (state is AddedToCartSuccessFully){
            setState(() {

            });
            widget.updateParentView(false);
          }
        },
        child: SafeArea(
          child: Scaffold(
            body: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.red,
                automaticallyImplyLeading: false,
                title: Text(
                  "Explore menu",
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
              body: menuItems.isNotEmpty ? Column(
                children: [
                  TabBar(
                    indicatorColor: Colors.red,
                    labelColor: Colors.red,
                    unselectedLabelColor: Colors.grey,
                    controller: tabController,
                    isScrollable: true,
                    tabs: List<Widget>.generate(menuItems.length, (int index) {
                      return Tab(
                          child: Text(menuItems[index].catName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0)));
                    }),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: List<Widget>.generate(menuItems.length,
                              (int index) {
                            return productData != null ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: productData!.products!.length,
                              itemBuilder: (context, index) {
                                var product = productData!.products![index];
                                var noImage =
                                    "https://www.food4fuel.com/wp-content/uploads/woocommerce-placeholder-600x600.png";
                                print("catimg $index : ${product.image}");
                                return Padding(
                                  padding: const EdgeInsets.only(top: 5.0,right: 10,left: 10),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          15.0),
                                      child: Card(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                const BorderRadius.only(topRight: Radius.circular(8.0),topLeft: Radius.circular(8.0)),
                                                child: Image.network(
                                                  product.image ?? noImage,
                                                  height: 150,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(15.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          product.isVeg == "1"
                                                              ? "assets/images/veg_icon.png"
                                                              : "assets/images/non_veg.png",
                                                          width: 10,
                                                          fit: BoxFit.cover,
                                                          height: 10,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        titleText(product.name!)
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            priceText(
                                                                product.specialPrice
                                                                    .toString(),
                                                                product.price.toString()),
                                                            const SizedBox(
                                                              height: 3,
                                                            ),
                                                            product.variations.isNotEmpty
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
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        InkWell(
                                                            onTap: () {
                                                              context.read<HomeCubit>().addToCart(
                                                                  itemId: product.id!,
                                                                  itemName: product.name!,
                                                                  price: product.specialPrice
                                                                      .toString() ==
                                                                      "0"
                                                                      ? double.parse(
                                                                      product.price)
                                                                      : double.parse(product
                                                                      .specialPrice),
                                                                  count: 1);
                                                            },
                                                            child:
                                                            addButtonWidget(product)),

                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                );
                              },
                            ) : Offstage();
                          }),
                    ),
                  )
                ],
              ) : const Offstage(),
            ),
          ),
        ));
  }

  Widget addButtonWidget(var item) {
    return Container(
        width: 60,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.red,
        ),
        child: Center(
          child: Text("Add",
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 14
              )),
        ));
  }

  Widget titleText(String title) {
    return Text(title,
        style: GoogleFonts.roboto(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold));
  }

  void loadMenuCategories() {
    context.read<HomeCubit>().getHomeCategoryList();
  }

  void loadProducts() {

    ProductListRequest _productListRequest = ProductListRequest(
        currentpage: 1,
        pagesize: 100,
        sortorder: Sortorder(
          direction: "desc",
          field: menuItems[index].catName
        ),
        searchstring: "",
        filter: Filter(
          Category: "${menuItems[index].catId}"
        ));
    print(_productListRequest.toJson());
    context.read<HomeCubit>().getProductList(body: _productListRequest.toJson());
  }

  Widget priceText(String specialPrice, String price) {
    var actualPrice = specialPrice == "0" ? price : specialPrice;
    return Row(
      children: [
        Text(
          "C\$ ${actualPrice.toString()}",
          style: GoogleFonts.roboto(
              fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 10,
        ),
        specialPrice != "0"
            ? Text(
          "C\$ ${price.toString()}",
          style: GoogleFonts.roboto(
              fontSize: 14,
              decoration: TextDecoration.lineThrough,
              color: Colors.grey),
        )
            : const Offstage()
      ],
    );
  }
}
