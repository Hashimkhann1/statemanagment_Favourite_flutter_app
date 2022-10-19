import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  AppText({required this.title,this.textColor,this.textSize,this.textFontWeight});

  String? title;
  Color? textColor;
  double? textSize;
  FontWeight? textFontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(title.toString() , style: TextStyle(
      color: textColor,
      fontSize: textSize,
        fontWeight: textFontWeight
    ),);
  }
}
