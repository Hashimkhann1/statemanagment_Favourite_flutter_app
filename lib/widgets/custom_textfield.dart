import 'package:favourite_flutter/utils/colorResources.dart';
import 'package:flutter/material.dart';


class CustomTextfield extends StatelessWidget {
  CustomTextfield({required this.hintText,this.icon,this.fieldValueChanged});
  String? hintText;
  Icon? icon;
  ValueChanged<String>? fieldValueChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: fieldValueChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 18.0
        ),
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorResource.lightGrayColor,width: 2.0)
        ),
          focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorResource.primaryColor,width: 2.0)
          ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorResource.lightGrayColor,width: 2.0)
        )
      ),
    );
  }
}
