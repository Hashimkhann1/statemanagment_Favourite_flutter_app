import 'package:favourite_flutter/utils/colorResources.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton({required this.btnTitle, this.pressed,this.btnPadding,this.btnTextColor,this.btnBackgroundColor,this.btnTextFontWeight,this.btnTextSize});

  String? btnTitle;
  VoidCallback? pressed;
  EdgeInsets? btnPadding;
  Color? btnTextColor;
  Color? btnBackgroundColor;
  FontWeight? btnTextFontWeight;
  double? btnTextSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: btnBackgroundColor,
        padding: btnPadding,
      ),

        onPressed: pressed,
        child: Text(btnTitle.toString(),style: TextStyle(
          color: btnTextColor,
          fontWeight: btnTextFontWeight,
          fontSize: btnTextSize
        ),));
  }
}
