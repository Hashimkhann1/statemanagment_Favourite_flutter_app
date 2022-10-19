


import 'package:favourite_flutter/utils/colorResources.dart';
import 'package:flutter/cupertino.dart';

class BottomNavigatorProvider with ChangeNotifier {
  int CurrentIndex = 0;


  void navigatePage(int index) {
    CurrentIndex = index;
    notifyListeners();
  }
}