import 'package:flutter/material.dart';


class MyFavouriteProvider with ChangeNotifier{

  Map selectedItems = {};

  void addItem(String itemName,String itemPrice, String imageUrl) {
    selectedItems['itemName'] = itemName;
    selectedItems['itemPrice'] = itemPrice;
    selectedItems['imageUrl'] = imageUrl;

    print(selectedItems);
    ChangeNotifier();
  }

  void removeItem() {}
}