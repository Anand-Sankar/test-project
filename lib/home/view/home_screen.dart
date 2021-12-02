import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tes_project/cart/cubit/cart_cubit.dart';
import 'package:tes_project/cart/repository/cart_repository.dart';
import 'package:tes_project/cart/view/cart_view.dart';
import 'package:tes_project/home/cubit/home_cubit.dart';
import 'package:tes_project/home/cubit/home_state.dart';
import 'package:tes_project/home/model/cart_model.dart';
import 'package:tes_project/home/repository/home_repository.dart';
import 'package:tes_project/home/view/account_tab.dart';
import 'package:tes_project/home/view/home_tab.dart';
import 'package:tes_project/home/view/menu_tab.dart';
import 'package:tes_project/home/view/search_tab.dart';
import 'package:tes_project/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  String cartValue = "";
  late TabController tabController;
  int tabIndex= 0;
  @override
  void initState() {
    super.initState();
    initPages();
    loadCartItems();
  }

  animateToTab(int index){
    initPages();
    _selectedIndex = 1;
    setState(() {

    });
  }

  int _selectedIndex = 0;
  late List<Widget> _pages ;
  late List<CartModel> items = [];

  bool isCartEmpty = true;
  bool isLoading = false;

  Widget createTabBlocProvider(buildTab) {
    return BlocProvider(
        create: (context) => HomeCubit(HomeRepository()), child: buildTab);
  }

  loadCartItems() {
    context.read<HomeCubit>().getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeLoadingState) {
            setState(() {
              isLoading = true;
            });
          }else if (state is HomeCartValueState) {
            cartValue = state.value;
            setState(() {

            });
          }else if(state is HomeCartItemsLoaded){
            items = state.cartItems;
            if (items.isNotEmpty) {
              isCartEmpty = false;
              context.read<HomeCubit>().getCartValue(items: items);
            }else{
              setState(() {
                isCartEmpty = true;
              });
            }
          }
        },
        child: SafeArea(
            child: Scaffold(
          body: Center(
            child: Column(
              children: [
                Expanded(child: _pages.elementAt(_selectedIndex)),
                !isCartEmpty
                    ? InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => CartCubit(
                            CartRepository(),
                          ),
                          child: const CartView(),
                        ),
                        settings: const RouteSettings(
                            name: "Cart View"))).then((value) =>
                        loadCartItems()
                    );
                  },
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                          height: 40,
                          color: Colors.red,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${items.length} item(s) in cart C\$ ${cartValue}",
                                style: GoogleFonts.roboto(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Text(
                                "view cart",
                                style: GoogleFonts.roboto(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                    )
                    : const Offstage()
              ],
            ), //New
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: _onItemTapped,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.grey,
            currentIndex: _selectedIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: "Menu",
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                  ),
                  label: "Search"),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Account",
              ),
            ],
          ),
        )));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initPages() {
    _pages =[
      createTabBlocProvider(HomeTab(
        moveToMenuTab: (value){
          tabIndex = value;
          setState(() {

          });
          animateToTab(value);
        },
        updateParentView: (value) {
          loadCartItems();
        },
      )),
      createTabBlocProvider( MenuTab( selectedTab: tabIndex,updateParentView: (value) {
        loadCartItems();
      },)),
      createTabBlocProvider(const SearchTab()),
      createTabBlocProvider(const AccountTab())
    ];
  }

}
