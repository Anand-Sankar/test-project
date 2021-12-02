import 'package:flutter/material.dart';
import 'package:tes_project/home/view/title_widget.dart';
import 'package:tes_project/utils/constant.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.search,
            size: 25,
            color: Colors.grey,
          ),
          TitleWidget(title: "Search")
        ],
      ),
    );
  }
}
