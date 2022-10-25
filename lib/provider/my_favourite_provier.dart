import 'package:flutter/material.dart';


class MyFavouriteProvider with ChangeNotifier{

  List _favouriteItems = [];
  List get favouriteItems => _favouriteItems;


  void addItem(String itemName,String itemPrice, String imageUrl) {
    // selectedItems['itemName'] = itemName;
    // selectedItems['itemPrice'] = itemPrice;
    // selectedItems['imageUrl'] = imageUrl;
    Map selectedItems = {
      'itemName' : itemName,
      'itemPrice' : itemPrice,
      'imageUrl' : imageUrl,
    };
    _favouriteItems.add(selectedItems);
    // print(favouriteItems);

    // print(selectedItems);
    // ChangeNotifier();
    notifyListeners();
  }

  void removeItem() {}
}