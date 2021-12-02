import 'package:flutter/material.dart';
import 'package:tes_project/home/view/title_widget.dart';


class AccountTab extends StatelessWidget {
  const AccountTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.settings,
            size: 25,
            color: Colors.grey,
          ),
          TitleWidget(title: "Account")
        ],
      ),
    );
  }
}
