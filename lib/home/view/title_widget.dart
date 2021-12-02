import 'package:flutter/material.dart';
import 'package:tes_project/utils/constant.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: commonTextStyle,
    );
  }
}
