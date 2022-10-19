
import 'package:favourite_flutter/provider/bottomNavigatorProvider.dart';
import 'package:favourite_flutter/utils/colorResources.dart';
import 'package:favourite_flutter/view/home.dart';
import 'package:favourite_flutter/view/items_data/add_items.dart';
import 'package:favourite_flutter/view/items_data/my_favourite.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigator extends StatefulWidget {
  BottomNavigator({Key? key}) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {

  List Pages = [
    Home(),
    MyFavourite(),
    AddItems()
  ];

  // int currentIndex = 0;
  void OnTap(int index){

  }

  @override
  Widget build(BuildContext context) {
    final navigatorPageProvider = Provider.of<BottomNavigatorProvider>(context,listen: false);
    print('build');
    return SafeArea(
        child: Scaffold(
      body: Consumer<BottomNavigatorProvider>(builder: (context,value,child){
        return Pages[value.CurrentIndex];
      },),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorResource.whiteColor,
        onTap: navigatorPageProvider.navigatePage,
        currentIndex: navigatorPageProvider.CurrentIndex,
        selectedItemColor: ColorResource.blackColor,
        unselectedItemColor: ColorResource.lightGrayColor,
        items: [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'My favourite', icon: Icon(Icons.person)),
          BottomNavigationBarItem(label: 'Add item', icon: Icon(Icons.image))
        ],
      ),
    ));
  }
}
