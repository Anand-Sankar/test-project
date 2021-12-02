import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tes_project/home/cubit/home_cubit.dart';
import 'package:tes_project/home/repository/home_repository.dart';
import 'package:tes_project/home/view/home_screen.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    navigateToHomePage();
  }

  navigateToHomePage() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BlocProvider(
                    create: (context) => HomeCubit(HomeRepository()),
                    child: const HomeScreen(),
                  ),
              settings: const RouteSettings(name: "Home Page")));
    });
  }

  @override
  Widget build(BuildContext context) {
    return  const SafeArea(
        child: Scaffold(
      body:  Center(
        child: Icon(
          Icons.food_bank,
          size: 100,
          color: Colors.red,
        ),
      ),
    ));
  }


}
